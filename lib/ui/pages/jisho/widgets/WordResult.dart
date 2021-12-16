import 'package:flutter/material.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/InfoChip.dart';
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
          child: ExpansionTile(
            childrenPadding: EdgeInsets.zero,
            tilePadding: EdgeInsets.symmetric(horizontal: Margins.margin16),
            iconColor: CustomColors.secondarySubtleColor,
            textColor: CustomColors.secondarySubtleColor,
            title: Text("${"jisho_phraseData_show_meanings".tr()} (${phrase.length - 1})",
                style: TextStyle(fontSize: FontSizes.fontSize18,
                    fontWeight: FontWeight.bold, fontStyle: FontStyle.italic
                )),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
          ),
        ),
        Visibility(
          visible: data == null && index == 0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Margins.margin16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("jisho_phraseData_search_individually".tr(), style: TextStyle(
                    fontSize: FontSizes.fontSize20,
                    fontWeight: FontWeight.bold
                )),
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
        _displayInfo("jisho_phraseData_readings".tr(), phrase[index].japanese),
      ],
    );
  }

  Widget _displayInfo(String header, List<dynamic> d) {
    return Visibility(
      visible: data == null && d.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: CustomSizes.defaultJishoAPIContainer,
            margin: EdgeInsets.symmetric(vertical: Margins.margin8),
            padding: EdgeInsets.symmetric(horizontal: Margins.margin16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(header, style: TextStyle(
                    fontSize: FontSizes.fontSize20,
                    fontWeight: FontWeight.bold
                )),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.only(top: Margins.margin8),
                      child: d is List<jisho.JishoWordSense> ? _sense(d)
                          : d is List<jisho.JishoJapaneseWord> ? _readings(d)
                          : Text("")
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider()
        ],
      ),
    );
  }

  Widget _sense(List<jisho.JishoWordSense> sense) {
    List<String?> actualSenses = [];
    sense.forEach((meaning) => actualSenses.add(
        meaning.englishDefinitions.toSet().toList().join(_separator)
    ));
    String data = actualSenses.join(_separator);
    return Text(data, maxLines: 1,
        style: TextStyle(fontSize: FontSizes.fontSize16)
    );
  }

  Widget _readings(List<jisho.JishoJapaneseWord> readings) {
    List<String?> actualReadings = [];
    readings.forEach((word) {
      actualReadings.add(""
          "${word.word == null ? "" : word.word} "
          "${word.reading == null ? "" : "(${word.reading})"}");
    });
    String reading = actualReadings.toSet().toList().join(_separator);
    return Text(reading, maxLines: 1,
        style: TextStyle(fontSize: FontSizes.fontSize16)
    );
  }
}
