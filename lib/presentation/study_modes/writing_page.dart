import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/study_mode/study_mode_bloc.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/ui/canvas/kp_custom_canvas.dart';
import 'package:kanpractice/presentation/core/ui/kp_learning_header_animation.dart';
import 'package:kanpractice/presentation/core/ui/kp_learning_header_container.dart';
import 'package:kanpractice/presentation/core/ui/kp_list_percentage_indicator.dart';
import 'package:kanpractice/presentation/core/ui/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/ui/kp_study_mode_app_bar.dart';
import 'package:kanpractice/presentation/core/ui/kp_tts_icon_button.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/study_modes/utils/mode_arguments.dart';
import 'package:kanpractice/presentation/study_modes/utils/study_mode_update_handler.dart';
import 'package:kanpractice/presentation/study_modes/widgets/writing_buttons_animation.dart';

class WritingStudy extends StatefulWidget {
  final ModeArguments args;
  const WritingStudy({Key? key, required this.args}) : super(key: key);

  @override
  State<WritingStudy> createState() => _WritingStudyState();
}

class _WritingStudyState extends State<WritingStudy> {
  /// Current drawn line in the canvas
  List<Offset?> _line = [];

  /// Matrix for displaying each individual kanji once validated
  final List<List<String>> _currentKanji = [];

  /// Array that saves all scores without any previous context for the test result
  final List<double> _testScores = [];

  /// Score granted for each individual kanji of the word
  final List<double> _score = [];

  /// Maximum score the user can achieve on a certain word
  final List<double> _maxScore = [];

  /// Current word index
  int _macro = 0;

  /// Current kanji within word index
  int _inner = 0;

  bool _showActualKanji = false;
  bool _goNextKanji = false;
  bool _hasFinished = false;

  final String _none = "wildcard".tr();

  /// Widget auxiliary variable
  final List<Word> _studyList = [];

  @override
  void initState() {
    _studyList.addAll(widget.args.studyList);
    _initAuxKanjiArray();
    super.initState();
  }

  _initAuxKanjiArray() {
    /// Clears all arrays if previously defined
    _currentKanji.clear();
    _score.clear();
    _maxScore.clear();

    /// For every word:
    ///   - Add the current score of the word
    ///   - Add an empty array for displaying the kanji
    ///   - Add the maximum score the user can have in this word
    /// For each kanji:
    ///   - Add a " ? " string to the _currentKanji matrix which we will
    ///     later use for displaying each individual kanji once validated
    for (int x = 0; x < _studyList.length; x++) {
      _initScoreArray(x);
    }
  }

  _initScoreArray(int x) {
    String kanji = _studyList[x].word;
    _score.add(0);
    _currentKanji.add([]);
    _maxScore.add(kanji.length.toDouble());
    for (int y = 0; y < kanji.length; y++) {
      _currentKanji[x].add(_none);
    }
  }

  _updateUIOnSubmit(double score) {
    /// Update the macro of the word with the current score of each kanji
    _score[_macro] += score;

    setState(() {
      /// When done, show the kanji in the header
      /// Update the _inner index
      /// And if the current _inner index is the last one of the word, go to the next word
      _showActualKanji = false;
      _inner++;
      if (_inner == _studyList[_macro].word.length) _goNextKanji = true;
    });

    /// Empty the current canvas
    _clear();
  }

