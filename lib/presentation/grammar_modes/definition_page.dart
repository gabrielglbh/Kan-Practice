import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/grammar_mode/grammar_mode_bloc.dart';
import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/presentation/core/types/grammar_modes.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/util/timer.dart';
import 'package:kanpractice/presentation/core/widgets/kp_learning_header_animation.dart';
import 'package:kanpractice/presentation/core/widgets/kp_list_percentage_indicator.dart';
import 'package:kanpractice/presentation/core/widgets/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/widgets/kp_study_mode_app_bar.dart';
import 'package:kanpractice/presentation/core/widgets/kp_validation_buttons.dart';
import 'package:kanpractice/presentation/core/widgets/kp_markdown.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/grammar_modes/utils/grammar_mode_arguments.dart';
import 'package:kanpractice/presentation/grammar_modes/utils/grammar_mode_update_handler.dart';

class DefinitionStudy extends StatefulWidget {
  final GrammarModeArguments args;
  const DefinitionStudy({super.key, required this.args});

  @override
  State<DefinitionStudy> createState() => _DefinitionStudyState();
}

class _DefinitionStudyState extends State<DefinitionStudy>
    with CustomPeriodicTimer {
  /// Current word index
  int _macro = 0;

  bool _showGrammarName = false;
  bool _hasFinished = false;
  bool _enableRepOnTest = false;

  /// Array that saves all scores without any previous context for the test result
  final List<double> _testScores = [];

  /// Widget auxiliary variable
  final List<GrammarPoint> _studyList = [];

  final String _none = "wildcard".tr();

  bool get _hasRepetition => !widget.args.isTest || _enableRepOnTest;
  bool _enableSpacedRepetition(double score) =>
      (!widget.args.isTest && score < 0.5) || (_enableRepOnTest && score < 0.5);

  @override
  void initState() {
    _enableRepOnTest = getIt<PreferencesService>()
        .readData(SharedKeys.enableRepetitionOnTests);
    _studyList.addAll(widget.args.studyList);
    context.read<GrammarModeBloc>().add(GrammarModeEventResetTracking());
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  Future<void> _updateUIOnSubmit(double score) async {
    /// If the score is less PARTIAL or WRONG and the Learning Mode is
    /// SPATIAL, the append the current word to the list, to review it again.
    /// Only do this when NOT on test
    if (_enableSpacedRepetition(score) && widget.args.testMode != Tests.daily) {
      _studyList.add(_studyList[_macro]);
    }

    if (_hasFinished) {
      await _handleFinishedPractice();
    } else {
      /// Calculate the current score IF the word is within the initial
      /// set of words. If the current word is above that, using SPATIAL
      /// repetition, then do NOT calculate the score and return 0 directly.
      final condition =
          _hasRepetition && _macro >= widget.args.studyList.length;
      final code = !condition ? await _calculateGrammarPointScore(score) : 0;

      /// If everything went well, and we have words left in the list,
      /// update _macro to the next one.
      if (code == 0) {
        if (_macro < _studyList.length - 1) {
          setState(() {
            _macro++;
            _showGrammarName = false;
          });
        }

        /// If we ended the list, update the statistics to DB and exit
        else {
          await _handleFinishedPractice();
        }
      }
    }
  }

  Future<void> _handleFinishedPractice() async {
    _hasFinished = true;

    /// If the user is in a test, explicitly pass the _testScores to the handler
    if (widget.args.isTest) {
      double testScore = 0;
      for (var s in _testScores) {
        testScore += s;
      }
      final score = testScore / _studyList.length;
      GrammarModeUpdateHandler.handle(
        context,
        widget.args,
        testScore: score,
        testScores: _testScores,
        timeObtained: elapsedTime,
      );
    } else {
      GrammarModeUpdateHandler.handle(context, widget.args);
    }
  }

  Future<int> _calculateGrammarPointScore(double score) async {
    /// Add the current virgin score to the test scores...
    if (widget.args.isTest) {
      if (getIt<PreferencesService>().readData(SharedKeys.affectOnPractice) ??
          false) {
        context.read<GrammarModeBloc>().add(GrammarModeEventCalculateScore(
              widget.args.mode,
              _studyList[_macro],
              score,
              isTest: true,
            ));
      }
      _testScores.add(score);
      if (widget.args.testMode == Tests.daily) {
        context.read<GrammarModeBloc>().add(GrammarModeEventCalculateSM2Params(
            widget.args.mode, _studyList[_macro], score));
      }
    } else {
      context.read<GrammarModeBloc>().add(GrammarModeEventCalculateScore(
          widget.args.mode, _studyList[_macro], score));
    }
    return 0;
  }

  String _getExample() {
    /// Based on the states, update the meaning
    if (_showGrammarName) {
      return _studyList[_macro].example;
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final hint = _showGrammarName
        ? "${_studyList[_macro].definition}\n\n"
            "_${"add_grammar_textForm_example".tr()}_\n\n"
            "${_getExample()}"
        : _studyList[_macro].definition;
    return KPScaffold(
      onWillPop: () async {
        return GrammarModeUpdateHandler.handle(
          context,
          widget.args,
          onPop: true,
          lastIndex: _macro,
        );
      },
      appBarTitle: StudyModeAppBar(
        title: widget.args.studyModeHeaderDisplayName,
        studyMode: widget.args.mode.mode,
        elapsedTime: elapsedTime,
      ),
      centerTitle: true,
      appBarActions: [
        if (_hasRepetition && widget.args.testMode != Tests.daily)
          IconButton(
            onPressed: () => Utils.showSpatialRepetitionDisclaimer(context),
            icon: const Icon(Icons.info_outline_rounded),
          )
      ],
      child: Column(
        children: [
          Column(
            children: [
              KPListPercentageIndicator(
                  value: (_macro + 1) / _studyList.length),
              KPLearningHeaderAnimation(
                id: _macro,
                child: Column(
                  children: [
                    if (_showGrammarName)
                      KPMarkdown(
                        data: _studyList[_macro].name,
                        maxHeight: KPMargins.margin64 * 2,
                        shrinkWrap: true,
                      )
                    else
                      Text(_none,
                          style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: KPMargins.margin4),
                    KPMarkdown(
                      data: hint,
                      maxHeight: MediaQuery.of(context).size.height / 4,
                      shrinkWrap: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
          KPValidationButtons(
            trigger: _showGrammarName,
            submitLabel: "done_button_label".tr(),
            action: (score) async => await _updateUIOnSubmit(score),
            onSubmit: () => setState(() => _showGrammarName = true),
          ),
        ],
      ),
    );
  }
}
