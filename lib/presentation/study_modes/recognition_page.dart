import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/sentence_generator/sentence_generator_bloc.dart';
import 'package:kanpractice/application/study_mode/study_mode_bloc.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/widgets/kp_learning_header_animation.dart';
import 'package:kanpractice/presentation/core/widgets/kp_learning_text_box.dart';
import 'package:kanpractice/presentation/core/widgets/kp_list_percentage_indicator.dart';
import 'package:kanpractice/presentation/core/widgets/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/widgets/kp_study_mode_app_bar.dart';
import 'package:kanpractice/presentation/core/widgets/kp_tts_icon_button.dart';
import 'package:kanpractice/presentation/core/widgets/kp_validation_buttons.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/study_modes/utils/mode_arguments.dart';
import 'package:kanpractice/presentation/study_modes/utils/study_mode_update_handler.dart';
import 'package:kanpractice/presentation/study_modes/widgets/context_button.dart';
import 'package:kanpractice/presentation/study_modes/widgets/context_loader.dart';
import 'package:kanpractice/presentation/study_modes/widgets/context_loading.dart';
import 'package:kanpractice/presentation/study_modes/widgets/context_widget.dart';

class RecognitionStudy extends StatefulWidget {
  final ModeArguments args;
  const RecognitionStudy({Key? key, required this.args}) : super(key: key);

  @override
  State<RecognitionStudy> createState() => _RecognitionStudyState();
}

class _RecognitionStudyState extends State<RecognitionStudy> {
  /// Current word index
  int _macro = 0;

  bool _showMeaning = false;
  bool _hasFinished = false;
  bool _enableRepOnTest = false;

  /// Array that saves all scores without any previous context for the test result
  final List<double> _testScores = [];

  /// Widget auxiliary variable
  final List<Word> _studyList = [];

  final String _none = "wildcard".tr();

  bool get _hasRepetition => !widget.args.isTest || _enableRepOnTest;
  bool _enableSpacedRepetition(double score) =>
      (!widget.args.isTest && score < 0.5) || (_enableRepOnTest && score < 0.5);

  @override
  void initState() {
    _enableRepOnTest = getIt<PreferencesService>()
        .readData(SharedKeys.enableRepetitionOnTests);
    _studyList.addAll(widget.args.studyList);
    context.read<StudyModeBloc>().add(StudyModeEventResetTracking());
    super.initState();
  }

  Future<void> _updateUIOnSubmit(double score) async {
    /// If the score is less PARTIAL or WRONG and the Learning Mode is
    /// SPATIAL, the append the current word to the list, to review it again.
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
      final code = !condition ? await _calculateWordScore(score) : 0;

      /// If everything went well, and we have words left in the list,
      /// update _macro to the next one.
      if (code == 0) {
        if (_macro < _studyList.length - 1) {
          setState(() {
            _macro++;
            _showMeaning = false;
          });

          if (!mounted) return;

          context
              .read<SentenceGeneratorBloc>()
              .add(SentenceGeneratorEventReset());
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
      await StudyModeUpdateHandler.handle(context, widget.args,
          testScore: score, testScores: _testScores);
    } else {
      await StudyModeUpdateHandler.handle(context, widget.args);
    }
  }

  Future<int> _calculateWordScore(double score) async {
    /// Add the current virgin score to the test scores...
    if (widget.args.isTest) {
      if (getIt<PreferencesService>().readData(SharedKeys.affectOnPractice) ??
          false) {
        context.read<StudyModeBloc>().add(StudyModeEventCalculateScore(
              widget.args.mode,
              _studyList[_macro],
              score,
              isTest: true,
            ));
      }
      _testScores.add(score);
      if (widget.args.testMode == Tests.daily) {
        context.read<StudyModeBloc>().add(StudyModeEventCalculateSM2Params(
            widget.args.mode, _studyList[_macro], score));
      }
    } else {
      context.read<StudyModeBloc>().add(StudyModeEventCalculateScore(
          widget.args.mode, _studyList[_macro], score));
    }
    return 0;
  }

  String _getProperPronunciation() {
    /// Based on the states, update the meaning
    if (_showMeaning) {
      return _studyList[_macro].pronunciation;
    } else {
      return "";
    }
  }

  String _getProperMeaning() {
    /// Based on the states, update the meaning
    if (_showMeaning) {
      return _studyList[_macro].meaning;
    } else {
      return _none;
    }
  }

  @override
  Widget build(BuildContext context) {
    return KPScaffold(
        onWillPop: () async {
          return StudyModeUpdateHandler.handle(
            context,
            widget.args,
            onPop: true,
            lastIndex: _macro,
          );
        },
        appBarTitle: StudyModeAppBar(
            title: widget.args.studyModeHeaderDisplayName,
            studyMode: widget.args.mode.mode),
        centerTitle: true,
        appBarActions: [
          Visibility(
            visible: _showMeaning,
            child: TTSIconButton(word: _studyList[_macro].pronunciation),
          ),
          if (_hasRepetition && widget.args.testMode != Tests.daily)
            IconButton(
              onPressed: () => Utils.showSpatialRepetitionDisclaimer(context),
              icon: const Icon(Icons.info_outline_rounded),
            )
        ],
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                KPListPercentageIndicator(
                    value: (_macro + 1) / _studyList.length),
                KPLearningHeaderAnimation(
                  id: _macro,
                  child: ContextLoader(
                    word: _studyList[_macro].word,
                    mode: StudyModes.recognition,
                    loading: _body(null, isLoading: true),
                    child: _body,
                  ),
                ),
                if (!_showMeaning) ContextButton(word: _studyList[_macro].word),
              ],
            ),
            KPValidationButtons(
              trigger: _showMeaning,
              submitLabel: "done_button_label".tr(),
              action: (score) async => await _updateUIOnSubmit(score),
              onSubmit: () => setState(() => _showMeaning = true),
            )
          ],
        ));
  }

  Widget _body(String? sentence, {bool isLoading = false}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          KPLearningTextBox(
              textStyle: Theme.of(context).textTheme.bodyLarge,
              text: _getProperPronunciation()),
          FittedBox(
            child: KPLearningTextBox(
                textStyle: Theme.of(context).textTheme.displaySmall,
                text: _studyList[_macro].word),
          ),
          if (isLoading) const ContextLoading(),
          if (sentence != null)
            ContextWidget(
              word: _studyList[_macro].word,
              showWord: _showMeaning,
              sentence: sentence,
              mode: StudyModes.recognition,
            ),
          KPLearningTextBox(
            text: _getProperMeaning(),
            top: KPMargins.margin8,
            textStyle: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
