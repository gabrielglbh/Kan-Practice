import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/test_result/test_result_bloc.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/test_result/test_result.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/presentation/core/ui/graphs/kp_win_rate_chart.dart';
import 'package:kanpractice/presentation/core/ui/kp_action_button.dart';
import 'package:kanpractice/presentation/core/ui/kp_kanji_bottom_sheet.dart';
import 'package:kanpractice/presentation/core/ui/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/ui/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/test_result_page/arguments.dart';

class TestResultPage extends StatefulWidget {
  final TestResultArguments args;
  const TestResultPage({Key? key, required this.args}) : super(key: key);

  @override
  State<TestResultPage> createState() => _TestResultPageState();
}

class _TestResultPageState extends State<TestResultPage> {
  bool _performAnotherTest = false;

  @override
  void initState() {
    final test = Test(
      testScore: widget.args.score,
      wordsInTest: widget.args.kanji,
      studyMode: widget.args.studyMode,
      testMode: widget.args.testMode,
      lists: widget.args.listsName,
      takenDate: Utils.getCurrentMilliseconds(),
    );
    getIt<TestResultBloc>().add(TestResultEventSaveTest(test: test));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KPScaffold(
      onWillPop: () async => false,
      automaticallyImplyLeading: false,
      toolbarHeight: KPMargins.margin32,
      appBarTitle: null,
      child: BlocBuilder<TestResultBloc, TestResultState>(
        builder: (context, state) {
          if (state is TestResultStateSaving) {
            return const Center(
              child: KPProgressIndicator(),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "test_result_title".tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
              WinRateChart(
                winRate: widget.args.score,
                backgroundColor: StudyModes.values[widget.args.studyMode].color,
                size: MediaQuery.of(context).size.width / 2.5,
                rateSize: KPChartSize.large,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: KPMargins.margin8),
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
                            color: KPColors.getSecondaryColor(context)),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: KPMargins.margin16),
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
                    activeColor: KPColors.secondaryDarkerColor,
                    activeTrackColor: KPColors.secondaryColor,
                    onChanged: (value) =>
                        setState(() => _performAnotherTest = value),
                  ),
                ],
              ),
              KPActionButton(
                  label: "test_result_save_button_label".tr(),
                  vertical: KPMargins.margin16,
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        KanPracticePages.homePage, (route) => false,
                        arguments: _performAnotherTest);
                  }),
            ],
          );
        },
      ),
    );
  }

  Widget _kanjiOnTest() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KPMargins.margin8),
      child: ListView.builder(
        itemCount: widget.args.studyList?.keys.toList().length,
        itemBuilder: (context, index) {
          String? listName = widget.args.studyList?.keys.toList()[index];
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: KPMargins.margin8),
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
                  Word? kanji =
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

  Widget _kanjiElement(BuildContext context, Word? kanji, double? testScore) {
    return Container(
      width: KPSizes.defaultSizeKanjiItemOnResultTest,
      margin: const EdgeInsets.only(
          left: KPMargins.margin4,
          right: KPMargins.margin4,
          bottom: KPMargins.margin4,
          top: KPMargins.margin4),
      decoration: BoxDecoration(
        color: Utils.getColorBasedOnWinRate(testScore ?? 0),
        borderRadius: const BorderRadius.all(Radius.circular(KPRadius.radius8)),
        boxShadow: const [
          BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 0.5),
              blurRadius: KPRadius.radius4)
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            borderRadius:
                const BorderRadius.all(Radius.circular(KPRadius.radius8)),
            onTap: () async {
              await KPKanjiBottomSheet.show(
                  context, (kanji?.listName ?? ""), kanji);
            },
            // _createDialogForDeletingKanji(context, kanji.kanji),,
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: KPMargins.margin2),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text((kanji?.word ?? ""),
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(color: KPColors.accentLight)),
                ))),
      ),
    );
  }
}
