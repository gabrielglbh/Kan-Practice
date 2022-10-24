import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/core/ui/blitz/kp_blitz_bottom_sheet.dart';
import 'package:kanpractice/presentation/core/ui/blitz/kp_number_test_bottom_sheet.dart';
import 'package:kanpractice/presentation/core/ui/kp_button.dart';
import 'package:kanpractice/presentation/core/ui/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/ui/kp_kanlist_category_selection_bottom_sheet.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/home_page/widgets/daily_test_bottom_sheet.dart';
import 'package:kanpractice/presentation/home_page/widgets/folder_selection_bottom_sheet.dart';
import 'package:kanpractice/presentation/home_page/widgets/kanlist_selection_bottom_sheet.dart';

class KPTestBottomSheet extends StatefulWidget {
  final String? folder;
  const KPTestBottomSheet({Key? key, this.folder}) : super(key: key);

  @override
  State<KPTestBottomSheet> createState() => _KPTestBottomSheetState();

  /// Creates and calls the [BottomSheet] with the content for a regular test
  static Future<String?> show(BuildContext context, {String? folder}) async {
    return await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => KPTestBottomSheet(folder: folder));
  }
}

class _KPTestBottomSheetState extends State<KPTestBottomSheet> {
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
                    vertical: KPMargins.margin8,
                    horizontal: KPMargins.margin32),
                child: Text("test_selection_label".tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: KPMargins.margin16),
                child: GridView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.3,
                    ),
                    children: widget.folder != null
                        ? [
                            _testBasedButtons(context, Tests.blitz),
                            _testBasedButtons(context, Tests.time),
                            _testBasedButtons(context, Tests.less),
                            _testBasedButtons(context, Tests.categories),
                            _testBasedButtons(context, Tests.daily)
                          ]
                        : List.generate(Tests.values.length, (index) {
                            switch (Tests.values[index]) {
                              case Tests.lists:
                                return _testBasedButtons(context, Tests.lists);
                              case Tests.blitz:
                                return _testBasedButtons(context, Tests.blitz);
                              case Tests.time:
                                return _testBasedButtons(context, Tests.time);
                              case Tests.numbers:
                                return _testBasedButtons(
                                    context, Tests.numbers);
                              case Tests.less:
                                return _testBasedButtons(context, Tests.less);
                              case Tests.categories:
                                return _testBasedButtons(
                                    context, Tests.categories);
                              case Tests.folder:
                                return _testBasedButtons(context, Tests.folder);
                              case Tests.daily:
                                return _testBasedButtons(context, Tests.daily);
                            }
                          })),
              ),
              Container(height: KPMargins.margin16)
            ],
          ),
        ]);
      },
    );
  }

  Widget _testBasedButtons(BuildContext context, Tests mode) {
    return KPButton(
        icon: mode.icon,
        title2: mode.nameAbbr,
        onTap: () async {
          switch (mode) {
            case Tests.lists:
              await KanListSelectionBottomSheet.show(context);
              break;
            case Tests.blitz:
              await KPBlitzBottomSheet.show(
                context,
                folder: widget.folder,
              );
              break;
            case Tests.time:
              await KPBlitzBottomSheet.show(
                context,
                folder: widget.folder,
                remembranceTest: true,
              );
              break;
            case Tests.numbers:
              await KPNumberTestBottomSheet.show(context);
              break;
            case Tests.less:
              await KPBlitzBottomSheet.show(
                context,
                folder: widget.folder,
                lessPctTest: true,
              );
              break;
            case Tests.categories:
              await KPKanListCategorySelectionBottomSheet.show(
                context,
                folder: widget.folder,
              );
              break;
            case Tests.folder:
              await FolderSelectionBottomSheet.show(context);
              break;
            case Tests.daily:
              await DailyBottomSheet.show(context, folder: widget.folder);
              break;
          }
        });
  }
}