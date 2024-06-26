import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/presentation/core/types/home_types.dart';
import 'package:kanpractice/presentation/core/widgets/kp_create_kanlist_dialog.dart';
import 'package:kanpractice/presentation/core/widgets/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/widgets/kp_test_bottom_sheet.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class ActionsBottomSheet extends StatelessWidget {
  const ActionsBottomSheet({super.key});

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
                    vertical: KPMargins.margin8,
                    horizontal: KPMargins.margin32),
                child: Text("bottom_nav_actions".tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: KPMargins.margin16),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("bottom_actions_create_test".tr()),
                        leading: Icon(Icons.track_changes_rounded,
                            color: Theme.of(context).colorScheme.primary),
                        onTap: () async {
                          Navigator.of(context).pop();
                          await KPTestBottomSheet.show(context);
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
                      const SizedBox(height: KPMargins.margin24)
                    ],
                  )),
            ],
          ),
        ]);
      },
    );
  }
}
