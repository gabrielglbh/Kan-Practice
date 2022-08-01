import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/core/types/home_types.dart';
import 'package:kanpractice/ui/pages/home/widgets/test_widgets/test_bottom_sheet.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/widgets/kp_create_kanlist_dialog.dart';
import 'package:kanpractice/ui/widgets/kp_drag_container.dart';

class ActionsBottomSheet extends StatelessWidget {
  const ActionsBottomSheet({Key? key}) : super(key: key);

  /// Returns the name of the KanList being created to use the parents
  /// bloc to create it properly
  static Future<String?> show(BuildContext context, HomeType type) async {
    String? name;
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const ActionsBottomSheet()).then((value) {
      name = value;
    });
    return name;
  }

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
                child: Text("bottom_nav_actions".tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Margins.margin16),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("bottom_actions_create_test".tr()),
                        leading: const Icon(Icons.track_changes_rounded,
                            color: CustomColors.secondaryColor),
                        onTap: () async {
                          Navigator.of(context).pop();
                          await TestBottomSheet.show(context);
                        },
                      ),
                      const Divider(),
                      ListTile(
                        title: Text("bottom_actions_create_kanlist".tr()),
                        leading: const Icon(Icons.add),
                        onTap: () async {
                          final navigator = Navigator.of(context);

                          /// Pass through the parent the name being input
                          final name =
                              await KPCreateKanListDialog.show(context);
                          navigator.pop(name);
                        },
                      ),
                      const Divider(),
                      ListTile(
                        title: Text("bottom_actions_create_folder".tr()),
                        leading: const Icon(Icons.create_new_folder_rounded),
                        onTap: () async {
                          final navigator = Navigator.of(context);
                          await navigator
                              .pushNamed(KanPracticePages.folderAddPage);
                          navigator.pop("__folder");
                        },
                      ),
                      const Divider(),
                      ListTile(
                        title: Text("bottom_actions_upload_list".tr()),
                        leading: const Icon(Icons.upload_rounded),
                        onTap: () async {
                          final navigator = Navigator.of(context);
                          await navigator
                              .pushNamed(KanPracticePages.marketAddListPage);
                          navigator.pop();
                        },
                      ),
                      const SizedBox(height: Margins.margin24)
                    ],
                  )),
            ],
          ),
        ]);
      },
    );
  }
}
