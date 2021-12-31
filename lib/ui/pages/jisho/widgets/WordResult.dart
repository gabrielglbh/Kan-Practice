import 'package:flutter/material.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/generic/CustomExpansionTile.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/generic/InfoChip.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/generic/JishoHeader.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/generic/JishoInfoTile.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/generic/ScrollableText.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/generic/SingleKanjiLookUpList.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:unofficial_jisho_api/api.dart' as jisho;
import 'package:easy_localization/easy_localization.dart';

class WordResult extends StatelessWidget {
  final String? kanji;
  final jisho.KanjiResultData? data;
  final List<jisho.JishoResult> phrase;
  final String _separator = " • ";
  final bool fromDictionary;
  const WordResult({required this.kanji, required this.data, required this.phrase,
    required this.fromDictionary
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _completePhraseData(),
        Visibility(
          visible: data == null && (phrase.length - 1) != 0,
          child: CustomExpansionTile(
            label: "${"jisho_phraseData_show_meanings".tr()} (${phrase.length - 1})",
            paddingHorizontal: EdgeInsets.symmetric(horizontal: Margins.margin16),
            children: _listViewMoreMeanings()
          ),
        ),
      ],
    );
  }

  List<Widget> _listViewMoreMeanings() {
    List<Widget> res = [];
    for (int i = 0; i < phrase.length - 1; i++) res.add(_completePhraseData(index: i, expanded: true));
    return res;
  }

  Widget _completePhraseData({int index = 0, bool expanded = false}) {
    if (expanded) index++;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: data == null && phrase.isNotEmpty,
          child: Container(
            height: Margins.margin32,
            margin: EdgeInsets.all(Margins.margin8),
            child: _chips(index)
          ),
        ),
        Visibility(
          visible: data == null && index == 0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Margins.margin16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                JishoHeader(header: "jisho_phraseData_search_individually".tr()),
                SingleKanjiLookUpList(kanjiList: kanji?.split(""), fromDictionary: fromDictionary)
              ],
            ),
          )
        ),
        _displayInfo("jisho_resultData_meaning_label".tr(), phrase[index].senses),
        _displayInfo("jisho_phraseData_readings".tr(), phrase[index].japanese, guideline: true),
      ],
    );
  }

  Widget _chips(int index) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        Visibility(
          visible: phrase[index].jlpt.isNotEmpty,
          child: InfoChip(label: phrase[index].jlpt.isNotEmpty
              ? phrase[index].jlpt[0].substring(5).toUpperCase() : "",
            type: ChipType.jlpt
          ),
        ),
        Visibility(
          visible: phrase[index].isCommon != null,
          child: InfoChip(label: phrase[index].isCommon == true
              ? "jisho_phraseData_common".tr() : "jisho_phraseData_uncommon".tr(),
            type: phrase[index].isCommon == true ? ChipType.common : ChipType.uncommon,
          ),
        ),
        Visibility(
          visible: phrase[index].isCommon == null,
          child: InfoChip(label: "jisho_phraseData_unknown".tr(), type: ChipType.unknown),
        )
      ],
    );
  }

  Widget _displayInfo(String header, List<dynamic> d, {bool guideline = false}) {
    return Visibility(
      visible: data == null && d.isNotEmpty,
      child: JishoInfoTile(
        needsHeight: false,
        children: [
          JishoHeader(header: header, guideline: guideline),
          ScrollableText(
            label: d is List<jisho.JishoWordSense> ? _sense(d)
                : d is List<jisho.JishoJapaneseWord> ? _readings(d)
                : "",
            paddingTop: true,
            rawText: true,
            italic: false,
          )
        ],
      ),
    );
  }

  String _sense(List<jisho.JishoWordSense> sense) {
    List<String?> actualSenses = [];
    sense.forEach((meaning) => actualSenses.add(
        meaning.englishDefinitions.toSet().toList().join(_separator)
    ));
    return actualSenses.join(_separator);
  }

  String _readings(List<jisho.JishoJapaneseWord> readings) {
    List<String?> actualReadings = [];
    readings.forEach((word) {
      actualReadings.add(""
          "${word.word == null ? "" : word.word} "
          "${word.reading == null ? "" : "(${word.reading})"}");
    });
    return actualReadings.toSet().toList().join(_separator);
  }
}
