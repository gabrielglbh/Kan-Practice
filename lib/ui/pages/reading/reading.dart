import 'package:flutter/material.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/ui/theme/theme_consts.dart';
import 'package:kanpractice/core/utils/study_modes/mode_arguments.dart';
import 'package:kanpractice/core/utils/study_modes/study_mode_update_handler.dart';
import 'package:kanpractice/ui/widgets/ActionButton.dart';
import 'package:kanpractice/ui/widgets/ListPercentageIndicator.dart';
import 'package:easy_localization/easy_localization.dart';

class ReadingStudy extends StatefulWidget {
  final ModeArguments args;
  const ReadingStudy({required this.args});

  @override
  _ReadingStudyState createState() => _ReadingStudyState();
}

class _ReadingStudyState extends State<ReadingStudy> {
  /// Current word index
  int _macro = 0;

  bool _showPronunciation = false;

  /// Array that saves all scores without any previous context for the test result
  List<double> _testScores = [];
  /// Widget auxiliary variable
  List<Kanji> _studyList = [];
  /// For translating the hiragana
  KanaKit? _kanaKit;

  final String _none = "wildcard".tr();

  @override
  void initState() {
    _studyList = widget.args.studyList;
    _kanaKit = KanaKit();
    super.initState();
  }

  Future<void> _updateUIOnSubmit({required double score}) async {
    /// Calculate the current score
    final code = await _calculateKanjiScore(score);

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
    /// Based on the states, update the pronunciation
    if (_showPronunciation) return _studyList[_macro].pronunciation;
    else return _none;
  }

  String _getProperAlphabet() {
    /// Based on the states, update the romanji version
    String r = "[${(_kanaKit?.toRomaji(_getProperPronunciation()) ?? "")}]";
    if (_showPronunciation) return r;
    else return "";
  }

  String _getProperMeaning() {
    /// Based on the states, update the meaning
    if (_showPronunciation) return _studyList[_macro].meaning;
    else return "";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => StudyModeUpdateHandler.handle(context, widget.args, onPop: true, lastIndex: _macro),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: appBarHeight,
          title: Text(widget.args.mode.mode),
          centerTitle: true
        ),
        body: Container(
          margin: EdgeInsets.only(top: 32),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              ListPercentageIndicator(value: _macro / _studyList.length),
              Text(_getProperAlphabet(), style: TextStyle(fontSize: 24, color: secondaryColor)),
              Text(_getProperPronunciation(), style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              Container(
                height: listStudyHeight,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(_studyList[_macro].kanji, style: TextStyle(fontSize: 64)),
                )
              ),
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 32),
                child: Text(_getProperMeaning(), overflow: TextOverflow.ellipsis),
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
      visible: _showPronunciation,
      child: Container(
        height: listStudyHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ActionButton(
              label: "wrong_button_label".tr(),
              onTap: () async => await _updateUIOnSubmit(score: 0),
              color: Colors.grey,
            ),
            ActionButton(
              label: "perfect_button_label".tr(),
              onTap: () async => await _updateUIOnSubmit(score: 1)
            )
          ],
        )
      ),
    );
  }

  Visibility _submitButton() {
    return Visibility(
      visible: !_showPronunciation,
      child: ActionButton(
        label: "done_button_label".tr(),
        onTap: () async => setState(() => _showPronunciation = true)
      ),
    );
  }
}
