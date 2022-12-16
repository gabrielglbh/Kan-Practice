import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/grammar_details/grammar_details_bloc.dart';
import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/types/grammar_modes.dart';
import 'package:kanpractice/presentation/core/ui/graphs/kp_grammar_mode_radial_graph.dart';
import 'package:kanpractice/presentation/core/ui/kp_alert_dialog.dart';
import 'package:kanpractice/presentation/core/ui/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/ui/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:easy_localization/easy_localization.dart';

class KPGrammarPointBottomSheet extends StatelessWidget {
  final String listName;
  final GrammarPoint? grammarPoint;
  final Function()? onRemove;
  final Function()? onTap;
  const KPGrammarPointBottomSheet(
      {Key? key,
      required this.listName,
      required this.grammarPoint,
      this.onTap,
      this.onRemove})
      : super(key: key);

  /// Creates and calls the [BottomSheet] with the content for displaying the data
  /// of the current selected grammar point
  static Future<String?> show(
      BuildContext context, String listName, GrammarPoint? grammarPoint,
      {Function()? onRemove, Function()? onTap}) async {
    return await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => KPGrammarPointBottomSheet(
            listName: listName,
            grammarPoint: grammarPoint,
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
        getIt<GrammarPointDetailsBloc>().add(GrammarPointDetailsEventLoading(
            grammarPoint ?? GrammarPoint.empty));
        return Wrap(children: [
          Padding(
              padding: const EdgeInsets.all(KPMargins.margin8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const KPDragContainer(),
                  BlocConsumer<GrammarPointDetailsBloc,
                      GrammarPointDetailsState>(
                    listener: (context, state) {
                      if (state is GrammarPointDetailsStateFailure) {
                        Utils.getSnackBar(context, state.error);
                      }
                      if (state is GrammarPointDetailsStateRemoved) {
                        if (onRemove != null) onRemove!();
                      }
                    },
                    builder: (context, state) {
                      if (state is GrammarPointDetailsStateLoading) {
                        return Center(
                            child: SizedBox(
                                height: MediaQuery.of(context).size.height / 2,
                                child: const KPProgressIndicator()));
                      } else if (state is GrammarPointDetailsStateFailure) {
                        return Container(
                            height: MediaQuery.of(context).size.height / 2,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(
                                horizontal: KPMargins.margin16),
                            child: Text(state.error));
                      } else if (state is GrammarPointDetailsStateLoaded) {
                        return _body(context, state.grammarPoint);
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              )),
        ]);
      },
    );
  }

  Widget _body(BuildContext context, GrammarPoint grammarPoint) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: KPMargins.margin16),
            child: Text(
              grammarPoint.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: KPMargins.margin16),
            child: Text(
              grammarPoint.definition,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          const Divider(),
          KPGrammarModeRadialGraph(
            definition: grammarPoint.winRateDefinition,
            recognition: grammarPoint.winRateRecognition,
          ),
          _lastTimeShownWidget(context, grammarPoint),
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

  Widget _lastTimeShownWidget(BuildContext context, GrammarPoint grammarPoint) {
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
                    "${Utils.parseDateMilliseconds(context, grammarPoint.dateAdded)} • "
                    "${"last_seen_label".tr()} "
                    "${Utils.parseDateMilliseconds(context, grammarPoint.dateLastShown)}",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2)),
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: GrammarModes.values.length,
                itemBuilder: (context, index) {
                  return _lastSeenOnModes(
                      context, grammarPoint, GrammarModes.values[index]);
                },
              )
            ]));
  }

  Widget _lastSeenOnModes(
      BuildContext context, GrammarPoint grammarPoint, GrammarModes mode) {
    int? date = 0;
    String parsedDate = "-";
    switch (mode) {
      case GrammarModes.definition:
        date = grammarPoint.dateLastShownDefinition;
        break;
      case GrammarModes.recognition:
        date = grammarPoint.dateLastShownRecognition;
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
                      title:
                          Text("grammar_bottom_sheet_removeGrammar_title".tr()),
                      content: Text(
                          "grammar_bottom_sheet_removeGrammar_content".tr()),
                      positiveButtonText:
                          "grammar_bottom_sheet_removeGrammar_positive".tr(),
                      onPositive: () {
                        Navigator.of(context).pop();
                        getIt<GrammarPointDetailsBloc>()
                            .add(GrammarPointDetailsEventDelete(grammarPoint));
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
