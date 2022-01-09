import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/ui/pages/add_kanji/arguments.dart';
import 'package:kanpractice/ui/pages/dictionary/arguments.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/ui/widgets/CustomTextForm.dart';
import 'package:easy_localization/easy_localization.dart';

class AddKanjiPage extends StatefulWidget {
  final AddKanjiArgs args;
  const AddKanjiPage({required this.args});

  @override
  _AddKanjiPageState createState() => _AddKanjiPageState();
}

class _AddKanjiPageState extends State<AddKanjiPage> {
  TextEditingController? _kanjiController;
  FocusNode? _kanjiFocus;
  TextEditingController? _pronunciationController;
  FocusNode? _pronunciationFocus;
  TextEditingController? _meaningController;
  FocusNode? _meaningFocus;

  @override
  void initState() {
    _kanjiController = TextEditingController();
    _kanjiFocus = FocusNode();
    _pronunciationController = TextEditingController();
    _pronunciationFocus = FocusNode();
    _meaningController = TextEditingController();
    _meaningFocus = FocusNode();
    Kanji? kanji = widget.args.kanji;
    if (kanji != null) {
      _kanjiController?.text = kanji.kanji.toString();
      _pronunciationController?.text = kanji.pronunciation.toString();
      _meaningController?.text = kanji.meaning.toString();
    }
    super.initState();
  }

  @override
  void dispose() {
    _kanjiController?.dispose();
    _kanjiFocus?.dispose();
    _pronunciationController?.dispose();
    _pronunciationFocus?.dispose();
    _meaningController?.dispose();
    _meaningFocus?.dispose();
    super.dispose();
  }

  Future<void> _createKanji({bool exit = true}) async {
    final code = await KanjiQueries.instance.createKanji(Kanji(
        kanji: _kanjiController?.text ?? "",
        pronunciation: _pronunciationController?.text ?? "",
        meaning: _meaningController?.text ?? "",
        listName: widget.args.listName,
        dateAdded: GeneralUtils.getCurrentMilliseconds(),
        dateLastShown: GeneralUtils.getCurrentMilliseconds(),
        dateLastShownWriting: GeneralUtils.getCurrentMilliseconds(),
        dateLastShownReading: GeneralUtils.getCurrentMilliseconds(),
        dateLastShownRecognition: GeneralUtils.getCurrentMilliseconds(),
        dateLastShownListening: GeneralUtils.getCurrentMilliseconds(),
    ));
    if (code == 0) {
      /// If exit is true, only one kanji should be created and exit
      if (exit) Navigator.of(context).pop(0);
      /// If false, a new kanji could be added, so empty the fields
      else {
        _kanjiController?.clear();
        _pronunciationController?.clear();
        _meaningController?.clear();
        _kanjiFocus?.requestFocus();
      }
    }
    else if (code == -1) GeneralUtils.getSnackBar(context, "add_kanji_createKanji_failed_insertion".tr());
    else GeneralUtils.getSnackBar(context, "add_kanji_createKanji_failed".tr());
  }

  Future<void> _updateKanji() async {
    Kanji? k = widget.args.kanji;
    if (k != null) {
      final code = await KanjiQueries.instance.updateKanji(
          widget.args.listName,
          k.kanji,
          Kanji(
            kanji: _kanjiController?.text ?? "",
            pronunciation: _pronunciationController?.text ?? "",
            meaning: _meaningController?.text ?? "",
            listName: widget.args.listName,
            winRateWriting: k.winRateWriting,
            winRateReading: k.winRateReading,
            winRateRecognition: k.winRateRecognition,
            dateAdded: k.dateAdded,
            dateLastShown: k.dateLastShown,
            dateLastShownWriting: k.dateLastShownWriting,
            dateLastShownReading: k.dateLastShownReading,
            dateLastShownRecognition: k.dateLastShownRecognition,
            dateLastShownListening: k.dateLastShownListening
          ).toJson()
      );
      if (code == 0) Navigator.of(context).pop(0);
      else if (code == -1) GeneralUtils.getSnackBar(context, "add_kanji_updateKanji_failed_update".tr());
      else GeneralUtils.getSnackBar(context, "add_kanji_updateKanji_failed".tr());
    }
  }

