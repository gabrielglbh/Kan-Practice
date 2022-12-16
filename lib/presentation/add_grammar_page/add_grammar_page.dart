import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/add_word/add_word_bloc.dart';
import 'package:kanpractice/domain/grammar/grammar.dart';
import 'package:kanpractice/presentation/add_grammar_page/arguments.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/core/ui/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/ui/kp_text_form.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';

class AddGrammarPage extends StatefulWidget {
  final AddGrammarArgs args;
  const AddGrammarPage({Key? key, required this.args}) : super(key: key);

  @override
  State<AddGrammarPage> createState() => _AddGrammarPageState();
}

class _AddGrammarPageState extends State<AddGrammarPage> {
  TextEditingController? _nameController;
  FocusNode? _nameFocus;
  TextEditingController? _definitionController;
  FocusNode? _definitionFocus;
  TextEditingController? _exampleController;
  FocusNode? _exampleFocus;

  @override
  void initState() {
    _nameController = TextEditingController();
    _nameFocus = FocusNode();
    _definitionController = TextEditingController();
    _definitionFocus = FocusNode();
    _exampleController = TextEditingController();
    _exampleFocus = FocusNode();
    Grammar? grammar = widget.args.grammar;
    if (grammar != null) {
      _nameController?.text = grammar.name.toString();
      _definitionController?.text = grammar.definition.toString();
      _exampleController?.text = grammar.example.toString();
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameController?.dispose();
    _nameFocus?.dispose();
    _definitionController?.dispose();
    _definitionFocus?.dispose();
    _exampleController?.dispose();
    _exampleFocus?.dispose();
    super.dispose();
  }

  Future<void> _createGrammar({bool exit = true}) async {
    // TODO: Create grammar --> BLOC
    /*getIt<AddWordBloc>().add(AddWordEventCreate(
        exitMode: exit,
        word: Word(
          word: _nameController?.text ?? "",
          pronunciation: _definitionController?.text ?? "",
          meaning: _exampleController?.text ?? "",
          listName: widget.args.listName,
          category: _currentCategory.index,
          dateAdded: Utils.getCurrentMilliseconds(),
          dateLastShown: Utils.getCurrentMilliseconds(),
        )));*/
  }

  Future<void> _updateGrammar() async {
    Grammar? g = widget.args.grammar;
    // TODO: Update grammar --> BLOC
    /*if (k != null) {
      getIt<AddWordBloc>()
          .add(AddWordEventUpdate(widget.args.listName, k.word, parameters: {
        WordTableFields.wordField: _nameController?.text ?? "",
        WordTableFields.pronunciationField: _definitionController?.text ?? "",
        WordTableFields.meaningField: _exampleController?.text ?? "",
        WordTableFields.categoryField: _currentCategory.index
      }));
    }*/
  }

  _validateGrammar(Function execute) {
    if (_nameController?.text.trim().isNotEmpty == true &&
        _definitionController?.text.trim().isNotEmpty == true &&
        _exampleController?.text.trim().isNotEmpty == true) {
      execute();
    } else {
      Utils.getSnackBar(context, "add_grammar_validateGrammar_failed".tr());
    }
  }

  @override
  Widget build(BuildContext context) {
    return KPScaffold(
      resizeToAvoidBottomInset: true,
      appBarTitle: widget.args.grammar != null
          ? "add_grammar_update_title".tr()
          : "add_grammar_new_title".tr(),
      appBarActions: [
        // TODO: BLOC
        BlocBuilder<AddWordBloc, AddWordState>(
          builder: (context, state) => Visibility(
            visible: widget.args.grammar == null,
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                _validateGrammar(() => _createGrammar(exit: false));
              },
            ),
          ),
        ),
        BlocBuilder<AddWordBloc, AddWordState>(
            builder: (context, state) => IconButton(
                  icon: const Icon(Icons.check_rounded),
                  onPressed: () {
                    _validateGrammar(() {
                      if (widget.args.grammar != null) {
                        _updateGrammar();
                      } else {
                        _createGrammar();
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
        if (state is AddWordStateDoneCreating) {
          /// If exit is true, only one kanji should be created and exit
          if (state.exitMode) {
            Navigator.of(context).pop(0);
          } else {
            _nameController?.clear();
            _definitionController?.clear();
            _exampleController?.clear();
            _nameFocus?.requestFocus();
          }
        } else if (state is AddWordStateDoneUpdating) {
          Navigator.of(context).pop(0);
        } else if (state is AddWordStateFailure) {
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
          controller: _nameController,
          focusNode: _nameFocus,
          header: "add_grammar_textForm_grammar".tr(),
          autofocus: widget.args.grammar == null,
          hint: "add_grammar_textForm_grammar_ext".tr(),
          onEditingComplete: () => _definitionFocus?.requestFocus(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: KPMargins.margin16),
          child: KPTextForm(
            controller: _definitionController,
            focusNode: _definitionFocus,
            action: TextInputAction.newline,
            inputType: TextInputType.multiline,
            maxLength: 512,
            header: "add_grammar_textForm_definition".tr(),
            hint: "add_grammar_textForm_definition_ext".tr(),
            onEditingComplete: () => _exampleFocus?.requestFocus(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: KPMargins.margin16),
          child: BlocBuilder<AddWordBloc, AddWordState>(
            builder: (context, state) => KPTextForm(
              controller: _exampleController,
              focusNode: _exampleFocus,
              action: TextInputAction.newline,
              inputType: TextInputType.multiline,
              maxLength: 256,
              header: "add_grammar_textForm_example".tr(),
              hint: "add_grammar_textForm_example_ext".tr(),
              onEditingComplete: () {},
            ),
          ),
        ),
      ],
    );
  }
}
