import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/core/types/kanji_categories.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:kanpractice/core/types/visualization_mode.dart';
import 'package:kanpractice/ui/pages/jisho/arguments.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/widgets/kp_alert_dialog.dart';
import 'package:kanpractice/ui/widgets/graphs/kp_dependent_graph.dart';
import 'package:kanpractice/ui/widgets/kp_drag_container.dart';
import 'package:kanpractice/ui/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/ui/widgets/kp_tts_icon_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/ui/widgets/kanji_bottom_sheet/bloc/kanji_bs_bloc.dart';

class KPKanjiBottomSheet extends StatelessWidget {
  /// Kanji object to be displayed
  final String listName;
  final Kanji? kanji;
  final Function()? onRemove;
  final Function()? onTap;
  const KPKanjiBottomSheet({
    Key? key,
    required this.listName,
    required this.kanji,
    this.onTap, this.onRemove
  }) : super(key: key);

  /// Creates and calls the [BottomSheet] with the content for displaying the data
  /// of the current selected kanji
  static Future<String?> show(BuildContext context,
      String listName, Kanji? kanji, {Function()? onRemove, Function()? onTap}) async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => KPKanjiBottomSheet(
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
              margin: const EdgeInsets.all(Margins.margin8),
              /// Make sure we get the latest data of the Kanji when looking it up
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const KPDragContainer(),
                  BlocProvider<KanjiBSBloc>(
                    create: (_) => KanjiBSBloc()..add(KanjiBSEventLoading(kanji ?? Kanji.empty)),
                    child: BlocConsumer<KanjiBSBloc, KanjiBSState>(
                      listener: (context, state) {
                        if (state is KanjiBSStateFailure) {
                          GeneralUtils.getSnackBar(context, state.error);
                        }
                        if (state is KanjiBSStateRemoved) {
                          if (onRemove != null) onRemove!();
                        }
                      },
                      builder: (context, state) {
                        if (state is KanjiBSStateLoading) {
                          return Center(child: SizedBox(
                              height: MediaQuery.of(context).size.height / 2,
                              child: const KPProgressIndicator())
                          );
                        } else if (state is KanjiBSStateFailure) {
                          return Container(
                              height: MediaQuery.of(context).size.height / 2,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(horizontal: Margins.margin16),
                              child: Text(state.error));
                        } else if (state is KanjiBSStateLoaded) {
                          return _body(context, state.kanji);
                        }
                        else {
                          return Container();
                        }
                      },
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
            padding: const EdgeInsets.symmetric(horizontal: Margins.margin16),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(KanjiCategory.values[updatedKanji.category].category,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontStyle: FontStyle.italic
                ))
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Margins.margin16),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(updatedKanji.kanji, textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4?.copyWith(fontWeight: FontWeight.bold)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Margins.margin8, horizontal: Margins.margin16),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(updatedKanji.meaning, textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2)
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(CustomRadius.radius16)),
            margin: const EdgeInsets.only(bottom: Margins.margin16, top: Margins.margin8),
            child: ListTile(
              title: KPDependentGraph(
                mode: VisualizationModeExt.mode(StorageManager.readData(
                    StorageManager.kanListGraphVisualization) ?? VisualizationMode.radialChart),
                writing: updatedKanji.winRateWriting,
                reading: updatedKanji.winRateReading,
                recognition: updatedKanji.winRateRecognition,
                listening: updatedKanji.winRateListening,
              )
            ),
          ),
          _lastTimeShownWidget(context, updatedKanji),
          Visibility(
            visible: onTap != null && onRemove != null,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Divider(),
                _actionButtons(context),
              ],
            ),
          ),
        ]
    );
  }

  Widget _header(BuildContext context, Kanji updatedKanji) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Margins.margin4, horizontal: Margins.margin16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.menu_book_rounded),
            onPressed: () {
              Navigator.of(context).pushNamed(KanPracticePages.jishoPage,
                  arguments: JishoArguments(kanji: updatedKanji.kanji));
            },
          ),
          SizedBox(
            height: Margins.margin24,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(updatedKanji.pronunciation, textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1),
            ),
          ),
          TTSIconButton(kanji: updatedKanji.pronunciation)
        ],
      )
    );
  }

  Widget _lastTimeShownWidget(BuildContext context, Kanji updatedKanji) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Margins.margin8),
      child: ExpansionTile(
        iconColor: CustomColors.secondaryColor,
        textColor: CustomColors.secondaryColor,
        title: FittedBox(
          fit: BoxFit.contain,
          child: Text("${"created_label".tr()} "
            "${GeneralUtils.parseDateMilliseconds(context, updatedKanji.dateAdded)} • "
            "${"last_seen_label".tr()} "
            "${GeneralUtils.parseDateMilliseconds(context, updatedKanji.dateLastShown)}",
            textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyText2)
        ),
        children: [
          SizedBox(
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
      padding: const EdgeInsets.only(
        left: Margins.margin8, right: Margins.margin16, bottom: Margins.margin8
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(" • ${(mode.mode).capitalized}:",
              overflow: TextOverflow.ellipsis, textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.subtitle2),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(parsedDate, overflow: TextOverflow.ellipsis, textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.subtitle2),
              ),
            )
          )
        ],
      ),
    );
  }

  SizedBox _actionButtons(BuildContext bloc) {
    return SizedBox(
      height: CustomSizes.actionButtonsKanjiDetail,
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              title: Text("kanji_bottom_sheet_removal_label".tr()),
              trailing: const Icon(Icons.clear),
              onTap: () {
                showDialog(
                  context: bloc,
                  builder: (context) => KPDialog(
                    title: Text("kanji_bottom_sheet_removeKanji_title".tr()),
                    content: Text("kanji_bottom_sheet_removeKanji_content".tr()),
                    positiveButtonText: "kanji_bottom_sheet_removeKanji_positive".tr(),
                    onPositive: () {
                      Navigator.of(context).pop();
                      bloc.read<KanjiBSBloc>().add(KanjiBSEventDelete(kanji));
                      if (onRemove != null) onRemove!();
                    }
                  )
                );
              },
            ),
          ),
          const RotatedBox(quarterTurns: 1, child: Divider()),
          Expanded(
            child: ListTile(
              title: Text("kanji_bottom_sheet_update_label".tr()),
              trailing: const Icon(Icons.arrow_forward_rounded),
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