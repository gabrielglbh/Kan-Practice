import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/types/chip_type.dart';
import 'package:kanpractice/presentation/core/widgets/kp_cached_network_image.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/dictionary_details_page/widgets/generic/custom_expansion_tile.dart';
import 'package:kanpractice/presentation/dictionary_details_page/widgets/generic/info_chip.dart';
import 'package:kanpractice/presentation/dictionary_details_page/widgets/generic/jisho_header.dart';
import 'package:kanpractice/presentation/dictionary_details_page/widgets/generic/jisho_info_tile.dart';
import 'package:kanpractice/presentation/dictionary_details_page/widgets/generic/scrollable_text.dart';
import 'package:kanpractice/presentation/dictionary_details_page/widgets/generic/single_word_look_up_list.dart';
import 'package:unofficial_jisho_api/api.dart';
import 'package:easy_localization/easy_localization.dart';

class SingleWordResult extends StatelessWidget {
  final KanjiResultData? data;
  final List<JishoResult> phrase;
  final String _separator = " • ";
  final bool fromDictionary;
  const SingleWordResult(
      {Key? key,
      required this.data,
      required this.phrase,
      required this.fromDictionary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            height: KPMargins.margin32,
            margin: const EdgeInsets.all(KPMargins.margin8),
            child: _chips()),
        Visibility(
          visible: data?.strokeOrderGifUri != null,
          child: Container(
            height: KPSizes.defaultJishoGIF,
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: KPMargins.margin8),
            child: KPCachedNetworkImage(
              url: data?.strokeOrderGifUri ?? "",
              errorMessage: "jisho_gif_not_loaded".tr(),
            ),
          ),
        ),
        _displayMeaning(
            context, "jisho_resultData_meaning_label".tr(), data?.meaning),
        _displayComposed("jisho_resultData_composed_label".tr(), data?.parts),
        _displayInfoWithExample(context, "jisho_resultData_kunyomi".tr(),
            data?.kunyomi, data?.kunyomiExamples),
        _displayInfoWithExample(context, "jisho_resultData_onyomi".tr(),
            data?.onyomi, data?.onyomiExamples),
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
          child: InfoChip(
              label: data?.strokeCount.toString(), type: ChipType.stroke),
        ),
        Visibility(
          visible: phrase.isNotEmpty && phrase[0].isCommon != null,
          child: InfoChip(
            label: phrase[0].isCommon == true
                ? "jisho_phraseData_common".tr()
                : "jisho_phraseData_uncommon".tr(),
            type: phrase[0].isCommon == true
                ? ChipType.common
                : ChipType.uncommon,
          ),
        ),
        Visibility(
          visible: phrase.isNotEmpty && phrase[0].isCommon == null,
          child: InfoChip(
              label: "jisho_phraseData_unknown".tr(), type: ChipType.unknown),
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
          ScrollableText(
              label: data,
              paddingTop: true,
              rawText: true,
              style: Theme.of(context).textTheme.bodyMedium),
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
          SingleWordLookUpList(wordList: data, fromDictionary: fromDictionary)
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
            style: Theme.of(context).textTheme.bodyLarge,
            rawText: true,
          ),
          Visibility(
              visible: example != null && example.isNotEmpty,
              child: Padding(
                  padding: const EdgeInsets.only(top: KPMargins.margin8),
                  child: _exampleExpansionTile(context, example))),
        ],
      ),
    );
  }

  Widget _exampleExpansionTile(
      BuildContext context, List<YomiExample>? example) {
    return CustomExpansionTile(
        label: "${"jisho_resultData_examples_label".tr()} (${example?.length})",
        children: _listViewWithExamples(context, example));
  }

  List<Widget> _listViewWithExamples(
      BuildContext context, List<YomiExample>? example) {
    List<Widget> res = [];
    for (int i = 0; i < (example?.length ?? 0); i++) {
      res.add(Padding(
        padding: EdgeInsets.only(top: i != 0 ? KPMargins.margin16 : 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScrollableText(
                label: "${example?[i].example} (${example?[i].reading})",
                initial: true,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w500)),
            ScrollableText(
                label: example?[i].meaning,
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ));
    }
    return res;
  }
}
