import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/word_details/word_details_bloc.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/presentation/core/ui/graphs/kp_radial_graph.dart';
import 'package:kanpractice/presentation/core/ui/kp_alert_dialog.dart';
import 'package:kanpractice/presentation/core/ui/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/ui/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/ui/kp_tts_icon_button.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/dictionary_details_page/arguments.dart';
import 'package:kanpractice/core/types/word_categories.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:easy_localization/easy_localization.dart';

class KPKanjiBottomSheet extends StatelessWidget {
  /// Kanji object to be displayed
  final String listName;
  final Word? kanji;
  final Function()? onRemove;
  final Function()? onTap;
  const KPKanjiBottomSheet(
      {Key? key,
      required this.listName,
      required this.kanji,
      this.onTap,
      this.onRemove})
      : super(key: key);

  /// Creates and calls the [BottomSheet] with the content for displaying the data
  /// of the current selected kanji
  static Future<String?> show(
      BuildContext context, String listName, Word? kanji,
      {Function()? onRemove, Function()? onTap}) async {
    return await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => KPKanjiBottomSheet(
            listName: listName,
            kanji: kanji,
            onTap: onTap,
            onRemove: onRemove));
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height - KPMargins.margin64;
    return BottomSheet(
      enableDrag: false,
      constraints: BoxConstraints(maxHeight: maxHeight),
      onClosing: () {},
      builder: (context) {
        return Wrap(children: [
          Padding(
              padding: const EdgeInsets.all(KPMargins.margin8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const KPDragContainer(),
                  BlocProvider<WordDetailsBloc>(
                    create: (_) => WordDetailsBloc()
                      ..add(WordDetailsEventLoading(kanji ?? Word.empty)),
                    child: BlocConsumer<WordDetailsBloc, WordDetailsState>(
                      listener: (context, state) {
                        if (state is WordDetailsStateFailure) {
                          Utils.getSnackBar(context, state.error);
                        }
                        if (state is WordDetailsStateRemoved) {
                          if (onRemove != null) onRemove!();
                        }
                      },
                      builder: (context, state) {
                        if (state is WordDetailsStateLoading) {
                          return Center(
                              child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  child: const KPProgressIndicator()));
                        } else if (state is WordDetailsStateFailure) {
                          return Container(
                              height: MediaQuery.of(context).size.height / 2,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: KPMargins.margin16),
                              child: Text(state.error));
                        } else if (state is WordDetailsStateLoaded) {
                          return _body(context, state.kanji);
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ],
              )),
        ]);
      },
    );
  }

  Widget _body(BuildContext context, Word updatedKanji) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _header(context, updatedKanji),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: KPMargins.margin16),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(updatedKanji.word,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: KPMargins.margin4,
                  bottom: KPMargins.margin4,
                  right: KPMargins.margin16,
                  left: KPMargins.margin16),
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                      text:
                          "(${WordCategory.values[updatedKanji.category].category}) ",
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: Colors.grey.shade500,
                          fontStyle: FontStyle.italic),
                    ),
                    TextSpan(
                        text: updatedKanji.meaning,
                        style: Theme.of(context).textTheme.bodyText2)
                  ])),
            ),
          ),
          const Divider(),
          KPRadialGraph(
            writing: updatedKanji.winRateWriting,
            reading: updatedKanji.winRateReading,
            recognition: updatedKanji.winRateRecognition,
            listening: updatedKanji.winRateListening,
            speaking: updatedKanji.winRateSpeaking,
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
        ]);
  }

  Widget _header(BuildContext context, Word updatedKanji) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: KPMargins.margin16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.menu_book_rounded),
              onPressed: () {
                Navigator.of(context).pushNamed(KanPracticePages.jishoPage,
                    arguments:
                        DictionaryDetailsArguments(kanji: updatedKanji.word));
              },
            ),
            SizedBox(
              height: KPMargins.margin24,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(updatedKanji.pronunciation,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1),
              ),
            ),
            TTSIconButton(kanji: updatedKanji.pronunciation)
          ],
        ));
  }

  Widget _lastTimeShownWidget(BuildContext context, Word updatedKanji) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: KPMargins.margin16),
        child: ExpansionTile(
            iconColor: KPColors.secondaryColor,
            textColor: KPColors.secondaryColor,
            tilePadding: const EdgeInsets.all(0),
            title: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                    "${"created_label".tr()} "
                    "${Utils.parseDateMilliseconds(context, updatedKanji.dateAdded)} • "
                    "${"last_seen_label".tr()} "
                    "${Utils.parseDateMilliseconds(context, updatedKanji.dateLastShown)}",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2)),
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: StudyModes.values.length,
                itemBuilder: (context, index) {
                  return _lastSeenOnModes(
                      context, updatedKanji, StudyModes.values[index]);
                },
              )
            ]));
  }

  Widget _lastSeenOnModes(
      BuildContext context, Word updatedKanji, StudyModes mode) {
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
      case StudyModes.speaking:
        date = updatedKanji.dateLastShownSpeaking;
        break;
    }
    if (date != 0) {
      parsedDate =
          "${"last_seen_label".tr()} ${Utils.parseDateMilliseconds(context, date)}";
    }

    return Container(
      height: KPMargins.margin24,
      padding: const EdgeInsets.only(
          left: KPMargins.margin8,
          right: KPMargins.margin16,
          bottom: KPMargins.margin8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(" • ${(mode.mode).capitalized}:",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.subtitle2),
          ),
          Expanded(
              child: Container(
            alignment: Alignment.centerRight,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(parsedDate,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.subtitle2),
            ),
          ))
        ],
      ),
    );
  }

  Widget _actionButtons(BuildContext bloc) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ListTile(
            title: Text("kanji_bottom_sheet_removal_label".tr()),
            trailing: const Icon(Icons.clear),
            visualDensity: const VisualDensity(vertical: -3),
            onTap: () {
              showDialog(
                  context: bloc,
                  builder: (context) => KPDialog(
                      title: Text("kanji_bottom_sheet_removeKanji_title".tr()),
                      content:
                          Text("kanji_bottom_sheet_removeKanji_content".tr()),
                      positiveButtonText:
                          "kanji_bottom_sheet_removeKanji_positive".tr(),
                      onPositive: () {
                        Navigator.of(context).pop();
                        bloc
                            .read<WordDetailsBloc>()
                            .add(WordDetailsEventDelete(kanji));
                        if (onRemove != null) onRemove!();
                      }));
            },
          ),
        ),
        const RotatedBox(quarterTurns: 1, child: Divider()),
        Expanded(
          child: ListTile(
            title: Text("kanji_bottom_sheet_update_label".tr()),
            trailing: const Icon(Icons.arrow_forward_rounded),
            visualDensity: const VisualDensity(vertical: -3),
            onTap: () {
              Navigator.of(bloc).pop();
              if (onTap != null) onTap!();
            },
          ),
        )
      ],
    );
  }
}
