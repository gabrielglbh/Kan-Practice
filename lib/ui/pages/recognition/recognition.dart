import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/utils/study_modes/mode_arguments.dart';
import 'package:kanpractice/core/utils/study_modes/study_mode_update_handler.dart';
import 'package:kanpractice/ui/theme/theme_consts.dart';
import 'package:kanpractice/ui/widgets/ActionButton.dart';
import 'package:kanpractice/ui/widgets/ListPercentageIndicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/ui/widgets/ValidationButtons.dart';

class RecognitionStudy extends StatefulWidget {
  final ModeArguments args;
  const RecognitionStudy({required this.args});

  @override
  _RecognitionStudyState createState() => _RecognitionStudyState();
}

class _RecognitionStudyState extends State<RecognitionStudy> {
  /// Current word index
  int _macro = 0;

  bool _showMeaning = false;

  /// Array that saves all scores without any previous context for the test result
  List<double> _testScores = [];
  /// Widget auxiliary variable
  List<Kanji> _studyList = [];

  final String _none = "wildcard".tr();

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
          _showMeaning = false;
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

  Future<int> _calculateKanjiScore(double score) async {
    /// Add the current virgin score to the test scores...
    if (widget.args.isTest) _testScores.add(score);
    else StudyModeUpdateHandler.calculateScore(widget.args, score, _macro);
    return 0;
  }

  String _getProperPronunciation() {
    /// Based on the states, update the meaning
    if (_showMeaning) return _studyList[_macro].pronunciation;
    else return "";
  }

  String _getProperMeaning() {
    /// Based on the states, update the meaning
    if (_showMeaning) return _studyList[_macro].meaning;
    else return _none;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => StudyModeUpdateHandler.handle(context, widget.args, onPop: true, lastIndex: _macro),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: appBarHeight,
          title: FittedBox(fit: BoxFit.fitWidth, child: Text(widget.args.mode.mode)),
          centerTitle: true
        ),
        body: Container(
          margin: EdgeInsets.only(top: 32),
          padding: EdgeInsets.symmetric(horizontal: 8),
          alignment: Alignment.center,
          child: Column(
            children: [
              ListPercentageIndicator(value: (_macro + 1) / _studyList.length),
              Text(_getProperPronunciation()),
              Container(
                height: listStudyHeight,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(_studyList[_macro].kanji, style: TextStyle(fontSize: 64)),
                )
              ),
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 32),
                child: Text(_getProperMeaning(),
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis
                ),
              ),
              _validateButtons(),
              _submitButton()
            ],
          ),
        ),
      ),
    );
  }

  Visibility _validateButtons() {
    return Visibility(
      visible: _showMeaning,
      child: ValidationButtons(
        wrongAction: _updateUIOnSubmit,
        midWrongAction: _updateUIOnSubmit,
        midPerfectAction: _updateUIOnSubmit,
        perfectAction: _updateUIOnSubmit,
      )
    );
  }

  Visibility _submitButton() {
    return Visibility(
      visible: !_showMeaning,
      child: ActionButton(
        label: "done_button_label".tr(),
        onTap: () async => setState(() => _showMeaning = true)
      ),
    );
  }
}
