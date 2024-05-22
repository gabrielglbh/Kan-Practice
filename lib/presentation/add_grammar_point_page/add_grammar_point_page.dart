import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/add_grammar_point/add_grammar_point_bloc.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/application/snackbar/snackbar_bloc.dart';
import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/add_grammar_point_page/arguments.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/core/widgets/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/widgets/kp_text_form.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';

class AddGrammarPage extends StatefulWidget {
  final AddGrammarPointArgs args;
  const AddGrammarPage({super.key, required this.args});

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

  String _replaceDashesWithCommas(String s) => s.replaceAll('/', ',');

  @override
  void initState() {
    _nameController = TextEditingController();
    _nameFocus = FocusNode();
    _definitionController = TextEditingController();
    _definitionFocus = FocusNode();
    _exampleController = TextEditingController();
    _exampleFocus = FocusNode();
    GrammarPoint? grammarPoint = widget.args.grammarPoint;
    if (grammarPoint != null) {
      _nameController?.text = grammarPoint.name.toString();
      _definitionController?.text = grammarPoint.definition.toString();
      _exampleController?.text = grammarPoint.example.toString();
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

  Future<void> _createGrammar(BuildContext bloc, {bool exit = true}) async {
    String name = _nameController?.text ?? '';
    if ('\n'.allMatches(name).isEmpty) name = '#### __${name}__';
    bloc.read<AddGrammarPointBloc>().add(AddGrammarPointEventCreate(
        exitMode: exit,
        grammarPoint: GrammarPoint(
          name: _replaceDashesWithCommas(name),
          definition:
              _replaceDashesWithCommas(_definitionController?.text ?? ""),
          example: _replaceDashesWithCommas(_exampleController?.text ?? ""),
          listName: widget.args.listName,
          dateAdded: Utils.getCurrentMilliseconds(),
          dateLastShown: Utils.getCurrentMilliseconds(),
        )));
  }

  Future<void> _updateGrammar(BuildContext bloc) async {
    GrammarPoint? g = widget.args.grammarPoint;
    if (g != null) {
      bloc.read<AddGrammarPointBloc>().add(
            AddGrammarPointEventUpdate(
              widget.args.listName,
              g.name,
              parameters: {
                GrammarTableFields.nameField:
                    _replaceDashesWithCommas(_nameController?.text ?? ""),
                GrammarTableFields.definitionField:
                    _replaceDashesWithCommas(_definitionController?.text ?? ""),
                GrammarTableFields.exampleField:
                    _replaceDashesWithCommas(_exampleController?.text ?? "")
              },
            ),
          );
    }
  }

  _validateGrammar(Function execute) {
    if (_nameController?.text.trim().isNotEmpty == true &&
        _definitionController?.text.trim().isNotEmpty == true &&
        _exampleController?.text.trim().isNotEmpty == true) {
      execute();
    } else {
      context
          .read<SnackbarBloc>()
          .add(SnackbarEventShow("add_grammar_validateGrammar_failed".tr()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AddGrammarPointBloc>(),
      child: KPScaffold(
        resizeToAvoidBottomInset: true,
        appBarTitle: widget.args.grammarPoint != null
            ? "add_grammar_update_title".tr()
            : "add_grammar_new_title".tr(),
        appBarActions: [
          BlocBuilder<AddGrammarPointBloc, AddGrammarPointState>(
            builder: (context, state) => Visibility(
              visible: widget.args.grammarPoint == null,
              child: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  _validateGrammar(() => _createGrammar(context, exit: false));
                },
              ),
            ),
          ),
          BlocBuilder<AddGrammarPointBloc, AddGrammarPointState>(
              builder: (context, state) => IconButton(
                    icon: const Icon(Icons.check_rounded),
                    onPressed: () {
                      _validateGrammar(() {
                        if (widget.args.grammarPoint != null) {
                          _updateGrammar(context);
                        } else {
                          _createGrammar(context);
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
    return BlocListener<AddGrammarPointBloc, AddGrammarPointState>(
      listener: (context, state) {
        state.mapOrNull(creationDone: (cd) {
          /// If exit is true, only one grammar point should be created and exit
          if (cd.exitMode) {
            Navigator.of(context).pop(0);
          } else {
            _nameController?.clear();
            _definitionController?.clear();
            _exampleController?.clear();
            _nameFocus?.requestFocus();
          }
        }, updateDone: (_) {
          Navigator.of(context).pop(0);
        }, error: (error) {
          context.read<SnackbarBloc>().add(SnackbarEventShow(error.message));
        });
      },
      child: Column(
        children: [
          KPTextForm(
            controller: _nameController,
            focusNode: _nameFocus,
            action: TextInputAction.newline,
            inputType: TextInputType.multiline,
            header: "add_grammar_textForm_grammar".tr(),
            autofocus: widget.args.grammarPoint == null,
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
            child: KPTextForm(
              controller: _exampleController,
              focusNode: _exampleFocus,
              action: TextInputAction.newline,
              inputType: TextInputType.multiline,
              maxLength: 128,
              header: "add_grammar_textForm_example".tr(),
              hint: "add_grammar_textForm_example_ext".tr(),
              onEditingComplete: () {},
            ),
          ),
          const SizedBox(height: KPMargins.margin8),
          GestureDetector(
            onTap: () async {
              await Utils.launch(context,
                  'https://docs.github.com/es/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#GitHub-flavored-markdown');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: KPMargins.margin4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(KPRadius.radius4),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "M",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.arrow_downward_rounded,
                        size: 16,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: KPMargins.margin8),
                Flexible(
                  child: Text(
                    "markdown_support".tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
