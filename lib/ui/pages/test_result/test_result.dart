import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/models/test_result.dart';
import 'package:kanpractice/core/database/queries/test_queries.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/ui/pages/test_result/arguments.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/widgets/kp_action_button.dart';
import 'package:kanpractice/ui/widgets/kanji_bottom_sheet/kp_kanji_bottom_sheet.dart';
import 'package:kanpractice/ui/widgets/graphs/kp_win_rate_chart.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/ui/widgets/kp_scaffold.dart';

class TestResult extends StatefulWidget {
  final TestResultArguments args;
  const TestResult({Key? key, required this.args}) : super(key: key);

  @override
  State<TestResult> createState() => _TestResultState();
}

class _TestResultState extends State<TestResult> {
  bool _performAnotherTest = false;

  /// Saves the current test on the database on the initialization of the current
  /// page to avoid unusual behaviors.
  Future<void> _saveTest() async {
    final test = Test(
        testScore: widget.args.score,
        kanjiInTest: widget.args.kanji,
        studyMode: widget.args.studyMode,
        testMode: widget.args.testMode,
        kanjiLists: widget.args.listsName,
        takenDate: GeneralUtils.getCurrentMilliseconds());
    await TestQueries.instance.createTest(test);
    await TestQueries.instance.updateStats(test);
  }

  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) async => await _saveTest());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KPScaffold(
      onWillPop: () async => false,
      automaticallyImplyLeading: false,
      toolbarHeight: Margins.margin32,
      appBarTitle: null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "test_result_title".tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4,
          ),
          WinRateChart(
            winRate: widget.args.score,
            backgroundColor:
                StudyModesUtil.mapStudyMode(widget.args.studyMode).color,
            size: MediaQuery.of(context).size.width / 2.5,
            rateSize: ChartSize.large,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: Margins.margin8),
            child: Text("test_result_disclaimer".tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1),
          ),
          Visibility(
              visible: widget.args.studyList != null,
              child: Expanded(child: _kanjiOnTest())),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.track_changes_rounded,
                        color: CustomColors.getSecondaryColor(context)),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: Margins.margin16),
                        child: Text("test_result_do_test_button_label".tr(),
                            maxLines: 2,
                            style: Theme.of(context).textTheme.bodyText1),
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: _performAnotherTest,
                activeColor: CustomColors.secondaryDarkerColor,
                activeTrackColor: CustomColors.secondaryColor,
                onChanged: (value) =>
                    setState(() => _performAnotherTest = value),
              ),
            ],
          ),
          KPActionButton(
              label: "test_result_save_button_label".tr(),
              vertical: Margins.margin16,
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    KanPracticePages.homePage, (route) => false,
                    arguments: _performAnotherTest);
              }),
        ],
      ),
    );
  }

  Widget _kanjiOnTest() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Margins.margin8),
      child: ListView.builder(
        itemCount: widget.args.studyList?.keys.toList().length,
        itemBuilder: (context, index) {
          String? listName = widget.args.studyList?.keys.toList()[index];
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Margins.margin8),
                child: Text(
                    "$listName (${widget.args.studyList?[listName]?.length}):",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5, childAspectRatio: 2),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.args.studyList?[listName]?.length,
                itemBuilder: (context, inner) {
                  Kanji? kanji =
                      widget.args.studyList?[listName]?[inner].keys.first;
                  double? testScore =
                      widget.args.studyList?[listName]?[inner].values.first;
                  return _kanjiElement(context, kanji, testScore);
                },
              )
            ],
          );
        },
      ),
    );
  }

  Widget _kanjiElement(BuildContext context, Kanji? kanji, double? testScore) {
    return Container(
      width: CustomSizes.defaultSizeKanjiItemOnResultTest,
      margin: const EdgeInsets.only(
          left: Margins.margin4,
          right: Margins.margin4,
          bottom: Margins.margin4,
          top: Margins.margin4),
      decoration: BoxDecoration(
        color: GeneralUtils.getColorBasedOnWinRate(testScore ?? 0),
        borderRadius:
            const BorderRadius.all(Radius.circular(CustomRadius.radius8)),
        boxShadow: const [
          BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 0.5),
              blurRadius: CustomRadius.radius4)
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            borderRadius:
                const BorderRadius.all(Radius.circular(CustomRadius.radius8)),
            onTap: () async {
              await KPKanjiBottomSheet.show(
                  context, (kanji?.listName ?? ""), kanji);
            },
            // _createDialogForDeletingKanji(context, kanji.kanji),,
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: Margins.margin2),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text((kanji?.kanji ?? ""),
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(color: Colors.black)),
                ))),
      ),
    );
  }
}
