import 'package:flutter/material.dart';
import 'package:kanpractice/ui/pages/jisho/widgets/InfoChip.dart';
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
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

  Widget _displayInfo(String header, dynamic data) {
    return Visibility(
      visible: data != null,
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
                      child: Text(data is String?
                          ? (data ?? "")
                          : (data as List<String>?)?.join(_separator) ?? "",
                          maxLines: 1,
                          style: TextStyle(fontSize: FontSizes.fontSize16)
                      ),
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
                Text(header, style: TextStyle(
                    fontSize: FontSizes.fontSize20,
                    fontWeight: FontWeight.bold
                )),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: Margins.margin8),
                    child: Text(data?.join(_separator) ?? "", maxLines: 1,
                        style: TextStyle(fontSize: FontSizes.fontSize16)
                    ),
                  ),
                ),
                Visibility(
                    visible: example != null,
                    child: _exampleExpansionTile(context, example)
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
    return ExpansionTile(
      childrenPadding: EdgeInsets.zero,
      tilePadding: EdgeInsets.zero,
      iconColor: CustomColors.secondarySubtleColor,
      textColor: CustomColors.secondarySubtleColor,
      title: Text("${"jisho_resultData_examples_label".tr()} (${example?.length})",
          style: TextStyle(fontSize: FontSizes.fontSize18,
              fontWeight: FontWeight.bold, fontStyle: FontStyle.italic
          )),
      children: [
        Container(
          height: CustomSizes.defaultJishoAPIContainer * 3.2,
          child: ListView.builder(
            itemCount: example?.length,
            itemBuilder: (context, i) {
              return Padding(
                padding: EdgeInsets.only(top: i != 0 ? Margins.margin16 : 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text("• ${example?[i].example} (${example?[i].reading})", maxLines: 2,
                          style: TextStyle(fontSize: FontSizes.fontSize16, fontStyle: FontStyle.italic)
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text("  ${example?[i].meaning}", maxLines: 2,
                          style: TextStyle(fontSize: FontSizes.fontSize16)
                      ),
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
