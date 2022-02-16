import 'package:flutter/material.dart';
import 'package:kanpractice/ui/pages/kanji_lists/widgets/KanListSelectionBottomSheet.dart';
import 'package:kanpractice/ui/widgets/blitz/BlitzBottomSheet.dart';
import 'package:kanpractice/ui/widgets/DragContainer.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/CustomButton.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/ui/widgets/blitz/NumberTestBottomSheet.dart';

enum Tests {
  lists, blitz, time, numbers, less
}

extension TestsExt on Tests {
  String get name {
    switch (this) {
      case Tests.lists:
        return "test_mode_selection".tr();
      case Tests.blitz:
        return "test_mode_blitz".tr();
      case Tests.time:
        return "test_mode_remembrance".tr();
      case Tests.numbers:
        return "test_mode_number".tr();
      case Tests.less:
        return "test_mode_less".tr();
    }
  }

  IconData get icon {
    switch (this) {
      case Tests.lists:
        return Icons.select_all_rounded;
      case Tests.blitz:
        return Icons.flash_on_rounded;
      case Tests.time:
        return Icons.access_time_rounded;
      case Tests.numbers:
        return Icons.pin_rounded;
      case Tests.less:
        return Icons.indeterminate_check_box_outlined;
    }
  }
}

class TestBottomSheet extends StatefulWidget {
  const TestBottomSheet();

  @override
  _TestBottomSheetState createState() => _TestBottomSheetState();

  /// Creates and calls the [BottomSheet] with the content for a regular test
  static Future<String?> show(BuildContext context) async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TestBottomSheet()
    );
  }
}

class _TestBottomSheetState extends State<TestBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
        return Wrap(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DragContainer(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Margins.margin8, horizontal: Margins.margin32),
                  child: Text("test_selection_label".tr(), textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: FontSizes.fontSize18)),
                ),
                Container(
                  height: CustomSizes.defaultSizeStudyModeSelection * 1.6,
                  padding: EdgeInsets.symmetric(horizontal: Margins.margin32),
                  child: GridView(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 1.9
                    ),
                    children: List.generate(Tests.values.length, (index) {
                      switch (Tests.values[index]) {
                        case Tests.lists:
                          return _testBasedButtons(context, Tests.lists);
                        case Tests.blitz:
                          return _testBasedButtons(context, Tests.blitz);
                        case Tests.time:
                          return _testBasedButtons(context, Tests.time);
                        case Tests.numbers:
                          return _testBasedButtons(context, Tests.numbers);
                        case Tests.less:
                          return _testBasedButtons(context, Tests.less);
                      }
                    })
                  ),
                ),
                Container(height: Margins.margin16)
              ],
            ),
          ]
        );
      },
    );
  }

  Widget _testBasedButtons(BuildContext context, Tests mode) {
    return CustomButton(
      icon: mode.icon,
      title2: mode.name,
      onTap: () async {
        switch (mode) {
          case Tests.lists:
            await KanListSelectionBottomSheet.show(context);
            break;
          case Tests.blitz:
            await BlitzBottomSheet.show(context);
            break;
          case Tests.time:
            await BlitzBottomSheet.show(context, remembranceTest: true);
            break;
          case Tests.numbers:
            await NumberTestBottomSheet.show(context);
            break;
          case Tests.less:
            await BlitzBottomSheet.show(context, lessPctTest: true);
            break;
        }
      }
    );
  }
}