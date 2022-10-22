import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/domain/word/word.dart';
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

class ReadingStudy extends StatefulWidget {
  final ModeArguments args;
  const ReadingStudy({Key? key, required this.args}) : super(key: key);

  @override
  State<ReadingStudy> createState() => _ReadingStudyState();
}

class _ReadingStudyState extends State<ReadingStudy> {
  /// Current word index
  int _macro = 0;

  bool _showPronunciation = false;
  bool _hasFinished = false;

  /// Array that saves all scores without any previous context for the test result
  final List<double> _testScores = [];

  /// Widget auxiliary variable
  final List<Word> _studyList = [];

  /// For translating the hiragana
  KanaKit? _kanaKit;

  final String _none = "wildcard".tr();

  @override
  void initState() {
    _studyList.addAll(widget.args.studyList);
    _kanaKit = const KanaKit();
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
            _showPronunciation = false;
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
    await WordQueries.instance
        .updateKanji(_studyList[_macro].listName, _studyList[_macro].kanji, {
      KanjiTableFields.dateLastShown: Utils.getCurrentMilliseconds(),
      KanjiTableFields.dateLastShownReading: Utils.getCurrentMilliseconds()
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
    /// Based on the states, update the pronunciation
    if (_showPronunciation) {
      return _studyList[_macro].pronunciation;
    } else {
      return _none;
    }
  }

  String _getProperAlphabet() {
    /// Based on the states, update the romanji version
    String r = "[${(_kanaKit?.toRomaji(_getProperPronunciation()) ?? "")}]";
    if (_showPronunciation) {
      return r;
    } else {
      return "";
    }
  }

  String _getProperMeaning() {
    /// Based on the states, update the meaning
    if (_showPronunciation) {
      return _studyList[_macro].meaning;
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
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
          visible: _showPronunciation,
          child: TTSIconButton(kanji: _studyList[_macro].pronunciation),
        ),
        if (!widget.args.isTest)
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
              KPLearningHeaderAnimation(id: _macro, children: _header()),
            ],
          ),
          KPValidationButtons(
            trigger: _showPronunciation,
            submitLabel: "done_button_label".tr(),
            wrongAction: (score) async => await _updateUIOnSubmit(score),
            midWrongAction: (score) async => await _updateUIOnSubmit(score),
            midPerfectAction: (score) async => await _updateUIOnSubmit(score),
            perfectAction: (score) async => await _updateUIOnSubmit(score),
            onSubmit: () => setState(() => _showPronunciation = true),
          ),
        ],
      ),
    );
  }

  List<Widget> _header() {
    return [
      KPLearningHeaderContainer(
          color: KPColors.secondaryColor,
          height: KPSizes.defaultSizeLearningExtContainer,
          text: _getProperAlphabet()),
      KPLearningHeaderContainer(
          height: KPSizes.defaultResultWordListOnTest,
          fontWeight: FontWeight.bold,
          text: _getProperPronunciation()),
      KPLearningHeaderContainer(
          fontSize: KPFontSizes.fontSize64,
          height: KPSizes.listStudyHeight,
          text: _studyList[_macro].kanji),
      KPLearningHeaderContainer(
          height: KPSizes.defaultSizeLearningExtContainer,
          text: _getProperMeaning(),
          top: KPMargins.margin8)
    ];
  }
}
