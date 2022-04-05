import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/queries/test_queries.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/core/utils/study_modes/mode_arguments.dart';
import 'package:kanpractice/ui/pages/test_result/arguments.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/ActionButton.dart';
import 'package:kanpractice/ui/widgets/kanji_bottom_sheet/KanjiBottomSheet.dart';
import 'package:kanpractice/ui/widgets/WinRateChart.dart';
import 'package:easy_localization/easy_localization.dart';

class TestResult extends StatefulWidget {
  final TestResultArguments args;
  const TestResult({required this.args});

  @override
  State<TestResult> createState() => _TestResultState();
}

class _TestResultState extends State<TestResult> {
  bool _performAnotherTest = false;

  /// Saves the current test on the database on the initialization of the current
  /// page to avoid unusual behaviors.
  Future<void> _saveTest() async {
    await TestQueries.instance.createTest(widget.args.score,
        widget.args.kanji, widget.args.studyMode, widget.args.listsName);
  }

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) async => await _saveTest());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: Margins.margin32,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Margins.margin16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("test_result_title".tr(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: FontSizes.fontSize32),
              ),
              WinRateChart(
                winRate: widget.args.score,
                backgroundColor: StudyModesUtil.mapStudyMode(widget.args.studyMode).color,
                size: MediaQuery.of(context).size.width / 2.5,
                rateSize: ChartSize.large,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: Margins.margin8),
                child: Text("test_result_disclaimer".tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: FontSizes.fontSize16),
                ),
              ),
              Visibility(
                visible: widget.args.studyList != null,
                child: Expanded(child: _kanjiOnTest())
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.track_changes_rounded, color: CustomColors.getSecondaryColor(context)),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: Margins.margin8),
                            child: Text("test_result_do_test_button_label".tr(),
                                maxLines: 2,
                                style: TextStyle(fontSize: FontSizes.fontSize16)
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: _performAnotherTest,
                    onChanged: (value) => setState(() =>  _performAnotherTest = value)
                  ),
                ],
              ),
              ActionButton(
                label: "test_result_save_button_label".tr(),
                vertical: Margins.margin16,
                onTap: () {
                  /// Remove all navigation stack and push kanList
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      KanPracticePages.kanjiListPage, (route) => false,
                      arguments: _performAnotherTest
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _kanjiOnTest() {
    return ListView.builder(
      itemCount: widget.args.studyList?.keys.toList().length,
      itemBuilder: (context, index) {
        String? listName = widget.args.studyList?.keys.toList()[index];
        return Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 3.5,
              child: Text(
                "$listName (${widget.args.studyList?[listName]?.length}):",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: FontSizes.fontSize16)
              ),
            ),
            Expanded(
              child: Container(
                height: CustomSizes.defaultResultKanjiListOnTest,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.args.studyList?[listName]?.length,
                  itemBuilder: (context, inner) {
                    Kanji? kanji = widget.args.studyList?[listName]?[inner].keys.first;
                    double? testScore = widget.args.studyList?[listName]?[inner].values.first;
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
            await KanjiBottomSheet.show(context,
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
