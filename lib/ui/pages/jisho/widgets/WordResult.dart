import 'package:flutter/material.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/generic/CustomExpansionTile.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/generic/InfoChip.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/generic/JishoHeader.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/generic/JishoInfoTile.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/generic/ScrollableText.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:unofficial_jisho_api/api.dart' as jisho;
import 'package:easy_localization/easy_localization.dart';

class WordResult extends StatelessWidget {
  final String? kanji;
  final jisho.KanjiResultData? data;
  final List<jisho.JishoResult> phrase;
  final String _separator = " • ";
  const WordResult({required this.kanji, required this.data, required this.phrase});

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
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                child: ListView.builder(
                  itemCount: phrase.length,
                  itemBuilder: (context, index) {
                    if (index == 0) return Container();
                    return _completePhraseData(index: index);
                  }
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _completePhraseData({int index = 0}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: data == null,
          child: Container(
            height: Margins.margin32,
            margin: EdgeInsets.only(
              right: Margins.margin8, left: Margins.margin8, bottom: Margins.margin8
            ),
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
                Container(
                  height: CustomSizes.defaultJishoAPIContainer,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: kanji?.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: Margins.margin4),
                        child: ActionChip(
                          padding: EdgeInsets.symmetric(horizontal: Margins.margin8),
                          onPressed: () {
                            Navigator.of(context).pushNamed(KanPracticePages.jishoPage, arguments: kanji?[index]);
                          },
                          label: Text(kanji?[index] ?? ""),
                        ),
                      );
                    },
                  ),
                )
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
          child: InfoChip(label: "${"jisho_resultData_jlpt".tr()} "
              "${phrase[index].jlpt.isNotEmpty
              ? phrase[index].jlpt[index].substring(5).toUpperCase() : ""}"),
        ),
        Visibility(
          visible: phrase[index].isCommon != null,
          child: InfoChip(label: phrase[index].isCommon == true
              ? "jisho_phraseData_common".tr() : "jisho_phraseData_uncommon".tr()),
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
