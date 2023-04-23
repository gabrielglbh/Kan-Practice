import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/word_details/word_details_bloc.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/presentation/core/types/home_types.dart';
import 'package:kanpractice/presentation/core/widgets/graphs/kp_study_mode_radial_graph.dart';
import 'package:kanpractice/presentation/core/widgets/kp_alert_dialog.dart';
import 'package:kanpractice/presentation/core/widgets/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/widgets/kp_tts_icon_button.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/dictionary_details_page/arguments.dart';
import 'package:kanpractice/presentation/core/types/word_categories.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:easy_localization/easy_localization.dart';

class KPWordBottomSheet extends StatelessWidget {
  /// Word object to be displayed
  final String? listName;
  final Word? word;
  final Function()? onRemove;
  final Function()? onTap;
  const KPWordBottomSheet(
      {Key? key,
      required this.listName,
      required this.word,
      this.onTap,
      this.onRemove})
      : super(key: key);

  /// Creates and calls the [BottomSheet] with the content for displaying the data
  /// of the current selected word
  static Future<String?> show(
      BuildContext context, String? listName, Word? word,
      {Function()? onRemove, Function()? onTap}) async {
    return await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => KPWordBottomSheet(
            listName: listName, word: word, onTap: onTap, onRemove: onRemove));
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height - KPMargins.margin64;
    return BottomSheet(
      enableDrag: false,
      constraints: BoxConstraints(maxHeight: maxHeight),
      onClosing: () {},
      builder: (context) {
        return BlocProvider(
          create: (context) => getIt<WordDetailsBloc>()
            ..add(WordDetailsEventLoading(
              word ?? Word.empty,
              isArchive: listName == null,
            )),
          child: Wrap(children: [
            Padding(
                padding: const EdgeInsets.all(KPMargins.margin8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const KPDragContainer(),
                    BlocConsumer<WordDetailsBloc, WordDetailsState>(
                      listener: (context, state) {
                        state.mapOrNull(error: (error) {
                          Utils.getSnackBar(context, error.message);
                        }, removed: (_) {
                          if (onRemove != null) onRemove!();
                        });
                      },
                      builder: (context, state) {
                        return state.maybeWhen(
                          loading: () => Center(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height / 2,
                              child: const KPProgressIndicator(),
                            ),
                          ),
                          error: (error) => Container(
                            height: MediaQuery.of(context).size.height / 2,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(
                                horizontal: KPMargins.margin16),
                            child: Text(error),
                          ),
                          loaded: (word) => _body(context, word),
                          orElse: () => const SizedBox(),
                        );
                      },
                    ),
                  ],
                )),
          ]),
        );
      },
    );
  }

  Widget _body(BuildContext context, Word updatedWord) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _header(context, updatedWord),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: KPMargins.margin16),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(updatedWord.word,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
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
                          "(${WordCategory.values[updatedWord.category].category}) ",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: KPColors.midGrey, fontStyle: FontStyle.italic),
                    ),
                    TextSpan(
                        text: updatedWord.meaning,
                        style: Theme.of(context).textTheme.bodyMedium)
                  ])),
            ),
          ),
          if (listName == null)
            Padding(
              padding: const EdgeInsets.only(
                left: KPMargins.margin16,
                right: KPMargins.margin16,
                top: KPMargins.margin8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    HomeType.kanlist.icon,
                    size: 16,
                    color: KPColors.getSubtle(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: KPMargins.margin8),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(updatedWord.listName,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          const Divider(),
          KPStudyModeRadialGraph(
            writing: updatedWord.winRateWriting,
            reading: updatedWord.winRateReading,
            recognition: updatedWord.winRateRecognition,
            listening: updatedWord.winRateListening,
            speaking: updatedWord.winRateSpeaking,
          ),
          _lastTimeShownWidget(context, updatedWord),
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

  Widget _header(BuildContext context, Word updatedWord) {
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
                        DictionaryDetailsArguments(word: updatedWord.word));
              },
            ),
            SizedBox(
              height: KPMargins.margin24,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(updatedWord.pronunciation,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge),
              ),
            ),
            TTSIconButton(word: updatedWord.pronunciation)
          ],
        ));
  }

  Widget _lastTimeShownWidget(BuildContext context, Word updatedWord) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: KPMargins.margin16),
        child: ListTileTheme(
          dense: true,
          child: ExpansionTile(
              iconColor: KPColors.secondaryColor,
              textColor: KPColors.secondaryColor,
              tilePadding: const EdgeInsets.all(0),
              title: Text(
                  "${"created_label".tr()} "
                  "${Utils.parseDateMilliseconds(context, updatedWord.dateAdded)} • "
                  "${"last_seen_label".tr()} "
                  "${Utils.parseDateMilliseconds(context, updatedWord.dateLastShown)}",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium),
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: StudyModes.values.length,
                  itemBuilder: (context, index) {
                    return _lastSeenOnModes(
                        context, updatedWord, StudyModes.values[index]);
                  },
                )
              ]),
        ));
  }

  Widget _lastSeenOnModes(
      BuildContext context, Word updatedWord, StudyModes mode) {
    int? date = 0;
    String parsedDate = "-";
    switch (mode) {
      case StudyModes.writing:
        date = updatedWord.dateLastShownWriting;
        break;
      case StudyModes.reading:
        date = updatedWord.dateLastShownReading;
        break;
      case StudyModes.recognition:
        date = updatedWord.dateLastShownRecognition;
        break;
      case StudyModes.listening:
        date = updatedWord.dateLastShownListening;
        break;
      case StudyModes.speaking:
        date = updatedWord.dateLastShownSpeaking;
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
                style: Theme.of(context).textTheme.titleSmall),
          ),
          Expanded(
              child: Container(
            alignment: Alignment.centerRight,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(parsedDate,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.titleSmall),
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
            title: Text("word_bottom_sheet_removal_label".tr()),
            trailing: const Icon(Icons.clear),
            visualDensity: const VisualDensity(vertical: -3),
            onTap: () {
              showDialog(
                  context: bloc,
                  builder: (context) => KPDialog(
                      title: Text("word_bottom_sheet_removeWord_title".tr()),
                      content:
                          Text("word_bottom_sheet_removeWord_content".tr()),
                      positiveButtonText:
                          "word_bottom_sheet_removeWord_positive".tr(),
                      onPositive: () {
                        Navigator.of(context).pop();
                        bloc
                            .read<WordDetailsBloc>()
                            .add(WordDetailsEventDelete(word));
                        if (onRemove != null) onRemove!();
                      }));
            },
          ),
        ),
        const RotatedBox(quarterTurns: 1, child: Divider()),
        Expanded(
          child: ListTile(
            title: Text("word_bottom_sheet_update_label".tr()),
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
