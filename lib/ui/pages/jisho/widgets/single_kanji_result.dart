import 'package:flutter/material.dart';
import 'package:kanpractice/core/types/chip_type.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/generic/custom_expansion_tile.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/generic/info_chip.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/generic/jisho_header.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/generic/jisho_info_tile.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/generic/scrollable_text.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/generic/single_kanji_look_up_list.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/widgets/kp_cached_network_image.dart';
import 'package:unofficial_jisho_api/api.dart';
import 'package:unofficial_jisho_api/api.dart' as jisho;
import 'package:easy_localization/easy_localization.dart';

class SingleKanjiResult extends StatelessWidget {
  final KanjiResultData? data;
  final List<jisho.JishoResult> phrase;
  final String _separator = " • ";
  final bool fromDictionary;
  const SingleKanjiResult({
    Key? key,
    required this.data,
    required this.phrase,
    required this.fromDictionary
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: Margins.margin32,
          margin: const EdgeInsets.all(Margins.margin8),
          child: _chips()
        ),
        Visibility(
          visible: data?.strokeOrderGifUri != null,
          child: Container(
            height: CustomSizes.defaultJishoGIF,
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: Margins.margin8),
            child: KPCachedNetworkImage(
              url: data?.strokeOrderGifUri ?? "",
              errorMessage: "jisho_gif_not_loaded".tr(),
            ),
          ),
        ),
        _displayMeaning(context, "jisho_resultData_meaning_label".tr(), data?.meaning),
        _displayComposed("jisho_resultData_composed_label".tr(), data?.parts),
        _displayInfoWithExample(context, "jisho_resultData_kunyomi".tr(),
            data?.kunyomi,
            data?.kunyomiExamples),
        _displayInfoWithExample(context, "jisho_resultData_onyomi".tr(),
            data?.onyomi,
            data?.onyomiExamples),
      ],
    );
  }

  Widget _chips() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        Visibility(
          visible: data?.jlptLevel != null,
          child: InfoChip(label: data?.jlptLevel, type: ChipType.jlpt),
        ),
        Visibility(
          visible: data?.strokeCount != null,
          child: InfoChip(label: data?.strokeCount.toString(), type: ChipType.stroke),
        ),
        Visibility(
          visible: phrase.isNotEmpty && phrase[0].isCommon != null,
          child: InfoChip(label: phrase[0].isCommon == true
              ? "jisho_phraseData_common".tr()
              : "jisho_phraseData_uncommon".tr(),
            type: phrase[0].isCommon == true ? ChipType.common : ChipType.uncommon,
          ),
        ),
        Visibility(
          visible: phrase.isNotEmpty && phrase[0].isCommon == null,
          child: InfoChip(label: "jisho_phraseData_unknown".tr(), type: ChipType.unknown),
        )
      ],
    );
  }

  Widget _displayMeaning(BuildContext context, String header, String? data) {
    return Visibility(
      visible: data != null,
      child: JishoInfoTile(
        needsHeight: false,
        children: [
          JishoHeader(header: header),
          ScrollableText(label: data, paddingTop: true, rawText: true,
              style: Theme.of(context).textTheme.bodyText2),
        ],
      ),
    );
  }

  Widget _displayComposed(String header, List<String>? data) {
    return Visibility(
      visible: data != null && data.length > 1,
      child: JishoInfoTile(
        needsHeight: false,
        children: [
          JishoHeader(header: header),
          SingleKanjiLookUpList(kanjiList: data, fromDictionary: fromDictionary)
        ],
      ),
    );
  }

  Widget _displayInfoWithExample(BuildContext context, String header,
      List<String>? data, List<YomiExample>? example) {
    return Visibility(
      visible: data != null && data.isNotEmpty,
      child: JishoInfoTile(
        needsHeight: false,
        children: [
          JishoHeader(header: header),
          ScrollableText(
            label: data?.toSet().toList().join(_separator),
            paddingTop: true,
            style: Theme.of(context).textTheme.bodyText1,
            rawText: true,
          ),
          Visibility(
            visible: example != null && example.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(top: Margins.margin8),
              child: _exampleExpansionTile(context, example)
            )
          ),
        ],
      ),
    );
  }

  Widget _exampleExpansionTile(BuildContext context, List<YomiExample>? example) {
    return CustomExpansionTile(
      label: "${"jisho_resultData_examples_label".tr()} (${example?.length})",
      children: _listViewWithExamples(context, example)
    );
  }

  List<Widget> _listViewWithExamples(BuildContext context, List<YomiExample>? example) {
    List<Widget> res = [];
    for (int i = 0; i < (example?.length ?? 0); i++) {
      res.add(Padding(
        padding: EdgeInsets.only(top: i != 0 ? Margins.margin16 : 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScrollableText(
              label: "${example?[i].example} (${example?[i].reading})",
              initial: true,
              style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.w500)
            ),
            ScrollableText(
              label: example?[i].meaning,
              style: Theme.of(context).textTheme.bodyText2
            ),
          ],
        ),
      ));
    }
    return res;
  }
}
