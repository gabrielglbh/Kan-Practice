import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/add_word/add_word_bloc.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/presentation/core/types/word_categories.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/presentation/add_word_page/arguments.dart';
import 'package:kanpractice/presentation/core/widgets/kp_word_category_list.dart';
import 'package:kanpractice/presentation/core/widgets/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/widgets/kp_text_form.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/dictionary_page/arguments.dart';

class AddWordPage extends StatefulWidget {
  final AddWordArgs args;
  const AddWordPage({super.key, required this.args});

  @override
  State<AddWordPage> createState() => _AddWordPageState();
}

class _AddWordPageState extends State<AddWordPage> {
  TextEditingController? _wordController;
  FocusNode? _wordFocus;
  TextEditingController? _pronunciationController;
  FocusNode? _pronunciationFocus;
  TextEditingController? _meaningController;
  FocusNode? _meaningFocus;

  WordCategory _currentCategory = WordCategory.noun;

  @override
  void initState() {
    _wordController = TextEditingController();
    _wordFocus = FocusNode();
    _pronunciationController = TextEditingController();
    _pronunciationFocus = FocusNode();
    _meaningController = TextEditingController();
    _meaningFocus = FocusNode();
    Word? word = widget.args.word;
    if (word != null) {
      _wordController?.text = word.word.toString();
      _pronunciationController?.text = word.pronunciation.toString();
      _meaningController?.text = word.meaning.toString();
      _currentCategory = WordCategory.values[word.category];
    }
    super.initState();
  }

  @override
  void dispose() {
    _wordController?.dispose();
    _wordFocus?.dispose();
    _pronunciationController?.dispose();
    _pronunciationFocus?.dispose();
    _meaningController?.dispose();
    _meaningFocus?.dispose();
    super.dispose();
  }

  Future<void> _createWord(BuildContext bloc, {bool exit = true}) async {
    bloc.read<AddWordBloc>().add(AddWordEventCreate(
        exitMode: exit,
        word: Word(
          word: _wordController?.text ?? "",
          pronunciation: _pronunciationController?.text ?? "",
          meaning: _meaningController?.text ?? "",
          listName: widget.args.listName,
          category: _currentCategory.index,
          dateAdded: Utils.getCurrentMilliseconds(),
          dateLastShown: Utils.getCurrentMilliseconds(),
        )));
  }

  Future<void> _updateWord(BuildContext bloc) async {
    Word? k = widget.args.word;
    if (k != null) {
      bloc
          .read<AddWordBloc>()
          .add(AddWordEventUpdate(widget.args.listName, k.word, parameters: {
            WordTableFields.wordField: _wordController?.text ?? "",
            WordTableFields.pronunciationField:
                _pronunciationController?.text ?? "",
            WordTableFields.meaningField: _meaningController?.text ?? "",
            WordTableFields.categoryField: _currentCategory.index
          }));
    }
  }

  _validateWord(Function execute) {
    if (_wordController?.text.trim().isNotEmpty == true &&
        _pronunciationController?.text.trim().isNotEmpty == true &&
        _meaningController?.text.trim().isNotEmpty == true) {
      execute();
    } else {
      Utils.getSnackBar(context, "add_word_validateWord_failed".tr());
    }
  }

  _clearFocus() {
    _wordFocus?.unfocus();
    _meaningFocus?.unfocus();
    _pronunciationFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return KPScaffold(
      resizeToAvoidBottomInset: true,
      appBarTitle: widget.args.word != null
          ? "add_word_update_title".tr()
          : "add_word_new_title".tr(),
      appBarActions: [
        IconButton(
          icon: const Icon(Icons.create_rounded),
          onPressed: () async {
            _clearFocus();

            /// If we are updating the word, pass over to the dictionary
            /// the word
            /// If not, just go to the next page
            String? wordText = _wordController?.text;
            final drawnWord = await Navigator.of(context).pushNamed(
                KanPracticePages.dictionaryPage,
                arguments:
                    DictionaryArguments(searchInJisho: false, word: wordText));

            /// We wait for the pop and update the _wordController with the
            /// new drawn word. If it is empty, do not override the current
            /// input word (if any)
            final String? word = drawnWord as String?;
            if (word != null && word.isNotEmpty) {
              _wordController?.text = word;
            }
          },
        ),
        BlocBuilder<AddWordBloc, AddWordState>(
          builder: (context, state) => Visibility(
            visible: widget.args.word == null,
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                _validateWord(() => _createWord(context, exit: false));
              },
            ),
          ),
        ),
        BlocBuilder<AddWordBloc, AddWordState>(
            builder: (context, state) => IconButton(
                  icon: const Icon(Icons.check_rounded),
                  onPressed: () {
                    _validateWord(() {
                      if (widget.args.word != null) {
                        _updateWord(context);
                      } else {
                        _createWord(context);
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
    );
  }

  BlocListener _builder() {
    return BlocListener<AddWordBloc, AddWordState>(
      listener: (context, state) {
        state.mapOrNull(
          creationDone: (cd) {
            /// If exit is true, only one word should be created and exit
            if (cd.exitMode) {
              Navigator.of(context).pop(0);
            } else {
              _wordController?.clear();
              _pronunciationController?.clear();
              _meaningController?.clear();
              _wordFocus?.requestFocus();
            }
          },
          updateDone: (_) {
            Navigator.of(context).pop(0);
          },
          error: (error) {
            Utils.getSnackBar(context, error.message);
          },
        );
      },
      child: Column(
        children: [
          KPTextForm(
            controller: _wordController,
            focusNode: _wordFocus,
            header: "add_word_textForm_word".tr(),
            additionalWidget: ElevatedButton(
              onPressed: () {
                _pronunciationController?.text = _wordController?.text ?? "";
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text("add_word_copy".tr(),
                      style: Theme.of(context).textTheme.labelLarge),
                ),
              ),
            ),
            centerText: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(fontWeight: FontWeight.bold),
            autofocus: widget.args.word == null,
            hint: "add_word_textForm_word_ext".tr(),
            onEditingComplete: () => _pronunciationFocus?.requestFocus(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: KPMargins.margin16),
            child: KPTextForm(
              controller: _pronunciationController,
              focusNode: _pronunciationFocus,
              header: "add_word_textForm_reading".tr(),
              hint: "add_word_textForm_reading_ext".tr(),
              onEditingComplete: () => _meaningFocus?.requestFocus(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: KPMargins.margin16),
            child: _categorySelection(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: KPMargins.margin16),
            child: KPTextForm(
              controller: _meaningController,
              focusNode: _meaningFocus,
              header: "add_word_textForm_meaning".tr(),
              hint: "add_word_textForm_meaning_ext".tr(),
              action: TextInputAction.done,
              onEditingComplete: () {
                _meaningFocus?.unfocus();

                /// By default, if the user is updating a word, and presses the IME action,
                /// update it. Else, create the word, empty the fields and continue adding
                /// more words
                _validateWord(() {
                  if (widget.args.word == null) {
                    _createWord(context, exit: false);
                  } else {
                    _updateWord(context);
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Column _categorySelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              bottom: KPMargins.margin16, left: KPMargins.margin8),
          child: Text("word_category_label".tr(),
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge),
        ),
        KPWordCategoryList(
            selected: (index) => index == _currentCategory.index,
            onSelected: (index) =>
                setState(() => _currentCategory = WordCategory.values[index]))
      ],
    );
  }
}
