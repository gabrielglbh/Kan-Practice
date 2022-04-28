import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/core/firebase/models/market_list.dart';
import 'package:kanpractice/core/utils/general_utils.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/kp_button.dart';

class MarketListTile extends StatelessWidget {
  final MarketList list;
  final Function(String) onDownload;
  final Function() onRating;
  const MarketListTile({
    Key? key,
    required this.list,
    required this.onDownload,
    required this.onRating
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: Margins.margin8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(list.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: FontSizes.fontSize24, fontWeight: FontWeight.bold)),
                    if (list.author.isNotEmpty) Text("${"market_by_author".tr()}: ${list.author}",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: FontSizes.fontSize18)),
                  ],
                )
              ),
              Text("${"created_label".tr()} ${GeneralUtils.parseDateMilliseconds(context, list.uploadedToMarket)}",
                  style: const TextStyle(fontSize: FontSizes.fontSize12))
            ],
          ),
        ),
        subtitle: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: Margins.margin8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(list.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        style: const TextStyle(fontSize: FontSizes.fontSize14)
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: Margins.margin8),
                      child: Text("${"market_filter_words".tr()}: ${list.words}",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: FontSizes.fontSize14)
                      ),
                    ),
                    Text("${"market_filter_downloads".tr()}: ${list.downloads}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: FontSizes.fontSize14)
                    ),
                    // TODO: Rating
                  ],
                ),
              ),
            ),
            KPButton(
              title2: "market_downloads_button_label".tr(),
              color: CustomColors.secondaryDarkerColor,
              onTap: () {
                onDownload(list.name);
              }
            )
          ],
        )
      ),
    );
  }
}
