import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/auth/auth_bloc.dart';
import 'package:kanpractice/domain/market/market.dart';
import 'package:kanpractice/presentation/core/widgets/kp_alert_dialog.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/core/widgets/kp_language_flag.dart';
import 'package:kanpractice/presentation/market_page/widgets/market_list_rating.dart';

class MarketListTile extends StatelessWidget {
  final Market list;
  final Function(String, bool) onDownload;
  final Function(String, bool) onRemove;
  final bool isManaging;
  const MarketListTile(
      {super.key,
      required this.list,
      required this.onDownload,
      required this.onRemove,
      this.isManaging = false});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: KPMargins.margin8),
          child: _header(context),
        ),
        subtitle: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: KPMargins.margin8),
                child: _subtitle(context),
              ),
            ),
          ],
        ));
  }

  Widget _header(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(list.name,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineSmall),
            ),
            Padding(
              padding: const EdgeInsets.only(left: KPMargins.margin8),
              child: Text(
                  "${"created_label".tr()} ${Utils.parseDateMilliseconds(list.uploadedToMarket)}",
                  style: Theme.of(context).textTheme.titleSmall),
            ),
          ],
        ),
        Row(
          children: [
            if (list.author.isNotEmpty)
              Expanded(
                child: Text("${"market_by_author".tr()} ${list.author}",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w500)),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(list.rating.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w500)),
                Padding(
                    padding: const EdgeInsets.only(left: KPMargins.margin4),
                    child: Icon(Icons.star_rounded,
                        color: Theme.of(context).colorScheme.primary)),
              ],
            )
          ],
        )
      ],
    );
  }

  Widget _subtitle(BuildContext context) {
    context.read<AuthBloc>().add(AuthIdle());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(list.description, overflow: TextOverflow.ellipsis, maxLines: 5),
        Padding(
          padding: const EdgeInsets.only(top: KPMargins.margin8),
          child: Row(
            children: [
              Icon(
                Icons.g_translate_rounded,
                color: Colors.amber.shade800,
                size: 18,
              ),
              const SizedBox(width: KPMargins.margin8),
              Expanded(
                child: Text("market_automatic_translation".tr(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontStyle: FontStyle.italic)),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: KPMargins.margin8),
          child: Row(
            children: [
              Text("${"market_filter_words".tr()}: ${list.words}",
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium),
              if (list.isFolder)
                Padding(
                  padding: const EdgeInsets.only(left: KPMargins.margin8),
                  child: Icon(
                    Icons.folder_rounded,
                    color: KPColors.midGrey,
                    size: 18,
                  ),
                ),
            ],
          ),
        ),
        Text("${"market_filter_grammar".tr()}: ${list.grammar}",
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium),
        Text("${"market_filter_downloads".tr()}: ${list.downloads}",
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium),
        Row(
          children: [
            Text("${"market_list_language".tr()}:",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(width: KPMargins.margin8),
            KPLanguageFlag(language: list.language, height: KPMargins.margin16),
          ],
        ),
        Row(
          children: [
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loaded: (user) {
                    return Expanded(
                      child: Transform.translate(
                          offset: const Offset(-KPMargins.margin4, 0),
                          child: MarketListRating(
                            listId: list.name,
                            initialRating: list.ratingMap[user.uid],
                          )),
                    );
                  },
                  orElse: () => const Expanded(child: SizedBox()),
                );
              },
            ),
            IconButton(
                onPressed: () => onDownload(list.name, list.isFolder),
                splashRadius: KPRadius.radius24,
                icon: const Icon(Icons.download_rounded)),
            if (isManaging)
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return KPDialog(
                              title: Text("market_remove_dialog_label".tr()),
                              content: Text("market_remove_sure_label".tr()),
                              positiveButtonText: "Ok",
                              onPositive: () =>
                                  onRemove(list.name, list.isFolder));
                        });
                  },
                  splashRadius: KPRadius.radius24,
                  icon: const Icon(Icons.highlight_remove)),
          ],
        ),
      ],
    );
  }
}
