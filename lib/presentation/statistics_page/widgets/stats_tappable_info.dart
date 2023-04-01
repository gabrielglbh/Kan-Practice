import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class TappableInfo extends StatelessWidget {
  const TappableInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: KPMargins.margin16,
        right: KPMargins.margin16,
        bottom: KPMargins.margin8,
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: KPMargins.margin8),
            child: Icon(Icons.info_rounded, size: 16, color: Colors.grey),
          ),
          Flexible(
            child: Text(
              "stats_tests_tap_to_specs".tr(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
