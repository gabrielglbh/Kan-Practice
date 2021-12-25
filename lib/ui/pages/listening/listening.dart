import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/core/utils/study_modes/mode_arguments.dart';
import 'package:kanpractice/core/utils/study_modes/study_mode_update_handler.dart';
import 'package:kanpractice/ui/widgets/LearningHeaderAnimation.dart';
import 'package:kanpractice/ui/widgets/LearningHeaderContainer.dart';
import 'package:kanpractice/ui/widgets/ListPercentageIndicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/ui/widgets/TTSIconButton.dart';
import 'package:kanpractice/ui/widgets/ValidationButtons.dart';

class ListeningStudy extends StatefulWidget {
  final ModeArguments args;
  const ListeningStudy({required this.args});

  @override
  _ListeningStudyState createState() => _ListeningStudyState();
}

class _ListeningStudyState extends State<ListeningStudy> {
  /// Current word index
  int _macro = 0;

  bool _showWord = false;

  /// Array that saves all scores without any previous context for the test result
  List<double> _testScores = [];
  /// Widget auxiliary variable
  List<Kanji> _studyList = [];

  @override
  void initState() {
    _studyList = widget.args.studyList;
    super.initState();
  }

  Future<void> _updateUIOnSubmit(double score) async {
    /// Calculate the current score
    final code = await _calculateKanjiScore(score);

    /// If everything went well, and we have words left in the list,
    /// update _macro to the next one.
    if (code == 0) {
      if (_macro < _studyList.length - 1) {
        setState(() {
          _macro++;
          _showWord = false;
        });
      }
      /// If we ended the list, update the statistics to DB and exit
      else {
        /// If the user is in a test, explicitly pass the _testScores to the handler
        if (widget.args.isTest) {
          double testScore = 0;
          _testScores.forEach((s) => testScore += s);
          final score = testScore / _studyList.length;
          await StudyModeUpdateHandler.handle(context, widget.args,
              testScore: score, testScores: _testScores);
        } else await StudyModeUpdateHandler.handle(context, widget.args);
      }
    }
  }

  Future<int> _calculateKanjiScore(double score) async {
    /// Updates the dateLastShown attribute of the finished word
    await KanjiQueries.instance.updateKanji(widget.args.studyList[_macro].listName,
        widget.args.studyList[_macro].kanji, {
          KanjiTableFields.dateLastShown: GeneralUtils.getCurrentMilliseconds()
        });
    /// Add the current virgin score to the test scores...
    if (widget.args.isTest) {
      if (StorageManager.readData(StorageManager.affectOnPractice) ?? false)
        await StudyModeUpdateHandler.calculateScore(widget.args, score, _macro);
      _testScores.add(score);
    }
    else await StudyModeUpdateHandler.calculateScore(widget.args, score, _macro);
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => StudyModeUpdateHandler.handle(context, widget.args, onPop: true, lastIndex: _macro),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: CustomSizes.appBarHeight,
          title: FittedBox(fit: BoxFit.fitWidth, child: Text(widget.args.mode.mode)),
          centerTitle: true,
          actions: [
            Visibility(
              visible: _showWord,
              child: TTSIconButton(kanji: widget.args.studyList[_macro].kanji),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Margins.margin16),
          child: Column(
            children: [
              ListPercentageIndicator(value: (_macro + 1) / _studyList.length),
              LearningHeaderAnimation(id: _macro, children: _header()),
              ValidationButtons(
                trigger: _showWord,
                submitLabel: "done_button_label".tr(),
                wrongAction: _updateUIOnSubmit,
                midWrongAction: _updateUIOnSubmit,
                midPerfectAction: _updateUIOnSubmit,
                perfectAction: _updateUIOnSubmit,
                onSubmit: () => setState(() => _showWord = true),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _header() {
    return [
      Visibility(
        visible: _showWord,
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        child: LearningHeaderContainer(
          height: CustomSizes.defaultSizeLearningExtContainer + Margins.margin8,
          text: _studyList[_macro].pronunciation,
        ),
      ),
      Visibility(
          visible: !_showWord,
          child: TTSIconButton(
              kanji: _studyList[_macro].kanji,
              iconSize: Margins.margin64 + Margins.margin4
          )
      ),
      Visibility(
        visible: _showWord,
        child: LearningHeaderContainer(
          fontSize: FontSizes.fontSize64,
          height: CustomSizes.listStudyHeight,
          text: _studyList[_macro].kanji,
        ),
      ),
      Visibility(
        visible: _showWord,
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        child: LearningHeaderContainer(
            height: CustomSizes.defaultSizeLearningExtContainer,
            text: _studyList[_macro].meaning,
            top: Margins.margin8,
        ),
      )
    ];
  }
}