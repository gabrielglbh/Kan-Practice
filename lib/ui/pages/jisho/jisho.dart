import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/jisho/models/jisho_data.dart';
import 'package:kanpractice/ui/pages/jisho/bloc/jisho_bloc.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/ProgressIndicator.dart';
import 'package:unofficial_jisho_api/api.dart';
import 'package:easy_localization/easy_localization.dart';

class JishoPage extends StatelessWidget {
  final Kanji? kanji;
  final String _separator = " • ";

  const JishoPage({required this.kanji});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: CustomSizes.appBarHeight,
        title: FittedBox(fit: BoxFit.fitWidth, child: Text(kanji?.kanji ?? "?")),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocProvider<JishoBloc>(
              create: (_) => JishoBloc()..add(JishoLoadingEvent(kanji: kanji ?? Kanji.empty)),
              child: BlocBuilder<JishoBloc, JishoState>(
                builder: (context, state) {
                  if (state is JishoStateLoading)
                    return CustomProgressIndicator();
                  else if (state is JishoStateLoaded) {
                    return _content(context, state);
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
          _poweredByJisho(),
        ],
      )
    );
  }

  Widget _content(BuildContext context, JishoStateLoaded state) {
    if (state.data.resultData == null && state.data.example.isEmpty) {
      return Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Margins.margin16),
          child: Text("jisho_no_match".tr())
        ));
    }
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Visibility(
                visible: state.data.resultData != null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: state.data.resultData?.jlptLevel != null,
                          child: _infoChip("${"jisho_resultData_jlpt".tr()} "
                              "${state.data.resultData?.jlptLevel}"),
                        ),
                        Visibility(
                          visible: state.data.resultData?.strokeCount != null,
                          child: _infoChip("${"jisho_resultData_strokes".tr()} "
                              "${state.data.resultData?.strokeCount}"),
                        )
                      ],
                    ),
                    Visibility(
                      visible: state.data.resultData?.strokeOrderGifUri != null,
                      child: Container(
                        height: CustomSizes.defaultJishoGIF,
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(vertical: Margins.margin8),
                        child: Image.network(state.data.resultData?.strokeOrderGifUri ?? ""),
                      ),
                    ),
                    _displayInfo("jisho_resultData_meaning_label".tr(), state.data.resultData?.meaning),
                    _displayInfo("jisho_resultData_composed_label".tr(), state.data.resultData?.parts),
                    _displayInfoWithExample(context, "jisho_resultData_kunyomi".tr(),
                        state.data.resultData?.kunyomi,
                        state.data.resultData?.kunyomiExamples),
                    _displayInfoWithExample(context, "jisho_resultData_onyomi".tr(),
                        state.data.resultData?.onyomi,
                        state.data.resultData?.onyomiExamples),
                  ],
                ),
              ),
              Visibility(
                visible: state.data.example.isNotEmpty,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _displayExamplePhrases(context, state.data.example),
                  ],
                ),
              )
            ],
          ),
        ),
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

  Widget _displayExamplePhrases(BuildContext context, List<KanjiExample>? data) {
    return Visibility(
      visible: data != null && data.isNotEmpty,
      child: Container(
        margin: EdgeInsets.only(top: Margins.margin8),
        padding: EdgeInsets.symmetric(horizontal: Margins.margin16),
        child: ExpansionTile(
          childrenPadding: EdgeInsets.zero,
          tilePadding: EdgeInsets.zero,
          iconColor: Theme.of(context).brightness == Brightness.light
              ? Colors.black : Colors.white,
          textColor: Theme.of(context).brightness == Brightness.light
              ? Colors.black : Colors.white,
          title: Text("${"jisho_resultData_phrases_label".tr()} (${data?.length})",
              style: TextStyle(fontSize: FontSizes.fontSize18,
                fontWeight: FontWeight.bold, fontStyle: FontStyle.italic
          )),
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              child: ListView.builder(
                itemCount: data?.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: EdgeInsets.only(top: i != 0 ? Margins.margin16 : 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text("• ${data?[i].kanji}", maxLines: 2,
                              style: TextStyle(fontSize: FontSizes.fontSize16)
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: Margins.margin4),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text("  ${data?[i].kana}", maxLines: 2,
                                style: TextStyle(fontSize: FontSizes.fontSize16, fontStyle: FontStyle.italic)
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text("  ${data?[i].english}", maxLines: 2,
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
        )
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
      iconColor: Theme.of(context).brightness == Brightness.light
          ? Colors.black : Colors.white,
      textColor: Theme.of(context).brightness == Brightness.light
          ? Colors.black : Colors.white,
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

  Widget _infoChip(String? label) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Margins.margin4),
      child: Chip(
        backgroundColor: CustomColors.secondarySubtleColor,
        label: Text(label ?? ""),
      ),
    );
  }

  Widget _poweredByJisho() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Margins.margin8),
      child: Chip(
        backgroundColor: Colors.green,
        label: Text("jisho_resultData_powered_by".tr()),
      ),
    );
  }
}