  _validateKanji(Function execute) {
    if (_kanjiController?.text.trim().isNotEmpty == true &&
        _pronunciationController?.text.trim().isNotEmpty == true &&
        _meaningController?.text.trim().isNotEmpty == true)
      execute();
    else
      GeneralUtils.getSnackBar(context, "add_kanji_validateKanji_failed".tr());
  }

  _clearFocus() {
    _kanjiFocus?.unfocus();
    _meaningFocus?.unfocus();
    _pronunciationFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _clearFocus(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: CustomSizes.appBarHeight,
          title: FittedBox(fit: BoxFit.fitWidth, child: Text(widget.args.kanji != null
              ? "add_kanji_update_title".tr()
              : "add_kanji_new_title".tr(), overflow: TextOverflow.ellipsis
          )),
          actions: [
            IconButton(
              icon: Icon(Icons.create_rounded),
              onPressed: () async {
                _clearFocus();
                /// If we are updating the kanji, pass over to the dictionary
                /// the word
                /// If not, just go to the next page
                String? kanji = _kanjiController?.text;
                final drawnWord = await Navigator.of(context).pushNamed(
                  KanPracticePages.dictionaryPage, arguments: DictionaryArguments(
                    searchInJisho: false, word: kanji != null ? kanji : null
                ));
                /// We wait for the pop and update the _kanjiController with the
                /// new drawn word. If it is empty, do not override the current
                /// input word (if any)
                final String? word = drawnWord as String?;
                if (word != null && word.isNotEmpty) _kanjiController?.text = word;
              },
            ),
            Visibility(
              visible: widget.args.kanji == null,
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  _validateKanji(() => _createKanji(exit: false));
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.check_rounded),
              onPressed: () {
                _validateKanji(() {
                  if (widget.args.kanji != null) _updateKanji();
                  else _createKanji();
                });
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(Margins.margin8),
            child: _body()
          ),
        ),
      ),
    );
  }

  _body() {
    return Column(
      children: [
        CustomTextForm(
          controller: _kanjiController,
          focusNode: _kanjiFocus,
          header: "add_kanji_textForm_kanji".tr(),
          additionalWidget: ElevatedButton(
            onPressed: () {
              _pronunciationController?.text = _kanjiController?.text ?? "";
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 4,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text("add_kanji_copy".tr()),
              ),
            ),
          ),
          centerText: TextAlign.center,
          fontSize: FontSizes.fontSize64,
          autofocus: widget.args.kanji == null,
          bold: FontWeight.bold,
          hint: "add_kanji_textForm_kanji_ext".tr(),
          onEditingComplete: () => _pronunciationFocus?.requestFocus(),
        ),
        Padding(
          padding: EdgeInsets.only(top: Margins.margin16),
          child: CustomTextForm(
            controller: _pronunciationController,
            focusNode: _pronunciationFocus,
            header: "add_kanji_textForm_reading".tr(),
            hint: "add_kanji_textForm_reading_ext".tr(),
            onEditingComplete: () => _meaningFocus?.requestFocus(),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: Margins.margin16),
          child: CustomTextForm(
            controller: _meaningController,
            focusNode: _meaningFocus,
            header: "add_kanji_textForm_meaning".tr(),
            hint: "add_kanji_textForm_meaning_ext".tr(),
            action: TextInputAction.done,
            onEditingComplete: () {
              _meaningFocus?.unfocus();
              /// By default, if the user is updating a word, and presses the IME action,
              /// update it. Else, create the word, empty the fields and continue adding
              /// more words
              _validateKanji(() {
                if (widget.args.kanji == null) _createKanji(exit: false);
                else _updateKanji();
              });
            },
          ),
        ),
      ],
    );
  }
}
