import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/core/utils/study_modes/mode_arguments.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/CustomAlertDialog.dart';
import 'package:kanpractice/ui/widgets/WinRateBarChart.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/ui/widgets/WinRateChart.dart';

enum VisualizationMode { barChart, radialChart }

class KanListTile extends StatelessWidget {
  /// [KanjiList] item to paint as a Tile
  final KanjiList item;
  /// Action to perform when returning from the kanji_list_details
  final Function onPopWhenTapped;
  /// Action to perform when tapping on a [KanjiList], in addition to navigating to kanji_list_details
  final Function onTap;
  /// Action to perform when removing a [KanjiList]
  final Function onRemoval;
  /// Mode to show the statistics
  final VisualizationMode mode;
  const KanListTile({required this.item, required this.onTap, required this.onPopWhenTapped,
    required this.onRemoval, this.mode = VisualizationMode.radialChart
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        onTap();
        await Navigator.of(context).pushNamed(KanPracticePages.kanjiListDetailsPage, arguments: item)
            .then((_) => onPopWhenTapped());
      },
      onLongPress: () => _createDialogForDeletingKanList(context, item),
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: Margins.margin8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(item.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: FontSizes.fontSize24, fontWeight: FontWeight.bold)),
            ),
            Text("${"created_label".tr()} ${GeneralUtils.parseDateMilliseconds(context, item.lastUpdated)}",
                style: TextStyle(fontSize: FontSizes.fontSize12))
          ],
        ),
      ),
      subtitle: mode == VisualizationMode.barChart ? _barChart() : _radialBarChart(context)
    );
  }

  Widget _barChart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WinRateBarChart(dataSource: [
          BarData(x: StudyModes.writing.mode, y: item.totalWinRateWriting, color: StudyModes.writing.color),
          BarData(x: StudyModes.reading.mode, y: item.totalWinRateReading, color: StudyModes.reading.color),
          BarData(x: StudyModes.recognition.mode, y: item.totalWinRateRecognition, color: StudyModes.recognition.color),
        ])
      ],
    );
  }

  Widget _radialBarChart(BuildContext context) {
    double height = CustomSizes.defaultSizeWinRateChart + Margins.margin32;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _radialChart(height),
        Container(
          width: MediaQuery.of(context).size.width / 2, height: height,
          alignment: Alignment.center,
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: StudyModes.values.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 2.5
            ),
            itemBuilder: (context, index) {
              double rate = 0;
              switch (StudyModes.values[index]) {
                case StudyModes.writing:
                  rate = item.totalWinRateWriting; break;
                case StudyModes.reading:
                  rate = item.totalWinRateReading; break;
                case StudyModes.recognition:
                  rate = item.totalWinRateRecognition; break;
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: Margins.margin8, height: Margins.margin8,
                    margin: EdgeInsets.only(right: Margins.margin8, top: Margins.margin4),
                    decoration: BoxDecoration(shape: BoxShape.circle, color: StudyModes.values[index].color),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${StudyModes.values[index].mode}:",
                          overflow: TextOverflow.ellipsis,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: Margins.margin16),
                          child: Text(
                            "${GeneralUtils.getFixedDouble(rate*100)}%",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _radialChart(double height) {
    return Container(
      width: height, height: height,
      child: Stack(
        children: [
          Positioned(
            left: 0, right: 0, top: 18, bottom: 18,
            child: WinRateChart(
              winRate: item.totalWinRateRecognition,
              backgroundColor: Colors.transparent,
              chartColor: StudyModes.recognition.color,
              showGaugeAnnotation: false, padding: EdgeInsets.zero,
              widthLine: 0.15,
            ),
          ),
          Positioned(
            left: 0, right: 0, top: 10, bottom: 10,
            child: WinRateChart(
              winRate: item.totalWinRateReading,
              backgroundColor: Colors.transparent,
              chartColor: StudyModes.reading.color,
              showGaugeAnnotation: false, padding: EdgeInsets.zero,
              widthLine: 0.15,
            ),
          ),
          Positioned(
            left: 0, right: 0, top: 0, bottom: 0,
            child: WinRateChart(
              winRate: item.totalWinRateWriting,
              backgroundColor: Colors.transparent,
              chartColor: StudyModes.writing.color,
              showGaugeAnnotation: false, padding: EdgeInsets.zero,
              widthLine: 0.15,
            ),
          ),
        ],
      ),
    );
  }

  _createDialogForDeletingKanList(BuildContext context, KanjiList l) {
    showDialog(
      context: context,
      builder: (context) => CustomDialog(
        title: Text("kan_list_tile_createDialogForDeletingKanList_title".tr()),
        content: Text("kan_list_tile_createDialogForDeletingKanList_content".tr()),
        positiveButtonText: "kan_list_tile_createDialogForDeletingKanList_positive".tr(),
        onPositive: () => onRemoval(),
      )
    );
  }
}
