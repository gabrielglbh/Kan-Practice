import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/application/folder_list/folder_bloc.dart';
import 'package:kanpractice/domain/folder/folder.dart';
import 'package:kanpractice/presentation/core/widgets/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/widgets/kp_empty_list.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class FolderListBottomSheet extends StatefulWidget {
  final String? name;
  const FolderListBottomSheet({super.key, required this.name});

  /// Creates and calls the [BottomSheet] with the content for a regular test
  static Future<String?> show(BuildContext context, String? name) async {
    String? resultName;
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => FolderListBottomSheet(name: name)).then((value) {
      resultName = value;
    });
    return resultName;
  }

  @override
  State<FolderListBottomSheet> createState() => _FolderListBottomSheetState();
}

class _FolderListBottomSheetState extends State<FolderListBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
        context.read<FolderBloc>().add(FolderForTestEventLoading());
        return Wrap(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const KPDragContainer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: KPMargins.margin8,
                    horizontal: KPMargins.margin32),
                child: Text(
                    widget.name != null
                        ? "add_to_folder_from_list_title".tr()
                        : "add_to_market_select_list".tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              BlocConsumer<FolderBloc, FolderState>(
                listener: (context, state) {
                  state.mapOrNull(listAdded: (_) {
                    Navigator.of(context).pop();
                  });
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    error: () => KPEmptyList(
                      showTryButton: true,
                      onRefresh: () => context
                          .read<FolderBloc>()
                          .add(FolderForTestEventLoading()),
                      message: "add_to_folder_from_list_error".tr(),
                    ),
                    loading: () => const KPProgressIndicator(),
                    loaded: (folders) => Container(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height / 3),
                      margin: const EdgeInsets.all(KPMargins.margin8),
                      child: folders.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: KPMargins.margin24),
                              child: Text("folder_list_empty".tr()),
                            )
                          : _listSelection(folders),
                    ),
                    orElse: () => const SizedBox(),
                  );
                },
              )
            ],
          ),
        ]);
      },
    );
  }

  Widget _listSelection(List<Folder> folders) {
    return ListView.separated(
      separatorBuilder: (context, index) =>
          const Divider(height: KPMargins.margin4),
      itemCount: folders.length,
      itemBuilder: (context, index) {
        String listName = folders[index].folder;
        return ListTile(
          onTap: () {
            if (widget.name != null) {
              context
                  .read<FolderBloc>()
                  .add(FolderEventAddSingleList(widget.name!, listName));
            } else {
              Navigator.of(context).pop(listName);
            }
          },
          title: Text(listName),
        );
      },
    );
  }
}