  _resetKanji() async {
    /// If we are done with the current word...
    if (_goNextKanji) {
      /// If the score is less PARTIAL or WRONG and the Learning Mode is
      /// SPATIAL, the append the current word to the list, to review it again.
      /// Only do this when NOT on test
      final double score = _score[_macro] / _maxScore[_macro];
      if (!widget.args.isTest && score < 0.5) {
        _studyList.add(_studyList[_macro]);
        _initScoreArray(_studyList.length - 1);
      }

      if (_hasFinished) {
        await _handleFinishedPractice();
      } else {
        /// Empty the current canvas
        _clear();

        /// Calculate the current score IF the word is within the initial
        /// set of words. If the current word is above that, using SPATIAL
        /// repetition, then do NOT calculate the score and return 0 directly.
        final condition =
            !widget.args.isTest && _macro >= widget.args.studyList.length;
        final code = !condition ? await _calculateKanjiScore() : 0;

        /// If everything went well, and we have words left in the list,
        /// update _macro to the next one and reset _inner.
        if (code == 0) {
          if (_macro < _studyList.length - 1) {
            setState(() {
              _macro++;
              _inner = 0;
              _goNextKanji = false;
            });
          }

          /// If we ended the list, update the statistics to DB and exit
          else {
            await _handleFinishedPractice();
          }
        }
      }
    }

    /// If we are within a word with various kanji, show the current one.
    else {
      setState(() {
        _showActualKanji = true;
        _currentKanji[_macro][_inner] = _studyList[_macro].word[_inner];
      });
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

  Future<int> _calculateKanjiScore() async {
    getIt<StudyModeBloc>().add(StudyModeEventUpdateDateShown(
        listName: _studyList[_macro].listName, word: _studyList[_macro].word));
    final double currentScore = _score[_macro] / _maxScore[_macro];

    /// Add the current virgin score to the test scores...
    if (widget.args.isTest) {
      if (getIt<PreferencesService>().readData(SharedKeys.affectOnPractice) ??
          false) {
        getIt<StudyModeBloc>().add(StudyModeEventCalculateScore(
            widget.args.mode, _studyList[_macro], currentScore));
      }
      _testScores.add(currentScore);
    } else {
      getIt<StudyModeBloc>().add(StudyModeEventCalculateScore(
          widget.args.mode, _studyList[_macro], currentScore));
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
          setGestureDetector: false,
          appBarTitle: StudyModeAppBar(
              title: widget.args.studyModeHeaderDisplayName,
              studyMode: widget.args.mode.mode),
          centerTitle: true,
          appBarActions: [
            Visibility(
              visible: _goNextKanji,
              child: TTSIconButton(word: _studyList[_macro].pronunciation),
            ),
            if (!widget.args.isTest)
              IconButton(
                onPressed: () => Utils.showSpatialRepetitionDisclaimer(context),
                icon: const Icon(Icons.info_outline_rounded),
              )
          ],
          child: Column(
            children: [
              KPListPercentageIndicator(
                  value: (_macro + 1) / _studyList.length),
              KPLearningHeaderAnimation(id: _macro, children: _header()),
              KPCustomCanvas(line: _line, allowEdit: !_showActualKanji),
              WritingButtonsAnimations(
                id: _macro,

                /// Whenever a new kanji is shown, _inner will be 0. That's
                /// the key to toggle the slide animation on the button.
                triggerSlide: _inner == 0,
                trigger: _showActualKanji,
                submitLabel: _goNextKanji
                    ? "writing_next_kanji_label".tr()
                    : "done_button_label".tr(),
                wrongAction: (score) async => await _updateUIOnSubmit(score),
                midWrongAction: (score) async => await _updateUIOnSubmit(score),
                midPerfectAction: (score) async =>
                    await _updateUIOnSubmit(score),
                perfectAction: (score) async => await _updateUIOnSubmit(score),
                onSubmit: () {
                  if (_macro <= _studyList.length - 1) {
                    _resetKanji();
                  } else {
                    if (_line.isNotEmpty) {
                      _resetKanji();
                    } else {
                      Utils.getSnackBar(
                          context, "writing_validation_failed".tr());
                    }
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }

  List<Widget> _header() {
    double finalHeight =
        MediaQuery.of(context).size.height < KPSizes.minimumHeight
            ? KPSizes.listStudyHeight / 3
            : KPSizes.listStudyHeight;
    return [
      KPLearningHeaderContainer(
          height: KPSizes.defaultSizeLearningExtContainer + KPMargins.margin8,
          text: _goNextKanji ? _studyList[_macro].pronunciation : ""),
      SizedBox(
        height: finalHeight,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _studyList[_macro].word.length,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            String? kanji = _studyList[_macro].word;
            return Text(
                _currentKanji[_macro][index] == _none ? _none : kanji[index],
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height <
                            KPSizes.minimumHeight
                        ? KPFontSizes.fontSize24
                        : KPFontSizes.fontSize64,
                    color: index == _inner ? KPColors.secondaryColor : null));
          },
        ),
      ),
      KPLearningHeaderContainer(
        height: KPSizes.defaultSizeLearningExtContainer,
        text: _studyList[_macro].meaning,
        top: KPMargins.margin8,
      ),
    ];
  }

  _clear() => setState(() => _line = []);
}
