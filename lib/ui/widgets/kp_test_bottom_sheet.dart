import 'package:flutter/material.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:kanpractice/ui/pages/home/widgets/test_widgets/folder_selection_bottom_sheet.dart';
import 'package:kanpractice/ui/widgets/kp_kanlist_category_selection_bottom_sheet.dart';
import 'package:kanpractice/ui/pages/home/widgets/test_widgets/kanlist_selection_bottom_sheet.dart';
import 'package:kanpractice/ui/widgets/blitz/kp_blitz_bottom_sheet.dart';
import 'package:kanpractice/ui/widgets/kp_drag_container.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/widgets/kp_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/ui/widgets/blitz/kp_number_test_bottom_sheet.dart';

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
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.folder != null ? 2 : 3,
                      childAspectRatio: widget.folder != null ? 1.9 : 1.3,
                    ),
                    children: widget.folder != null
                        ? [
                            _testBasedButtons(context, Tests.blitz),
                            _testBasedButtons(context, Tests.time),
                            _testBasedButtons(context, Tests.less),
                            _testBasedButtons(context, Tests.categories)
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
        title2: mode.nameAbbr,
        onTap: () async {
          switch (mode) {
            case Tests.lists:
              await KanListSelectionBottomSheet.show(context);
              break;
            case Tests.blitz:
              if (widget.folder != null) {
                await KPBlitzBottomSheet.show(
                  context,
                  folderList: widget.folder,
                );
              } else {
                await KPBlitzBottomSheet.show(context);
              }
              break;
            case Tests.time:
              if (widget.folder != null) {
                await KPBlitzBottomSheet.show(
                  context,
                  folderList: widget.folder,
                  remembranceTest: true,
                );
              } else {
                await KPBlitzBottomSheet.show(context, remembranceTest: true);
              }
              break;
            case Tests.numbers:
              await KPNumberTestBottomSheet.show(context);
              break;
            case Tests.less:
              if (widget.folder != null) {
                await KPBlitzBottomSheet.show(
                  context,
                  folderList: widget.folder,
                  lessPctTest: true,
                );
              } else {
                await KPBlitzBottomSheet.show(context, lessPctTest: true);
              }
              break;
            case Tests.categories:
              // TODO: Accept folder
              await KPKanListCategorySelectionBottomSheet.show(context);
              break;
            case Tests.folder:
              await FolderSelectionBottomSheet.show(context);
              break;
          }
        });
  }
}
