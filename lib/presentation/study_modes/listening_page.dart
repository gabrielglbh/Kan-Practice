import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/application/services/text_to_speech_service.dart';
import 'package:kanpractice/application/study_mode/study_mode_bloc.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/ui/kp_learning_header_animation.dart';
import 'package:kanpractice/presentation/core/ui/kp_learning_header_container.dart';
import 'package:kanpractice/presentation/core/ui/kp_list_percentage_indicator.dart';
import 'package:kanpractice/presentation/core/ui/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/ui/kp_study_mode_app_bar.dart';
import 'package:kanpractice/presentation/core/ui/kp_tts_icon_button.dart';
import 'package:kanpractice/presentation/core/ui/kp_validation_buttons.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/study_modes/utils/mode_arguments.dart';
import 'package:kanpractice/presentation/study_modes/utils/study_mode_update_handler.dart';

class ListeningStudy extends StatefulWidget {
  final ModeArguments args;
  const ListeningStudy({Key? key, required this.args}) : super(key: key);

  @override
  State<ListeningStudy> createState() => _ListeningStudyState();
}

class _ListeningStudyState extends State<ListeningStudy> {
  /// Current word index
  int _macro = 0;

  bool _showWord = false;
  bool _hasFinished = false;

  /// Array that saves all scores without any previous context for the test result
  final List<double> _testScores = [];

  /// Widget auxiliary variable
  final List<Word> _studyList = [];

  @override
  void initState() {
    _studyList.addAll(widget.args.studyList);

    /// Execute the TTS when passing to the next kanji
    getIt<TextToSpeechService>().speakWord(_studyList[_macro].pronunciation);
    super.initState();
  }

  Future<void> _updateUIOnSubmit(double score) async {
    /// If the score is less PARTIAL or WRONG and the Learning Mode is
    /// SPATIAL, the append the current word to the list, to review it again.
    /// Only do this when NOT on test
    if (!widget.args.isTest && score < 0.5) {
      _studyList.add(_studyList[_macro]);
    }

    if (_hasFinished) {
      await _handleFinishedPractice();
    } else {
      /// Calculate the current score IF the word is within the initial
      /// set of words. If the current word is above that, using SPATIAL
      /// repetition, then do NOT calculate the score and return 0 directly.
      final condition =
          !widget.args.isTest && _macro >= widget.args.studyList.length;
      final code = !condition ? await _calculateKanjiScore(score) : 0;

      /// If everything went well, and we have words left in the list,
      /// update _macro to the next one.
      if (code == 0) {
        if (_macro < _studyList.length - 1) {
          setState(() {
            _macro++;
            _showWord = false;
          });

          /// Execute the TTS when passing to the next kanji
          await getIt<TextToSpeechService>()
              .speakWord(_studyList[_macro].pronunciation);
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

  Future<int> _calculateKanjiScore(double score) async {
    if (widget.args.isNumberTest) {
      /// If we are on a Number Test, just add the _testScores as the used numbers
      /// are not stored in the Database
      _testScores.add(score);
    } else {
      getIt<StudyModeBloc>().add(StudyModeEventUpdateDateShown(
          listName: _studyList[_macro].listName,
          word: _studyList[_macro].word));

      /// Add the current virgin score to the test scores...
      if (widget.args.isTest) {
        if (getIt<PreferencesService>().readData(SharedKeys.affectOnPractice) ??
            false) {
          getIt<StudyModeBloc>().add(StudyModeEventCalculateScore(
              widget.args.mode, _studyList[_macro], score));
        }
        _testScores.add(score);
      } else {
        getIt<StudyModeBloc>().add(StudyModeEventCalculateScore(
            widget.args.mode, _studyList[_macro], score));
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudyModeBloc, StudyModeState>(
      builder: (context, state) {
        return KPScaffold(
            onWillPop: () async {
              if (widget.args.testMode == Tests.daily) {
                Utils.getSnackBar(context, "daily_test_cannot_go_back".tr());
                return false;
              }

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
                visible: _showWord,
                child: TTSIconButton(word: _studyList[_macro].pronunciation),
              ),
              if (!widget.args.isTest)
                IconButton(
                  onPressed: () =>
                      Utils.showSpatialRepetitionDisclaimer(context),
                  icon: const Icon(Icons.info_outline_rounded),
                )
            ],
            child: Column(
              children: [
                Column(
                  children: [
                    KPListPercentageIndicator(
                        value: (_macro + 1) / _studyList.length),
                    KPLearningHeaderAnimation(id: _macro, children: _header()),
                  ],
                ),
                KPValidationButtons(
                  trigger: _showWord,
                  submitLabel: "done_button_label".tr(),
                  wrongAction: (score) async => await _updateUIOnSubmit(score),
                  midWrongAction: (score) async =>
                      await _updateUIOnSubmit(score),
                  midPerfectAction: (score) async =>
                      await _updateUIOnSubmit(score),
                  perfectAction: (score) async =>
                      await _updateUIOnSubmit(score),
                  onSubmit: () => setState(() => _showWord = true),
                )
              ],
            ));
      },
    );
  }

  List<Widget> _header() {
    return [
      Visibility(
        visible: _showWord,
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        child: KPLearningHeaderContainer(
          height: KPSizes.defaultSizeLearningExtContainer + KPMargins.margin8,
          text: _studyList[_macro].pronunciation,
        ),
      ),
      Visibility(
          visible: !_showWord,
          child: TTSIconButton(
              word: _studyList[_macro].pronunciation,
              iconSize: KPMargins.margin64 + KPMargins.margin4)),
      Visibility(
        visible: _showWord,
        child: KPLearningHeaderContainer(
          fontSize: KPFontSizes.fontSize64,
          height: KPSizes.listStudyHeight,
          text: _studyList[_macro].word,
        ),
      ),
      Visibility(
        visible: _showWord,
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        child: KPLearningHeaderContainer(
          height: KPSizes.defaultSizeLearningExtContainer,
          text: _studyList[_macro].meaning,
          top: KPMargins.margin8,
        ),
      )
    ];
  }
}