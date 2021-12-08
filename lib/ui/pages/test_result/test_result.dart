import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/queries/test_queries.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/ui/pages/test_result/arguments.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/ActionButton.dart';
import 'package:kanpractice/ui/widgets/WinRateChart.dart';
import 'package:easy_localization/easy_localization.dart';

class TestResult extends StatelessWidget {
  final TestResultArguments args;
  const TestResult({required this.args});

  double? _getProperKanjiWinRate(Kanji? kanji) {
    if (args.studyMode == 0) return kanji?.winRateWriting;
    else if (args.studyMode == 1) return kanji?.winRateReading;
    else return kanji?.winRateRecognition;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: CustomSizes.appBarHeight,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("test_result_title".tr(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: FontSizes.fontSize32),
            ),
            WinRateChart(
              title: "",
              winRate: args.score,
              size: MediaQuery.of(context).size.width / 2,
              rateSize: ChartSize.medium,
            ),
            Expanded(child: Padding(
              padding: EdgeInsets.all(Margins.margin16),
              child: _kanjiOnTest(),
            )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Margins.margin8),
              child: Text("test_result_disclaimer".tr(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: FontSizes.fontSize20),
              ),
            ),
            ActionButton(
              label: "test_result_save_button_label".tr(),
              vertical: Margins.margin32,
              onTap: () async {
                await TestQueries.instance.createTest(args.score, args.kanji, args.studyMode, args.listsName);
                /// Remove all navigation stack and push kanList
                Navigator.of(context).pushNamedAndRemoveUntil(
                    KanPracticePages.kanjiListPage, (route) => false);
              }
            )
          ],
        ),
      ),
    );
  }

  Widget _kanjiOnTest() {
    return ListView.builder(
      itemCount: args.studyList.keys.toList().length,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Text(args.studyList.keys.toList()[index]),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: args.studyList[index]?.length,
                itemBuilder: (context, inner) {
                  Kanji? kanji = args.studyList[index]?[inner];
                  return Container(
                    decoration: BoxDecoration(
                      color: GeneralUtils.getColorBasedOnWinRate((_getProperKanjiWinRate(kanji) ?? 0)),
                      borderRadius: BorderRadius.all(Radius.circular(CustomRadius.radius8)),
                      boxShadow: [
                        BoxShadow(color: Colors.grey, offset: Offset(0, 3), blurRadius: CustomRadius.radius4)
                      ],
                    ),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text((kanji?.kanji ?? ""), textAlign: TextAlign.center,
                          style: TextStyle(fontSize: FontSizes.fontSize20, color: Colors.black)),
                    )
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
}
