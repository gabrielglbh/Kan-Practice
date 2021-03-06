import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/core/utils/study_modes/mode_arguments.dart';
import 'package:kanpractice/core/utils/study_modes/study_mode_update_handler.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/widgets/kp_learning_header_animation.dart';
import 'package:kanpractice/ui/widgets/kp_learning_header_container.dart';
import 'package:kanpractice/ui/widgets/kp_list_percentage_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/ui/widgets/kp_study_mode_app_bar.dart';
import 'package:kanpractice/ui/widgets/kp_tts_icon_button.dart';
import 'package:kanpractice/ui/widgets/kp_validation_buttons.dart';
import 'package:kanpractice/ui/widgets/kp_scaffold.dart';

class RecognitionStudy extends StatefulWidget {
  final ModeArguments args;
  const RecognitionStudy({Key? key, required this.args}) : super(key: key);

  @override
  _RecognitionStudyState createState() => _RecognitionStudyState();
}

class _RecognitionStudyState extends State<RecognitionStudy> {
  /// Current word index
  int _macro = 0;

  bool _showMeaning = false;
  bool _hasFinished = false;

  /// Array that saves all scores without any previous context for the test result
  final List<double> _testScores = [];

  /// Widget auxiliary variable
  List<Kanji> _studyList = [];

  final String _none = "wildcard".tr();

  @override
  void initState() {
    _studyList = widget.args.studyList;
    super.initState();
  }

  Future<void> _updateUIOnSubmit(double score) async {
    if (_hasFinished) {
      await _handleFinishedPractice();
    } else {
      /// Calculate the current score
      final code = await _calculateKanjiScore(score);

      /// If everything went well, and we have words left in the list,
      /// update _macro to the next one.
      if (code == 0) {
        if (_macro < _studyList.length - 1) {
          setState(() {
            _macro++;
            _showMeaning = false;
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
      await StudyModeUpdateHandler.handle(context, widget.args,
          testScore: score, testScores: _testScores);
    } else {
      await StudyModeUpdateHandler.handle(context, widget.args);
    }
  }

  Future<int> _calculateKanjiScore(double score) async {
    /// Updates the dateLastShown attribute of the finished word AND
    /// the current specific last shown mode attribute
    await KanjiQueries.instance.updateKanji(
        widget.args.studyList[_macro].listName,
        widget.args.studyList[_macro].kanji, {
      KanjiTableFields.dateLastShown: GeneralUtils.getCurrentMilliseconds(),
      KanjiTableFields.dateLastShownRecognition:
          GeneralUtils.getCurrentMilliseconds()
    });

    /// Add the current virgin score to the test scores...
    if (widget.args.isTest) {
      if (StorageManager.readData(StorageManager.affectOnPractice) ?? false) {
        await StudyModeUpdateHandler.calculateScore(widget.args, score, _macro);
      }
      _testScores.add(score);
    } else {
      await StudyModeUpdateHandler.calculateScore(widget.args, score, _macro);
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
        onWillPop: () async => StudyModeUpdateHandler.handle(
            context, widget.args, onPop: true, lastIndex: _macro),
        appBarTitle: StudyModeAppBar(
            title: widget.args.display, studyMode: widget.args.mode.mode),
        centerTitle: true,
        appBarActions: [
          Visibility(
            visible: _showMeaning,
            child: TTSIconButton(
                kanji: widget.args.studyList[_macro].pronunciation),
          )
        ],
        child: Stack(
          children: [
            Column(
              children: [
                KPListPercentageIndicator(
                    value: (_macro + 1) / _studyList.length),
                KPLearningHeaderAnimation(id: _macro, children: _header()),
              ],
            ),
            Positioned(
                bottom: Margins.margin64,
                right: 0,
                left: 0,
                child: KPValidationButtons(
                  trigger: _showMeaning,
                  submitLabel: "done_button_label".tr(),
                  wrongAction: (score) async => await _updateUIOnSubmit(score),
                  midWrongAction: (score) async =>
                      await _updateUIOnSubmit(score),
                  midPerfectAction: (score) async =>
                      await _updateUIOnSubmit(score),
                  perfectAction: (score) async =>
                      await _updateUIOnSubmit(score),
                  onSubmit: () => setState(() => _showMeaning = true),
                ))
          ],
        ));
  }

  List<Widget> _header() {
    return [
      KPLearningHeaderContainer(
          height: CustomSizes.defaultSizeLearningExtContainer + Margins.margin8,
          text: _getProperPronunciation()),
      KPLearningHeaderContainer(
          fontSize: FontSizes.fontSize64,
          height: CustomSizes.listStudyHeight,
          text: _studyList[_macro].kanji),
      KPLearningHeaderContainer(
        height: CustomSizes.defaultSizeLearningExtContainer,
        text: _getProperMeaning(),
        top: Margins.margin8,
        fontWeight: FontWeight.bold,
      ),
    ];
  }
}
