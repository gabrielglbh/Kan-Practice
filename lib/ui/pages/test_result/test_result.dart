import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/queries/test_queries.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/core/utils/study_modes/mode_arguments.dart';
import 'package:kanpractice/ui/pages/test_result/arguments.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/ActionButton.dart';
import 'package:kanpractice/ui/widgets/KanjiBottomSheet.dart';
import 'package:kanpractice/ui/widgets/WinRateChart.dart';
import 'package:easy_localization/easy_localization.dart';

class TestResult extends StatelessWidget {
  final TestResultArguments args;
  const TestResult({required this.args});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: Margins.margin32,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("test_result_title".tr(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: FontSizes.fontSize32),
            ),
            WinRateChart(
              winRate: args.score,
              backgroundColor: StudyModesUtil.mapStudyMode(args.studyMode).color,
              size: MediaQuery.of(context).size.width / 2.5,
              rateSize: ChartSize.medium,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: Margins.margin8, right: Margins.margin8,
                bottom: Margins.margin8
              ),
              child: Text("test_result_disclaimer".tr(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: FontSizes.fontSize16),
              ),
            ),
            Expanded(child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Margins.margin16),
              child: _kanjiOnTest(),
            )),
            ActionButton(
              label: "test_result_save_button_label".tr(),
              vertical: Margins.margin16,
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
        String? listName = args.studyList.keys.toList()[index];
        return Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 3.5,
              child: Text(
                "(${args.studyList[listName]?.length}) $listName:",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: FontSizes.fontSize16)
              ),
            ),
            Expanded(
              child: Container(
                height: CustomSizes.defaultResultKanjiListOnTest,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: args.studyList[listName]?.length,
                  itemBuilder: (context, inner) {
                    Kanji? kanji = args.studyList[listName]?[inner].keys.first;
                    double? testScore = args.studyList[listName]?[inner].values.first;
                    return _kanjiElement(context, kanji, testScore);
                  },
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget _kanjiElement(BuildContext context, Kanji? kanji, double? testScore) {
    return Container(
      width: CustomSizes.defaultSizeKanjiItemOnResultTest,
      margin: EdgeInsets.only(
          left: Margins.margin4, right: Margins.margin4,
          bottom: Margins.margin4, top: Margins.margin4
      ),
      decoration: BoxDecoration(
        color: GeneralUtils.getColorBasedOnWinRate(testScore ?? 0),
        borderRadius: BorderRadius.all(Radius.circular(CustomRadius.radius8)),
        boxShadow: [
          BoxShadow(color: Colors.grey, offset: Offset(0, 0.5), blurRadius: CustomRadius.radius4)
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(CustomRadius.radius8)),
          onTap: () async {
            await KanjiBottomSheet.callKanjiModeBottomSheet(context,
                (kanji?.listName ?? ""), kanji);
          },
          // _createDialogForDeletingKanji(context, kanji.kanji),,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: Margins.margin2),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text((kanji?.kanji ?? ""), textAlign: TextAlign.center,
                  style: TextStyle(fontSize: FontSizes.fontSize20, color: Colors.black)),
            )
          )
        ),
      ),
    );
  }
}
