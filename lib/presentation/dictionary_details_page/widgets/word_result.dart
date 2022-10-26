import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/types/chip_type.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/dictionary_details_page/widgets/generic/custom_expansion_tile.dart';
import 'package:kanpractice/presentation/dictionary_details_page/widgets/generic/info_chip.dart';
import 'package:kanpractice/presentation/dictionary_details_page/widgets/generic/jisho_header.dart';
import 'package:kanpractice/presentation/dictionary_details_page/widgets/generic/jisho_info_tile.dart';
import 'package:kanpractice/presentation/dictionary_details_page/widgets/generic/scrollable_text.dart';
import 'package:kanpractice/presentation/dictionary_details_page/widgets/generic/single_kanji_look_up_list.dart';
import 'package:unofficial_jisho_api/api.dart';
import 'package:easy_localization/easy_localization.dart';

class WordResult extends StatelessWidget {
  final String? kanji;
  final KanjiResultData? data;
  final List<JishoResult> phrase;
  final String _separator = " • ";
  final bool fromDictionary;
  const WordResult(
      {Key? key,
      required this.kanji,
      required this.data,
      required this.phrase,
      required this.fromDictionary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _completePhraseData(context),
        Visibility(
          visible: data == null && (phrase.length - 1) != 0,
          child: CustomExpansionTile(
              label:
                  "${"jisho_phraseData_show_meanings".tr()} (${phrase.length - 1})",
              paddingHorizontal:
                  const EdgeInsets.symmetric(horizontal: KPMargins.margin16),
              children: _listViewMoreMeanings(context)),
        ),
      ],
    );
  }

  List<Widget> _listViewMoreMeanings(BuildContext context) {
    List<Widget> res = [];
    for (int i = 0; i < phrase.length - 1; i++) {
      res.add(_completePhraseData(context, index: i, expanded: true));
    }
    return res;
  }

  Widget _completePhraseData(BuildContext context,
      {int index = 0, bool expanded = false}) {
    if (expanded) index++;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: data == null && phrase.isNotEmpty,
          child: Container(
              height: KPMargins.margin32,
              margin: const EdgeInsets.all(KPMargins.margin8),
              child: _chips(index)),
        ),
        Visibility(
            visible: data == null && index == 0,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: KPMargins.margin16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  JishoHeader(
                      header: "jisho_phraseData_search_individually".tr()),
                  SingleKanjiLookUpList(
                      kanjiList: kanji?.split(""),
                      fromDictionary: fromDictionary)
                ],
              ),
            )),
        _displayInfo(context, "jisho_resultData_meaning_label".tr(),
            phrase[index].senses),
        _displayInfo(
            context, "jisho_phraseData_readings".tr(), phrase[index].japanese,
            guideline: true),
      ],
    );
  }

  Widget _chips(int index) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        Visibility(
          visible: phrase[index].jlpt.isNotEmpty,
          child: InfoChip(
              label: phrase[index].jlpt.isNotEmpty
                  ? phrase[index].jlpt[0].substring(5).toUpperCase()
                  : "",
              type: ChipType.jlpt),
        ),
        Visibility(
          visible: phrase[index].isCommon != null,
          child: InfoChip(
            label: phrase[index].isCommon == true
                ? "jisho_phraseData_common".tr()
                : "jisho_phraseData_uncommon".tr(),
            type: phrase[index].isCommon == true
                ? ChipType.common
                : ChipType.uncommon,
          ),
        ),
        Visibility(
          visible: phrase[index].isCommon == null,
          child: InfoChip(
              label: "jisho_phraseData_unknown".tr(), type: ChipType.unknown),
        )
      ],
    );
  }

  Widget _displayInfo(BuildContext context, String header, List<dynamic> d,
      {bool guideline = false}) {
    return Visibility(
      visible: data == null && d.isNotEmpty,
      child: JishoInfoTile(
        needsHeight: false,
        children: [
          JishoHeader(header: header, guideline: guideline),
          ScrollableText(
            label: d is List<JishoWordSense>
                ? _sense(d)
                : d is List<JishoJapaneseWord>
                    ? _readings(d)
                    : "",
            paddingTop: true,
            rawText: true,
            style: Theme.of(context).textTheme.bodyText2,
          )
        ],
      ),
    );
  }

  String _sense(List<JishoWordSense> sense) {
    List<String?> actualSenses = [];
    for (var meaning in sense) {
      actualSenses
          .add(meaning.englishDefinitions.toSet().toList().join(_separator));
    }
    return actualSenses.join(_separator);
  }

  String _readings(List<JishoJapaneseWord> readings) {
    List<String?> actualReadings = [];
    for (var word in readings) {
      actualReadings.add(""
          "${word.word ?? ""} "
          "${word.reading == null ? "" : "(${word.reading})"}");
    }
    return actualReadings.toSet().toList().join(_separator);
  }
}
