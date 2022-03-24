import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/core/utils/study_modes/mode_arguments.dart';
import 'package:kanpractice/ui/pages/kanji_lists/widgets/KanListTile.dart';
import 'package:kanpractice/ui/pages/statistics/bloc/stats_bloc.dart';
import 'package:kanpractice/ui/pages/statistics/model/stats.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/ui/widgets/ProgressIndicator.dart';
import 'package:kanpractice/ui/widgets/RadialGraph.dart';
import 'package:kanpractice/ui/widgets/WinRateBarChart.dart';

class StatisticsPage extends StatelessWidget {
  StatisticsPage();
  final StatisticsBloc _bloc = StatisticsBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: CustomSizes.appBarHeight,
        title: FittedBox(fit: BoxFit.fitWidth, child: Text("settings_general_statistics".tr())),
      ),
      body: BlocProvider<StatisticsBloc>(
        create: (_) => _bloc..add(StatisticsEventLoading()),
        child: BlocBuilder<StatisticsBloc, StatsState>(
          builder: (context, state) {
            if (state is StatisticsLoaded) {
              return _body(context, state);
            } else if (state is StatisticsLoading) {
              return CustomProgressIndicator();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  ListView _body(BuildContext context, StatisticsLoaded state) {
    final KanPracticeStats s = state.stats;
    final mode = VisualizationModeExt.mode(StorageManager.readData(
        StorageManager.kanListGraphVisualization) ?? VisualizationMode.radialChart);

    return ListView(
      children: [
        _header("stats_words".tr()),
        _countLabel(s.totalKanji.toString()),
        Padding(
          padding: EdgeInsets.only(top: Margins.margin16),
          child: mode == VisualizationMode.radialChart ? RadialGraph(
            rateWriting: s.totalWinRateWriting,
            rateReading: s.totalWinRateReading,
            rateRecognition: s.totalWinRateRecognition,
            rateListening: s.totalWinRateListening,
          ) : _barChart(s.totalWinRateWriting, s.totalWinRateReading,
              s.totalWinRateRecognition, s.totalWinRateListening),
        ),
        Divider(),
        _header("${"stats_tests".tr()} • ${GeneralUtils.roundUpAsString(
            GeneralUtils.getFixedDouble(s.totalTestAccuracy * 100))}%"),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(StudyModes.values.length, (index) {
            switch (StudyModes.values[index]) {
              case StudyModes.writing:
                return Row(
                  children: [
                    _bullet(StudyModes.values[index]),
                    Text(s.testTotalCountWriting.toString())
                  ],
                );
              case StudyModes.reading:
                return Row(
                  children: [
                    _bullet(StudyModes.values[index]),
                    Text(s.testTotalCountReading.toString())
                  ],
                );
              case StudyModes.recognition:
                return Row(
                  children: [
                    _bullet(StudyModes.values[index]),
                    Text(s.testTotalCountRecognition.toString())
                  ],
                );
              case StudyModes.listening:
                return Row(
                  children: [
                    _bullet(StudyModes.values[index]),
                    Text(s.testTotalCountListening.toString())
                  ],
                );
            }
          }),
        ),
        _countLabel(s.totalTests.toString()),
        Padding(
          padding: EdgeInsets.only(top: Margins.margin16),
          child: mode == VisualizationMode.radialChart ? RadialGraph(
            rateWriting: s.testTotalWinRateWriting,
            rateReading: s.testTotalWinRateReading,
            rateRecognition: s.testTotalWinRateRecognition,
            rateListening: s.testTotalWinRateListening,
          ) : _barChart(s.testTotalWinRateWriting, s.testTotalWinRateReading,
              s.testTotalWinRateRecognition, s.testTotalWinRateListening)
        )
      ],
    );
  }

  ListTile _header(String title) {
    return ListTile(
      title: Text(title,
          style: TextStyle(fontSize: FontSizes.fontSize20, fontWeight: FontWeight.bold)
      ),
    );
  }

  Widget _countLabel(String count) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Margins.margin16),
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Text(count, style: TextStyle(fontSize: FontSizes.fontSize64)
        ),
      ),
    );
  }

  Container _bullet(StudyModes mode) {
    return Container(
      width: Margins.margin8, height: Margins.margin8,
      margin: EdgeInsets.only(
          right: Margins.margin8, left: Margins.margin8, top: Margins.margin4
      ),
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: mode.color
      ),
    );
  }

  Widget _barChart(double w, double r, double recog, double l) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WinRateBarChart(dataSource: List.generate(StudyModes.values.length, (index) {
          switch (StudyModes.values[index]) {
            case StudyModes.writing:
              return BarData(x: StudyModes.writing.mode, y: w, color: StudyModes.writing.color);
            case StudyModes.reading:
              return BarData(x: StudyModes.reading.mode, y: r, color: StudyModes.reading.color);
            case StudyModes.recognition:
              return BarData(x: StudyModes.recognition.mode, y: recog, color: StudyModes.recognition.color);
            case StudyModes.listening:
              return BarData(x: StudyModes.listening.mode, y: l, color: StudyModes.listening.color);
          }
        }))
      ],
    );
  }
}
