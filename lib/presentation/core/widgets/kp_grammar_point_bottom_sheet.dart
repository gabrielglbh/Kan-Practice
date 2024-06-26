import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/grammar_point_details/grammar_point_details_bloc.dart';
import 'package:kanpractice/application/snackbar/snackbar_bloc.dart';
import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/types/grammar_modes.dart';
import 'package:kanpractice/presentation/core/types/home_types.dart';
import 'package:kanpractice/presentation/core/widgets/graphs/kp_grammar_mode_radial_graph.dart';
import 'package:kanpractice/presentation/core/widgets/graphs/kp_radial_graph_legend.dart';
import 'package:kanpractice/presentation/core/widgets/kp_alert_dialog.dart';
import 'package:kanpractice/presentation/core/widgets/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/widgets/kp_markdown.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:easy_localization/easy_localization.dart';

class KPGrammarPointBottomSheet extends StatelessWidget {
  final String? listName;
  final GrammarPoint? grammarPoint;
  final Function()? onRemove;
  final Function()? onTap;
  const KPGrammarPointBottomSheet(
      {super.key,
      required this.listName,
      required this.grammarPoint,
      this.onTap,
      this.onRemove});

  /// Creates and calls the [BottomSheet] with the content for displaying the data
  /// of the current selected grammar point
  static Future<String?> show(
      BuildContext context, String? listName, GrammarPoint? grammarPoint,
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
        return BlocProvider(
          create: (context) => getIt<GrammarPointDetailsBloc>()
            ..add(GrammarPointDetailsEventLoading(
              grammarPoint ?? GrammarPoint.empty,
              isArchive: listName == null,
            )),
          child: Wrap(children: [
            Padding(
                padding: const EdgeInsets.all(KPMargins.margin8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const KPDragContainer(),
                    const SizedBox(height: KPMargins.margin4),
                    BlocConsumer<GrammarPointDetailsBloc,
                        GrammarPointDetailsState>(
                      listener: (context, state) {
                        state.mapOrNull(error: (error) {
                          context
                              .read<SnackbarBloc>()
                              .add(SnackbarEventShow(error.message));
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
                          loaded: (grammarPoint) =>
                              _body(context, grammarPoint),
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

  Widget _body(BuildContext context, GrammarPoint grammarPoint) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          KPMarkdown(
            data: grammarPoint.name,
            maxHeight: KPMargins.margin64,
            shrinkWrap: true,
          ),
          KPMarkdown(
            data: "${grammarPoint.definition}\n\n"
                "_${"add_grammar_textForm_example".tr()}_\n\n"
                "${grammarPoint.example}",
            maxHeight: MediaQuery.of(context).size.height / 4,
            shrinkWrap: true,
          ),
          if (listName == null)
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: KPMargins.margin16,
                  right: KPMargins.margin16,
                  top: KPMargins.margin16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      HomeType.kanlist.icon,
                      size: 16,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: KPMargins.margin8),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(grammarPoint.listName,
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
            ),
          const Divider(),
          SizedBox(
            height: 112,
            child: KPGrammarModeRadialGraph(
              definition: grammarPoint.winRateDefinition,
              grammarPoints: grammarPoint.winRateGrammarPoint,
            ),
          ),
          const Divider(),
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
        child: ListTileTheme(
          dense: true,
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
                iconColor: Theme.of(context).colorScheme.primary,
                textColor: Theme.of(context).colorScheme.primary,
                tilePadding: const EdgeInsets.all(0),
                title: Text(
                    "${"created_label".tr()} "
                    "${grammarPoint.dateAdded.parseDateMilliseconds()} • "
                    "${"last_seen_label".tr()} "
                    "${grammarPoint.dateLastShown.parseDateMilliseconds()}",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium),
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: GrammarModes.values.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                        horizontal: KPMargins.margin12),
                    itemBuilder: (context, index) {
                      int date = 0;
                      switch (GrammarModes.values[index]) {
                        case GrammarModes.definition:
                          date = grammarPoint.dateLastShownDefinition;
                          break;
                        case GrammarModes.grammarPoints:
                          date = grammarPoint.dateLastShownGrammarPoint;
                          break;
                      }

                      return KPRadialGraphLegend(
                        rate: date != 0
                            ? "${"last_seen_label".tr()} ${date.parseDateMilliseconds()}"
                            : "-",
                        color: GrammarModes.values[index].color,
                        text: GrammarModes.values[index].mode,
                      );
                    },
                  ),
                  const SizedBox(height: KPMargins.margin8),
                ]),
          ),
        ));
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
                      title:
                          Text("grammar_bottom_sheet_removeGrammar_title".tr()),
                      content: Text(
                          "grammar_bottom_sheet_removeGrammar_content".tr()),
                      positiveButtonText:
                          "grammar_bottom_sheet_removeGrammar_positive".tr(),
                      onPositive: () {
                        Navigator.of(context).pop();
                        bloc
                            .read<GrammarPointDetailsBloc>()
                            .add(GrammarPointDetailsEventDelete(grammarPoint));
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
