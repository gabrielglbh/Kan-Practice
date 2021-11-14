import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/queries/test_queries.dart';
import 'package:kanpractice/ui/pages/test_result/arguments.dart';
import 'package:kanpractice/ui/theme/theme_consts.dart';
import 'package:kanpractice/ui/widgets/WinRateChart.dart';

class TestResult extends StatelessWidget {
  final TestResultArguments args;
  const TestResult({required this.args});

  Future<bool> _onWillPop() async {
    await TestQueries.instance.createTest(args.score, args.kanji, args.studyMode, args.listsName);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(toolbarHeight: appBarHeight),
        body: Column(
          children: [
            Text("You have obtained...",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 48),
            ),
            WinRateChart(
              title: "",
              winRate: args.score,
              size: MediaQuery.of(context).size.width / 1.5,
              rateSize: 64,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text("The result will be saved in to your device. All results can be "
                  "visualized in your settings.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text("You now can close this page.", textAlign: TextAlign.center),
            )
          ],
        ),
      ),
    );
  }
}
