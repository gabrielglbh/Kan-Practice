import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/ui/pages/writing/widgets/CustomCanvas.dart';
import 'package:kanpractice/ui/theme/theme_consts.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/core/utils/study_modes/mode_arguments.dart';
import 'package:kanpractice/core/utils/study_modes/study_mode_update_handler.dart';
import 'package:kanpractice/ui/widgets/ListPercentageIndicator.dart';
import 'package:kanpractice/ui/widgets/ValidationButtons.dart';
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
        else {
          /// If the user is in a test, explicitly pass the _testScores to the handler
          if (widget.args.isTest) {
            double testScore = 0;
            _testScores.forEach((s) => testScore += s);
            final score = testScore / _studyList.length;
            await StudyModeUpdateHandler.handle(context, widget.args, testScore: score);
          } else await StudyModeUpdateHandler.handle(context, widget.args);
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

  Future<int> _calculateKanjiScore() async {
    final double currentScore = _score[_macro] / _maxScore[_macro];
    /// Add the current virgin score to the test scores...
    if (widget.args.isTest) _testScores.add(currentScore);
    else StudyModeUpdateHandler.calculateScore(widget.args, currentScore, _macro);
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
            IconButton(
              icon: Icon(Icons.info_outline_rounded),
              onPressed: () async {
                if (await canLaunch("https://www.sljfaq.org/afaq/stroke-order.html"))
                  launch("https://www.sljfaq.org/afaq/stroke-order.html");
              },
            )
          ],
        ),
        body: Column(
          children: [
            ListPercentageIndicator(value: (_macro + 1) / _studyList.length),
            _header(),
            Padding(
              padding: EdgeInsets.all(8),
              child: CustomCanvas(line: _line, allowEdit: !_showActualKanji, fatherPadding: 16)
            ),
            ValidationButtons(
              trigger: _showActualKanji,
              submitLabel: _goNextKanji ? "writing_next_kanji_label".tr() : "done_button_label".tr(),
              wrongAction: _updateUIOnSubmit,
              midWrongAction: _updateUIOnSubmit,
              midPerfectAction: _updateUIOnSubmit,
              perfectAction: _updateUIOnSubmit,
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
        )
      ),
    );
  }

  Container _header() {
    double finalHeight = MediaQuery.of(context).size.height < CustomSizes.minimumHeight
        ? CustomSizes.listStudyHeight / 2 : CustomSizes.listStudyHeight;
    return Container(
      height: MediaQuery.of(context).size.height < CustomSizes.minimumHeight
          ? CustomSizes.studyGuideHeight / 2 : CustomSizes.studyGuideHeight,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Container(
            height: 20,
            child: _goNextKanji
                ? Text(_studyList[_macro].pronunciation, overflow: TextOverflow.ellipsis)
                : Text(""),
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
                    MediaQuery.of(context).size.height < CustomSizes.minimumHeight ? 32 : 64,
                        color: index == _inner ? CustomColors.secondaryColor : null)
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(_studyList[_macro].meaning, overflow: TextOverflow.ellipsis),
          )
        ],
      ),
    );
  }

  _clear() => setState(() => _line = []);
}
