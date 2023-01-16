import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/core/widgets/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/widgets/modes_grid/kp_modes_grid.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';

class DailyBottomSheet extends StatelessWidget {
  const DailyBottomSheet({Key? key}) : super(key: key);

  /// Creates and calls the [BottomSheet] with the content for a regular test
  static Future<String?> show(BuildContext context) async {
    return await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const DailyBottomSheet());
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
        return Wrap(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const KPDragContainer(),
              Row(
                children: [
                  const SizedBox(width: KPMargins.margin48),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: KPMargins.margin8,
                          horizontal: KPMargins.margin32),
                      child: Text("daily_test_bottom_sheet_title".tr(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.info_outline_rounded),
                    onPressed: () {
                      Utils.launch(
                          context, 'https://en.wikipedia.org/wiki/SuperMemo');
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: KPMargins.margin8,
                    horizontal: KPMargins.margin32),
                child: Text("daily_test_description".tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1),
              ),
              KPModesGrid(
                type: Tests.daily,
                testName: Tests.daily.name,
              )
            ],
          ),
        ]);
      },
    );
  }
}
