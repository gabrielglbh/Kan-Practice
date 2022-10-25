import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/auth/auth_bloc.dart';
import 'package:kanpractice/domain/market/market.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/ui/kp_alert_dialog.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/market_page/widgets/market_list_rating.dart';

class MarketListTile extends StatelessWidget {
  final Market list;
  final Function(String, bool) onDownload;
  final Function(String, bool) onRemove;
  final bool isManaging;
  const MarketListTile(
      {Key? key,
      required this.list,
      required this.onDownload,
      required this.onRemove,
      this.isManaging = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
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
          )),
    );
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
                  style: Theme.of(context).textTheme.headline5),
            ),
            Padding(
              padding: const EdgeInsets.only(left: KPMargins.margin8),
              child: Text(
                  "${"created_label".tr()} ${Utils.parseDateMilliseconds(context, list.uploadedToMarket)}",
                  style: Theme.of(context).textTheme.subtitle2),
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
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.w500)),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(list.rating.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.w500)),
                const Padding(
                    padding: EdgeInsets.only(left: KPMargins.margin4),
                    child: Icon(Icons.star_rounded,
                        color: KPColors.secondaryColor)),
              ],
            )
          ],
        )
      ],
    );
  }

  Widget _subtitle(BuildContext context) {
    getIt<AuthBloc>().add(AuthIdle());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(list.description, overflow: TextOverflow.ellipsis, maxLines: 5),
        Padding(
          padding: const EdgeInsets.only(top: KPMargins.margin8),
          child: Row(
            children: [
              Text("${"market_filter_words".tr()}: ${list.words}",
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2),
              if (list.isFolder)
                Padding(
                  padding: const EdgeInsets.only(left: KPMargins.margin8),
                  child: Icon(
                    Icons.folder_rounded,
                    color: Colors.grey.shade500,
                    size: 18,
                  ),
                ),
            ],
          ),
        ),
        Text("${"market_filter_downloads".tr()}: ${list.downloads}",
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText2),
        Row(
          children: [
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthStateSuccessful) {
                  return Expanded(
                    child: Transform.translate(
                        offset: const Offset(-KPMargins.margin4, 0),
                        child: MarketListRating(
                          listId: list.name,
                          initialRating: list.ratingMap[state.user.uid],
                        )),
                  );
                }
                return const Expanded(child: SizedBox());
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
