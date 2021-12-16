import 'package:flutter/material.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/generic/CustomExpansionTile.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/generic/InfoChip.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/generic/JishoHeader.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/generic/JishoInfoTile.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/generic/ScrollableText.dart';
import 'package:kanpractice/ui/theme/consts.dart';
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
          margin: EdgeInsets.only(
            right: Margins.margin8, left: Margins.margin8, bottom: Margins.margin8
          ),
          child: _chips()
        ),
        Visibility(
          visible: data?.strokeOrderGifUri != null,
          child: Container(
            height: CustomSizes.defaultJishoGIF,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: Margins.margin8),
            child: Image.network(data?.strokeOrderGifUri ?? ""),
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
          child: InfoChip(label: "${"jisho_resultData_jlpt".tr()} "
              "${data?.jlptLevel}"),
        ),
        Visibility(
          visible: data?.strokeCount != null,
          child: InfoChip(label: "${"jisho_resultData_strokes".tr()} "
              "${data?.strokeCount}"),
        ),
        Visibility(
          visible: phrase.isNotEmpty && phrase[0].isCommon != null,
          child: InfoChip(label: phrase[0].isCommon == true
              ? "jisho_phraseData_common".tr() : "jisho_phraseData_uncommon".tr()),
        )
      ],
    );
  }

  Widget _displayInfo(String header, dynamic data) {
    return Visibility(
      visible: data != null,
      child: JishoInfoTile(
        children: [
          JishoHeader(header: header),
          Expanded(
            child: ScrollableText(
              label: data is String? ? data : (data as List<String>?)?.join(_separator),
              paddingTop: true,
              italic: false,
              rawText: true,
            ),
          )
        ],
      ),
    );
  }

  Widget _displayInfoWithExample(BuildContext context, String header,
      List<String>? data, List<YomiExample>? example) {
    return Visibility(
      visible: data != null && data.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: Margins.margin8),
            padding: EdgeInsets.symmetric(horizontal: Margins.margin16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
          ),
          Divider()
        ],
      ),
    );
  }

  Widget _exampleExpansionTile(BuildContext context, List<YomiExample>? example) {
    return CustomExpansionTile(
      label: "${"jisho_resultData_examples_label".tr()} (${example?.length})",
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 2,
          child: ListView.builder(
            itemCount: example?.length,
            itemBuilder: (context, i) {
              return Padding(
                padding: EdgeInsets.only(top: i != 0 ? Margins.margin16 : 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScrollableText(
                      label: "${example?[i].example} (${example?[i].reading})",
                      initial: true,
                    ),
                    ScrollableText(
                      label: example?[i].meaning,
                      italic: false,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
