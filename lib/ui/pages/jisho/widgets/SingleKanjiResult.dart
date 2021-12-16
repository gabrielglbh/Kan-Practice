import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/generic/CustomExpansionTile.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/generic/InfoChip.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/generic/JishoHeader.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/generic/JishoInfoTile.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/generic/ScrollableText.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/ProgressIndicator.dart';
import 'package:unofficial_jisho_api/api.dart';
import 'package:unofficial_jisho_api/api.dart' as jisho;
import 'package:easy_localization/easy_localization.dart';

class SingleKanjiResult extends StatelessWidget {
  final KanjiResultData? data;
  final List<jisho.JishoResult> phrase;
  final String _separator = " • ";
  const SingleKanjiResult({required this.data, required this.phrase});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: Margins.margin32,
          margin: EdgeInsets.all(Margins.margin8),
          child: _chips()
        ),
        Visibility(
          visible: data?.strokeOrderGifUri != null,
          child: Container(
            height: CustomSizes.defaultJishoGIF,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: Margins.margin8),
            child: CachedNetworkImage(
              imageUrl: data?.strokeOrderGifUri ?? "",
              placeholder: (context, _) => CustomProgressIndicator(),
              fadeInDuration: Duration(milliseconds: 200),
              fadeOutDuration: Duration(milliseconds: 200),
              errorWidget: (context, error, _) => Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Margins.margin8),
                  child: Text("jisho_gif_not_loaded".tr())
                ),
              )
            ),
          ),
        ),
        _displayInfo("jisho_resultData_meaning_label".tr(), data?.meaning),
        _displayInfo("jisho_resultData_composed_label".tr(), data?.parts),
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

  Widget _displayInfo(String header, dynamic data) {
    return Visibility(
      visible: data != null,
      child: JishoInfoTile(
        needsHeight: false,
        children: [
          JishoHeader(header: header),
          ScrollableText(
            label: data is String? ? data : (data as List<String>?)?.join(_separator),
            paddingTop: true,
            italic: false,
            rawText: true,
          )
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
            italic: false,
            rawText: true,
          ),
          Visibility(
            visible: example != null && example.isNotEmpty,
            child: Padding(
              padding: EdgeInsets.only(top: Margins.margin8),
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
      children: _listViewWithExamples(example)
    );
  }

  List<Widget> _listViewWithExamples(List<YomiExample>? example) {
    List<Widget> res = [];
    for (int i = 0; i < (example?.length ?? 0); i++)
      res.add(Padding(
        padding: EdgeInsets.only(top: i != 0 ? Margins.margin16 : 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScrollableText(
              label: "${example?[i].example} (${example?[i].reading})",
              initial: true,
              italic: false,
              fontSize: FontSizes.fontSize18,
            ),
            ScrollableText(
              label: example?[i].meaning,
              italic: false,
            ),
          ],
        ),
      ));
    return res;
  }
}
