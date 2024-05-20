import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/test_result/test_result_bloc.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/presentation/core/types/grammar_modes.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/test_result/test_result.dart';
import 'package:kanpractice/presentation/core/widgets/graphs/kp_win_rate_chart.dart';
import 'package:kanpractice/presentation/core/widgets/kp_action_button.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/widgets/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/widgets/kp_switch.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/test_result_page/arguments.dart';
import 'package:kanpractice/presentation/test_result_page/widgets/grammar_on_test_list.dart';
import 'package:kanpractice/presentation/test_result_page/widgets/words_on_test_list.dart';

class TestResultPage extends StatefulWidget {
  final TestResultArguments args;
  const TestResultPage({super.key, required this.args});

  @override
  State<TestResultPage> createState() => _TestResultPageState();
}

class _TestResultPageState extends State<TestResultPage> {
  bool _performAnotherTest = true;
  late Test test;

  @override
  void initState() {
    test = Test(
      testScore: widget.args.score,
      wordsInTest: widget.args.word,
      studyMode: widget.args.studyMode,
      grammarMode: widget.args.grammarMode,
      testMode: widget.args.testMode,
      lists: widget.args.listsName,
      takenDate: Utils.getCurrentMilliseconds(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<TestResultBloc>()..add(TestResultEventSaveTest(test: test)),
      child: KPScaffold(
        onWillPop: () async => false,
        automaticallyImplyLeading: false,
        toolbarHeight: KPMargins.margin32,
        appBarTitle: null,
        child: BlocBuilder<TestResultBloc, TestResultState>(
          builder: (context, state) {
            return state.maybeWhen(
              saving: () => const Center(child: KPProgressIndicator()),
              orElse: () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "test_result_title".tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  KPWinRateChart(
                    winRate: widget.args.score,
                    backgroundColor: widget.args.grammarList != null
                        ? GrammarModes.values[widget.args.grammarMode!].color
                        : StudyModes.values[widget.args.studyMode!].color,
                    size: MediaQuery.of(context).size.width / 2.5,
                    rateSize: KPChartSize.large,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: KPMargins.margin8),
                    child: Text("test_result_disclaimer".tr(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                  Visibility(
                    visible: widget.args.studyList != null,
                    child: Expanded(
                      child: WordsOnTestList(
                        list: widget.args.studyList,
                        tappable: !widget.args.alterTest,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.args.grammarList != null,
                    child: Expanded(
                      child: GrammarPointOnTestList(
                        list: widget.args.grammarList,
                        mode: GrammarModes.values[widget.args.grammarMode ?? 0],
                      ),
                    ),
                  ),
                  const SizedBox(height: KPMargins.margin8),
                  ListTile(
                      leading: Icon(Icons.track_changes_rounded,
                          color: Theme.of(context).colorScheme.primary),
                      title: Text("test_result_do_test_button_label".tr()),
                      visualDensity: const VisualDensity(vertical: -2),
                      onTap: () => setState(
                          () => _performAnotherTest = !_performAnotherTest),
                      trailing: KPSwitch(
                        value: _performAnotherTest,
                        onChanged: (value) =>
                            setState(() => _performAnotherTest = value),
                      )),
                  KPActionButton(
                      label: "test_result_save_button_label".tr(),
                      vertical: KPMargins.margin16,
                      onTap: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            KanPracticePages.homePage, (route) => false,
                            arguments: _performAnotherTest);
                      }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
