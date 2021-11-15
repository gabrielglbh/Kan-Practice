import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/queries/test_queries.dart';
import 'package:kanpractice/ui/pages/test_result/arguments.dart';
import 'package:kanpractice/ui/theme/theme_consts.dart';
import 'package:kanpractice/ui/widgets/ActionButton.dart';
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
          toolbarHeight: CustomSizes.appBarHeight,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("test_result_title".tr(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32),
              ),
              WinRateChart(
                title: "",
                winRate: args.score,
                size: MediaQuery.of(context).size.width / 2,
                rateSize: 32,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Text("test_result_disclaimer".tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              ActionButton(
                label: "test_result_save_button_label".tr(),
                onTap: () async {
                  await TestQueries.instance.createTest(args.score, args.kanji, args.studyMode, args.listsName);
                  Navigator.of(context).pop();
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
