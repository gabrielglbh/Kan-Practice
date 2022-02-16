import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/core/utils/study_modes/mode_arguments.dart';
import 'package:kanpractice/ui/pages/jisho/arguments.dart';
import 'package:kanpractice/ui/pages/kanji_lists/widgets/KanListTile.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/CustomAlertDialog.dart';
import 'package:kanpractice/ui/widgets/DragContainer.dart';
import 'package:kanpractice/ui/widgets/ProgressIndicator.dart';
import 'package:kanpractice/ui/widgets/RadialGraph.dart';
import 'package:kanpractice/ui/widgets/TTSIconButton.dart';
import 'package:kanpractice/ui/widgets/WinRateBarChart.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/ui/widgets/kanji_bottom_sheet/bloc/kanji_bs_bloc.dart';

class KanjiBottomSheet extends StatelessWidget {
  /// Kanji object to be displayed
  final String listName;
  final Kanji? kanji;
  final Function()? onRemove;
  final Function()? onTap;
  const KanjiBottomSheet({required this.listName, required this.kanji,
    this.onTap, this.onRemove
  });

  /// Creates and calls the [BottomSheet] with the content for displaying the data
  /// of the current selected kanji
  static Future<String?> show(BuildContext context,
      String listName, Kanji? kanji, {Function()? onRemove, Function()? onTap}) async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => KanjiBottomSheet(
        listName: listName,
        kanji: kanji,
        onTap: onTap,
        onRemove: onRemove
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height - Margins.margin64
      ),
      onClosing: () {},
      builder: (context) {
        return Wrap(
          children: [
            Container(
              margin: EdgeInsets.all(Margins.margin8),
              /// Make sure we get the latest data of the Kanji when looking it up
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DragContainer(),
                  BlocProvider<KanjiBSBloc>(
                    create: (_) => KanjiBSBloc()..add(KanjiBSEventLoading(kanji ?? Kanji.empty)),
                    child: BlocListener<KanjiBSBloc, KanjiBSState>(
                      listener: (context, state) {
                        if (state is KanjiBSStateFailure) {
                          GeneralUtils.getSnackBar(context, state.error);
                        }
                        if (state is KanjiBSStateRemoved) {
                          if (onRemove != null) onRemove!();
                        }
                      },
                      child: BlocBuilder<KanjiBSBloc, KanjiBSState>(
                        builder: (context, state) {
                          if (state is KanjiBSStateLoading) {
                            return Center(child: Container(
                                height: MediaQuery.of(context).size.height / 2,
                                child: CustomProgressIndicator())
                            );
                          } else if (state is KanjiBSStateFailure) {
                            return Container(
                                height: MediaQuery.of(context).size.height / 2,
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(horizontal: Margins.margin16),
                                child: Text(state.error));
                          } else if (state is KanjiBSStateLoaded) {
                            return _body(context, state.kanji);
                          }
                          else return Container();
                        },
                      ),
                    ),
                  ),
                ],
              )
            ),
          ]
        );
      },
    );
  }
  
  Widget _body(BuildContext context, Kanji updatedKanji) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _header(context, updatedKanji),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Margins.margin16),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(updatedKanji.kanji, textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: FontSizes.fontSize32)),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: Margins.margin8, horizontal: Margins.margin16),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(updatedKanji.meaning, textAlign: TextAlign.center,
                style: TextStyle(fontSize: FontSizes.fontSize16))
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(CustomRadius.radius16)),
            margin: EdgeInsets.only(bottom: Margins.margin16, top: Margins.margin8),
            child: ListTile(
              title: StorageManager.readData(StorageManager.kanListGraphVisualization) == VisualizationMode.barChart.name
                  ? _barChart(updatedKanji) : RadialGraph(
                rateWriting: updatedKanji.winRateWriting,
                rateReading: updatedKanji.winRateReading,
                rateRecognition: updatedKanji.winRateRecognition,
                rateListening: updatedKanji.winRateListening,
              )
            ),
          ),
          _lastTimeShownWidget(context, updatedKanji),
          Visibility(
            visible: onTap != null && onRemove != null,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Divider(),
                _actionButtons(context),
              ],
            ),
          ),
        ]
    );
  }

  Widget _header(BuildContext context, Kanji updatedKanji) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Margins.margin8, horizontal: Margins.margin16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.menu_book_rounded),
            onPressed: () {
              Navigator.of(context).pushNamed(KanPracticePages.jishoPage,
                  arguments: JishoArguments(kanji: updatedKanji.kanji));
            },
          ),
          Container(
            height: Margins.margin24,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(updatedKanji.pronunciation, textAlign: TextAlign.center,
                  style: TextStyle(fontSize: FontSizes.fontSize16)),
            ),
          ),
          TTSIconButton(kanji: updatedKanji.pronunciation)
        ],
      )
    );
  }

  Widget _lastTimeShownWidget(BuildContext context, Kanji updatedKanji) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Margins.margin8),
      child: ExpansionTile(
        iconColor: CustomColors.secondaryColor,
        textColor: CustomColors.secondaryColor,
        title: FittedBox(
          fit: BoxFit.contain,
          child: Text("${"created_label".tr()} "
            "${GeneralUtils.parseDateMilliseconds(context, updatedKanji.dateAdded)} • "
            "${"last_seen_label".tr()} "
            "${GeneralUtils.parseDateMilliseconds(context, updatedKanji.dateLastShown)}",
            textAlign: TextAlign.center, style: TextStyle(fontSize: FontSizes.fontSize14))
        ),
        children: [
          Container(
            height: MediaQuery.of(context).size.height < CustomSizes.minimumHeight
                ? CustomSizes.maxHeightForLastSeenDates : null,
            child: ListView.builder(
              shrinkWrap: MediaQuery.of(context).size.height < CustomSizes.minimumHeight
                  ? false : true,
              itemCount: StudyModes.values.length,
              itemBuilder: (context, index) {
                return _lastSeenOnModes(context, updatedKanji, StudyModes.values[index]);
              },
            ),
          )
        ]
      )
    );
  }

  Widget _lastSeenOnModes(BuildContext context, Kanji updatedKanji, StudyModes mode) {
    int? date = 0;
    String parsedDate = "-";
    switch (mode) {
      case StudyModes.writing:
        date = updatedKanji.dateLastShownWriting;
        break;
      case StudyModes.reading:
        date = updatedKanji.dateLastShownReading;
        break;
      case StudyModes.recognition:
        date = updatedKanji.dateLastShownRecognition;
        break;
      case StudyModes.listening:
        date = updatedKanji.dateLastShownListening;
        break;
    }
    if (date != 0) parsedDate = "${"last_seen_label".tr()} ${GeneralUtils.parseDateMilliseconds(context, date)}";

    return Container(
      height: Margins.margin24,
      padding: EdgeInsets.only(
        left: Margins.margin8, right: Margins.margin16, bottom: Margins.margin8
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(" • ${(mode.mode).capitalized}:",
              overflow: TextOverflow.ellipsis, textAlign: TextAlign.left,
                style: TextStyle(fontSize: FontSizes.fontSize14)),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(parsedDate, overflow: TextOverflow.ellipsis, textAlign: TextAlign.right,
                  style: TextStyle(fontSize: FontSizes.fontSize14)),
              ),
            )
          )
        ],
      ),
    );
  }

  Widget _barChart(Kanji updatedKanji) {
    return WinRateBarChart(dataSource: List.generate(StudyModes.values.length, (index) {
      switch (StudyModes.values[index]) {
        case StudyModes.writing:
          return BarData(x: StudyModes.writing.mode,
              y: (updatedKanji.winRateWriting),
              color: StudyModes.writing.color);
        case StudyModes.reading:
          return BarData(x: StudyModes.reading.mode,
              y: (updatedKanji.winRateReading),
              color: StudyModes.reading.color);
        case StudyModes.recognition:
          return BarData(x: StudyModes.recognition.mode,
              y: (updatedKanji.winRateRecognition),
              color: StudyModes.recognition.color);
        case StudyModes.listening:
          return BarData(x: StudyModes.listening.mode,
              y: (updatedKanji.winRateListening),
              color: StudyModes.listening.color);
      }
    }));
  }

  Container _actionButtons(BuildContext bloc) {
    return Container(
      height: CustomSizes.actionButtonsKanjiDetail,
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              title: Text("kanji_bottom_sheet_removal_label".tr()),
              trailing: Icon(Icons.clear),
              onTap: () {
                showDialog(
                  context: bloc,
                  builder: (context) => CustomDialog(
                    title: Text("kanji_bottom_sheet_removeKanji_title".tr()),
                    content: Text("kanji_bottom_sheet_removeKanji_content".tr()),
                    positiveButtonText: "kanji_bottom_sheet_removeKanji_positive".tr(),
                    onPositive: () {
                      Navigator.of(context).pop();
                      bloc.read<KanjiBSBloc>()..add(KanjiBSEventDelete(kanji));
                      if (onRemove != null) onRemove!();
                    }
                  )
                );
              },
            ),
          ),
          RotatedBox(quarterTurns: 1, child: Divider()),
          Expanded(
            child: ListTile(
              title: Text("kanji_bottom_sheet_update_label".tr()),
              trailing: Icon(Icons.arrow_forward_rounded),
              onTap: () {
                Navigator.of(bloc).pop();
                if (onTap != null) onTap!();
              },
            ),
          )
        ],
      ),
    );
  }
}