import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/add_kanji/add_kanji_bloc.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/presentation/core/types/word_categories.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/presentation/add_word_page/arguments.dart';
import 'package:kanpractice/presentation/core/ui/kp_kanji_category_list.dart';
import 'package:kanpractice/presentation/core/ui/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/ui/kp_text_form.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/dictionary_page/arguments.dart';

class AddWordPage extends StatefulWidget {
  final AddWordArgs args;
  const AddWordPage({Key? key, required this.args}) : super(key: key);

  @override
  State<AddWordPage> createState() => _AddWordPageState();
}

class _AddWordPageState extends State<AddWordPage> {
  TextEditingController? _kanjiController;
  FocusNode? _kanjiFocus;
  TextEditingController? _pronunciationController;
  FocusNode? _pronunciationFocus;
  TextEditingController? _meaningController;
  FocusNode? _meaningFocus;

  WordCategory _currentCategory = WordCategory.noun;

  @override
  void initState() {
    _kanjiController = TextEditingController();
    _kanjiFocus = FocusNode();
    _pronunciationController = TextEditingController();
    _pronunciationFocus = FocusNode();
    _meaningController = TextEditingController();
    _meaningFocus = FocusNode();
    Word? kanji = widget.args.word;
    if (kanji != null) {
      _kanjiController?.text = kanji.word.toString();
      _pronunciationController?.text = kanji.pronunciation.toString();
      _meaningController?.text = kanji.meaning.toString();
      _currentCategory = WordCategory.values[kanji.category];
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

  Future<void> _createKanji(BuildContext bloc, {bool exit = true}) async {
    bloc.read<AddKanjiBloc>().add(AddKanjiEventCreate(
        exitMode: exit,
        kanji: Word(
          word: _kanjiController?.text ?? "",
          pronunciation: _pronunciationController?.text ?? "",
          meaning: _meaningController?.text ?? "",
          listName: widget.args.listName,
          category: _currentCategory.index,
          dateAdded: Utils.getCurrentMilliseconds(),
          dateLastShown: Utils.getCurrentMilliseconds(),
        )));
  }

  Future<void> _updateKanji(BuildContext bloc) async {
    Word? k = widget.args.word;
    if (k != null) {
      bloc
          .read<AddKanjiBloc>()
          .add(AddKanjiEventUpdate(widget.args.listName, k.word, parameters: {
            WordTableFields.wordField: _kanjiController?.text ?? "",
            WordTableFields.pronunciationField:
                _pronunciationController?.text ?? "",
            WordTableFields.meaningField: _meaningController?.text ?? "",
            WordTableFields.categoryField: _currentCategory.index
          }));
    }
  }

  _validateKanji(Function execute) {
    if (_kanjiController?.text.trim().isNotEmpty == true &&
        _pronunciationController?.text.trim().isNotEmpty == true &&
        _meaningController?.text.trim().isNotEmpty == true) {
      execute();
    } else {
      Utils.getSnackBar(context, "add_kanji_validateKanji_failed".tr());
    }
  }

  _clearFocus() {
    _kanjiFocus?.unfocus();
    _meaningFocus?.unfocus();
    _pronunciationFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddKanjiBloc>(
      create: (_) => AddKanjiBloc()..add(AddKanjiEventIdle()),
      child: KPScaffold(
        resizeToAvoidBottomInset: true,
        appBarTitle: widget.args.word != null
            ? "add_kanji_update_title".tr()
            : "add_kanji_new_title".tr(),
        appBarActions: [
          IconButton(
            icon: const Icon(Icons.create_rounded),
            onPressed: () async {
              _clearFocus();

              /// If we are updating the kanji, pass over to the dictionary
              /// the word
              /// If not, just go to the next page
              String? kanji = _kanjiController?.text;
              final drawnWord = await Navigator.of(context).pushNamed(
                  KanPracticePages.dictionaryPage,
                  arguments:
                      DictionaryArguments(searchInJisho: false, word: kanji));

              /// We wait for the pop and update the _kanjiController with the
              /// new drawn word. If it is empty, do not override the current
              /// input word (if any)
              final String? word = drawnWord as String?;
              if (word != null && word.isNotEmpty) {
                _kanjiController?.text = word;
              }
            },
          ),
          BlocBuilder<AddKanjiBloc, AddKanjiState>(
            builder: (context, state) => Visibility(
              visible: widget.args.word == null,
              child: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  _validateKanji(() => _createKanji(context, exit: false));
                },
              ),
            ),
          ),
          BlocBuilder<AddKanjiBloc, AddKanjiState>(
              builder: (context, state) => IconButton(
                    icon: const Icon(Icons.check_rounded),
                    onPressed: () {
                      _validateKanji(() {
                        if (widget.args.word != null) {
                          _updateKanji(context);
                        } else {
                          _createKanji(context);
                        }
                      });
                    },
                  ))
        ],
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: KPMargins.margin8),
              child: _builder()),
        ),
      ),
    );
  }

  BlocListener _builder() {
    return BlocListener<AddKanjiBloc, AddKanjiState>(
      listener: (context, state) {
        if (state is AddKanjiStateDoneCreating) {
          /// If exit is true, only one kanji should be created and exit
          if (state.exitMode) {
            Navigator.of(context).pop(0);
          } else {
            _kanjiController?.clear();
            _pronunciationController?.clear();
            _meaningController?.clear();
            _kanjiFocus?.requestFocus();
          }
        } else if (state is AddKanjiStateDoneUpdating) {
          Navigator.of(context).pop(0);
        } else if (state is AddKanjiStateFailure) {
          Utils.getSnackBar(context, state.message);
        }
      },
      child: _body(),
    );
  }

  Widget _body() {
    return Column(
      children: [
        KPTextForm(
          controller: _kanjiController,
          focusNode: _kanjiFocus,
          header: "add_kanji_textForm_kanji".tr(),
          additionalWidget: ElevatedButton(
            onPressed: () {
              _pronunciationController?.text = _kanjiController?.text ?? "";
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 4,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text("add_kanji_copy".tr(),
                    style: Theme.of(context).textTheme.button),
              ),
            ),
          ),
          centerText: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline3
              ?.copyWith(fontWeight: FontWeight.bold),
          autofocus: widget.args.word == null,
          hint: "add_kanji_textForm_kanji_ext".tr(),
          onEditingComplete: () => _pronunciationFocus?.requestFocus(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: KPMargins.margin16),
          child: KPTextForm(
            controller: _pronunciationController,
            focusNode: _pronunciationFocus,
            header: "add_kanji_textForm_reading".tr(),
            hint: "add_kanji_textForm_reading_ext".tr(),
            onEditingComplete: () => _meaningFocus?.requestFocus(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: KPMargins.margin16),
          child: _categorySelection(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: KPMargins.margin16),
          child: BlocBuilder<AddKanjiBloc, AddKanjiState>(
            builder: (context, state) => KPTextForm(
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
                  if (widget.args.word == null) {
                    _createKanji(context, exit: false);
                  } else {
                    _updateKanji(context);
                  }
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Column _categorySelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              bottom: KPMargins.margin16, left: KPMargins.margin8),
          child: Text("kanji_category_label".tr(),
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline6),
        ),
        KPKanjiCategoryList(
            selected: (index) => index == _currentCategory.index,
            onSelected: (index) =>
                setState(() => _currentCategory = WordCategory.values[index]))
      ],
    );
  }
}
