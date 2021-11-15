import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/ui/pages/add_kanji/arguments.dart';
import 'package:kanpractice/ui/theme/theme_consts.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/ui/widgets/CustomTextForm.dart';

class AddKanjiPage extends StatefulWidget {
  final AddKanjiArgs args;
  const AddKanjiPage({required this.args});

  @override
  _AddKanjiPageState createState() => _AddKanjiPageState();
}

class _AddKanjiPageState extends State<AddKanjiPage> {
  TextEditingController _kanjiController = TextEditingController();
  FocusNode _kanjiFocus = FocusNode();
  TextEditingController _pronunciationController = TextEditingController();
  FocusNode _pronunciationFocus = FocusNode();
  TextEditingController _meaningController = TextEditingController();
  FocusNode _meaningFocus = FocusNode();

  @override
  void initState() {
    Kanji? kanji = widget.args.kanji;
    if (kanji != null) {
      _kanjiController.text = kanji.kanji.toString();
      _pronunciationController.text = kanji.pronunciation.toString();
      _meaningController.text = kanji.meaning.toString();
    }
    super.initState();
  }

  @override
  void dispose() {
    _kanjiController.dispose();
    _kanjiFocus.dispose();
    _pronunciationController.dispose();
    _pronunciationFocus.dispose();
    _meaningController.dispose();
    _meaningFocus.dispose();
    super.dispose();
  }

  Future<void> _createKanji({bool exit = true}) async {
    final code = await KanjiQueries.instance.createKanji(Kanji(
        kanji: _kanjiController.text,
        pronunciation: _pronunciationController.text,
        meaning: _meaningController.text,
        listName: widget.args.listName,
        dateAdded: GeneralUtils.getCurrentMilliseconds()
    ));
    if (code == 0) {
      /// If exit is true, only one kanji should be created and exit
      if (exit) Navigator.of(context).pop(0);
      /// If false, a new kanji could be added, so empty the fields
      else {
        _kanjiController.clear();
        _pronunciationController.clear();
        _meaningController.clear();
        _kanjiFocus.requestFocus();
      }
    }
    else if (code == -1) GeneralUtils.getSnackBar(context, "Error creating kanji");
    else GeneralUtils.getSnackBar(context, "Generic error creating kanji");
  }

  Future<void> _updateKanji() async {
    Kanji? k = widget.args.kanji;
    if (k != null) {
      final code = await KanjiQueries.instance.updateKanji(
          widget.args.listName,
          k.kanji,
          Kanji(
            kanji: _kanjiController.text,
            pronunciation: _pronunciationController.text,
            meaning: _meaningController.text,
            listName: widget.args.listName,
            winRateWriting: k.winRateWriting,
            winRateReading: k.winRateReading,
            winRateRecognition: k.winRateRecognition,
            dateAdded: k.dateAdded
          ).toJson()
      );
      if (code == 0) Navigator.of(context).pop(0);
      else if (code == -1) GeneralUtils.getSnackBar(context, "Error updating kanji");
      else GeneralUtils.getSnackBar(context, "Generic error updating kanji");
    }
  }

  _validateKanji(Function execute) {
    if (_kanjiController.text.trim().isNotEmpty &&
        _pronunciationController.text.trim().isNotEmpty &&
        _meaningController.text.trim().isNotEmpty)
      execute();
    else
      GeneralUtils.getSnackBar(context, "Fill up the form correctly");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: appBarHeight,
        title: Text(widget.args.kanji != null ? "Update Kanji" : "Add Kanji", overflow: TextOverflow.ellipsis)
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: _body()
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
          header: "Kanji Form",
          centerText: TextAlign.center,
          fontSize: 64,
          autofocus: widget.args.kanji == null,
          bold: FontWeight.bold,
          hint: "家具",
          onEditingComplete: () => _pronunciationFocus.requestFocus(),
        ),
        Padding(
          padding: EdgeInsets.only(top: 32),
          child: CustomTextForm(
            controller: _pronunciationController,
            focusNode: _pronunciationFocus,
            header: "Pronunciation",
            hint: "かぐ",
            onEditingComplete: () => _meaningFocus.requestFocus(),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 32),
          child: CustomTextForm(
            controller: _meaningController,
            focusNode: _meaningFocus,
            header: "Meaning",
            hint: "Furniture",
            action: TextInputAction.done,
            onEditingComplete: () => _meaningFocus.unfocus(),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: widget.args.kanji == null
                ? MainAxisAlignment.spaceAround : MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _validateKanji(() {
                    if (widget.args.kanji != null) _updateKanji();
                    else _createKanji();
                  });
                },
                child: Text("Save Kanji"),
              ),
              Visibility(
                visible: widget.args.kanji == null,
                child: ElevatedButton(
                  onPressed: () => _validateKanji(() => _createKanji(exit: false)),
                  child: Text("Add Another Kanji"),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
