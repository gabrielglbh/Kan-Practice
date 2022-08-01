import 'package:flutter/material.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:kanpractice/ui/pages/home/widgets/test_widgets/kanlist_category_selection_bottom_sheet.dart';
import 'package:kanpractice/ui/pages/home/widgets/test_widgets/kanlist_selection_bottom_sheet.dart';
import 'package:kanpractice/ui/widgets/blitz/kp_blitz_bottom_sheet.dart';
import 'package:kanpractice/ui/widgets/kp_drag_container.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/widgets/kp_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/ui/widgets/blitz/kp_number_test_bottom_sheet.dart';

class TestBottomSheet extends StatefulWidget {
  const TestBottomSheet({Key? key}) : super(key: key);

  @override
  State<TestBottomSheet> createState() => _TestBottomSheetState();

  /// Creates and calls the [BottomSheet] with the content for a regular test
  static Future<String?> show(BuildContext context) async {
    return await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const TestBottomSheet());
  }
}

class _TestBottomSheetState extends State<TestBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 1.2),
      builder: (context) {
        return Wrap(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const KPDragContainer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Margins.margin8, horizontal: Margins.margin32),
                child: Text("test_selection_label".tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: Margins.margin16),
                child: GridView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 1.9),
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
                        case Tests.categories:
                          return _testBasedButtons(context, Tests.categories);
                        case Tests.folder:
                          return _testBasedButtons(context, Tests.folder);
                      }
                    })),
              ),
              Container(height: Margins.margin16)
            ],
          ),
        ]);
      },
    );
  }

  Widget _testBasedButtons(BuildContext context, Tests mode) {
    return KPButton(
        icon: mode.icon,
        title2: mode.name,
        onTap: () async {
          switch (mode) {
            case Tests.lists:
              await KanListSelectionBottomSheet.show(context);
              break;
            case Tests.blitz:
              await KPBlitzBottomSheet.show(context);
              break;
            case Tests.time:
              await KPBlitzBottomSheet.show(context, remembranceTest: true);
              break;
            case Tests.numbers:
              await KPNumberTestBottomSheet.show(context);
              break;
            case Tests.less:
              await KPBlitzBottomSheet.show(context, lessPctTest: true);
              break;
            case Tests.categories:
              KanListCategorySelectionBottomSheet.show(context);
              break;
            case Tests.folder:
              // TODO: New bottom sheet for selecting the folders
              break;
          }
        });
  }
}
