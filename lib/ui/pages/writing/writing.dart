import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/utils/types/study_modes.dart';
import 'package:kanpractice/ui/widgets/StudyModeAppBar.dart';
import 'package:kanpractice/ui/widgets/canvas/CustomCanvas.dart';
import 'package:kanpractice/ui/pages/writing/widgets/WritingButtonsAnimation.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/core/utils/study_modes/mode_arguments.dart';
import 'package:kanpractice/core/utils/study_modes/study_mode_update_handler.dart';
import 'package:kanpractice/ui/widgets/LearningHeaderAnimation.dart';
import 'package:kanpractice/ui/widgets/LearningHeaderContainer.dart';
import 'package:kanpractice/ui/widgets/ListPercentageIndicator.dart';
import 'package:kanpractice/ui/widgets/TTSIconButton.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class WritingStudy extends StatefulWidget {
  final ModeArguments args;
  const WritingStudy({required this.args});

  @override
  _WritingStudyState createState() => _WritingStudyState();
}

class _WritingStudyState extends State<WritingStudy> {
  /// Current drawn line in the canvas
  List<Offset?> _line = [];
  /// Matrix for displaying each individual kanji once validated
  List<List<String>> _currentKanji = [];

  /// Array that saves all scores without any previous context for the test result
  List<double> _testScores = [];
  /// Score granted for each individual kanji of the word
  List<double> _score = [];
  /// Maximum score the user can achieve on a certain word
  List<double> _maxScore = [];

  /// Current word index
  int _macro = 0;
  /// Current kanji within word index
  int _inner = 0;

  bool _showActualKanji = false;
  bool _goNextKanji = false;
  bool _hasFinished = false;

  final String _none = "wildcard".tr();

  /// Widget auxiliary variable
  List<Kanji> _studyList = [];

  @override
  void initState() {
    _studyList = widget.args.studyList;
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
      String kanji = _studyList[x].kanji;
      _score.add(0);
      _currentKanji.add([]);
      _maxScore.add(kanji.length.toDouble());
      for (int y = 0; y < kanji.length; y++) _currentKanji[x].add(_none);
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
      if (_inner == _studyList[_macro].kanji.length) _goNextKanji = true;
    });

    /// Empty the current canvas
    _clear();
  }

  _resetKanji() async {
    /// If we are done with the current word...
    if (_goNextKanji) {
      if (_hasFinished) {
        await _handleFinishedPractice();
      } else {
        /// Empty the current canvas
        _clear();
        /// Calculate the current score
        final int code = await _calculateKanjiScore();

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
          else await _handleFinishedPractice();
        }
      }
    }
    /// If we are within a word with various kanji, show the current one.
    else {
      setState(() {
        _showActualKanji = true;
        _currentKanji[_macro][_inner] = _studyList[_macro].kanji[_inner];
      });
    }
  }

  Future<void> _handleFinishedPractice() async {
    _hasFinished = true;
    /// If the user is in a test, explicitly pass the _testScores to the handler
    if (widget.args.isTest) {
      double testScore = 0;
      _testScores.forEach((s) => testScore += s);
      final score = testScore / _studyList.length;
      await StudyModeUpdateHandler.handle(context, widget.args,
          testScore: score, testScores: _testScores);
    } else await StudyModeUpdateHandler.handle(context, widget.args);
  }

  Future<int> _calculateKanjiScore() async {
    /// Updates the dateLastShown attribute of the finished word AND
    /// the current specific last shown mode attribute
    await KanjiQueries.instance.updateKanji(widget.args.studyList[_macro].listName,
        widget.args.studyList[_macro].kanji, {
          KanjiTableFields.dateLastShown: GeneralUtils.getCurrentMilliseconds(),
          KanjiTableFields.dateLastShownWriting: GeneralUtils.getCurrentMilliseconds()
        });
    final double currentScore = _score[_macro] / _maxScore[_macro];
    /// Add the current virgin score to the test scores...
    if (widget.args.isTest) {
      if (StorageManager.readData(StorageManager.affectOnPractice) ?? false)
        await StudyModeUpdateHandler.calculateScore(widget.args, currentScore, _macro);
      _testScores.add(currentScore);
    }
    else await StudyModeUpdateHandler.calculateScore(widget.args, currentScore, _macro);
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => StudyModeUpdateHandler.handle(context, widget.args, onPop: true, lastIndex: _macro),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: CustomSizes.appBarHeight,
          title: StudyModeAppBar(title: widget.args.display, studyMode: widget.args.mode.mode),
          centerTitle: true,
          actions: [
            Visibility(
              visible: _goNextKanji,
              child: TTSIconButton(kanji: widget.args.studyList[_macro].pronunciation),
            ),
            IconButton(
              icon: Icon(Icons.info_outline_rounded),
              onPressed: () async {
                if (await canLaunch("https://www.sljfaq.org/afaq/stroke-order.html"))
                  launch("https://www.sljfaq.org/afaq/stroke-order.html");
              },
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Margins.margin16),
          child: Column(
            children: [
              ListPercentageIndicator(value: (_macro + 1) / _studyList.length),
              LearningHeaderAnimation(id: _macro, children: _header()),
              CustomCanvas(line: _line, allowEdit: !_showActualKanji),
              WritingButtonsAnimations(
                id: _macro,
                /// Whenever a new kanji is shown, _inner will be 0. That's
                /// the key to toggle the slide animation on the button.
                triggerSlide: _inner == 0,
                trigger: _showActualKanji,
                submitLabel: _goNextKanji ? "writing_next_kanji_label".tr() : "done_button_label".tr(),
                wrongAction: (score) async => await _updateUIOnSubmit(score),
                midWrongAction: (score) async => await _updateUIOnSubmit(score),
                midPerfectAction: (score) async => await _updateUIOnSubmit(score),
                perfectAction: (score) async => await _updateUIOnSubmit(score),
                onSubmit: () {
                  if (_macro <= _studyList.length - 1)
                    _resetKanji();
                  else {
                    if (_line.isNotEmpty) _resetKanji();
                    else GeneralUtils.getSnackBar(context, "writing_validation_failed".tr());
                  }
                },
              )
            ],
          ),
        )
      ),
    );
  }

  List<Widget> _header() {
    double finalHeight = MediaQuery.of(context).size.height < CustomSizes.minimumHeight
        ? CustomSizes.listStudyHeight / 3 : CustomSizes.listStudyHeight;
    return [
      LearningHeaderContainer(
        height: CustomSizes.defaultSizeLearningExtContainer + Margins.margin8,
        text: _goNextKanji
            ? _studyList[_macro].pronunciation : ""
      ),
      Container(
        height: finalHeight,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _studyList[_macro].kanji.length,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            String? kanji = _studyList[_macro].kanji;
            return Text(_currentKanji[_macro][index] == _none ? _none : kanji[index],
                style: TextStyle(fontSize:
                MediaQuery.of(context).size.height < CustomSizes.minimumHeight
                    ? FontSizes.fontSize24 : FontSizes.fontSize64,
                    color: index == _inner ? CustomColors.secondaryColor : null)
            );
          },
        ),
      ),
      LearningHeaderContainer(
        height: CustomSizes.defaultSizeLearningExtContainer,
        text: _studyList[_macro].meaning,
        top: Margins.margin8,
      ),
    ];
  }

  _clear() => setState(() => _line = []);
}
