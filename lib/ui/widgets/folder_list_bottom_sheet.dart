import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/ui/pages/folder_lists/bloc/folder_bloc.dart';
import 'package:kanpractice/ui/widgets/kp_drag_container.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/widgets/kp_empty_list.dart';
import 'package:kanpractice/ui/widgets/kp_progress_indicator.dart';
import 'package:easy_localization/easy_localization.dart';

class FolderListBottomSheet extends StatefulWidget {
  final String? name;
  const FolderListBottomSheet({Key? key, required this.name}) : super(key: key);

  /// Creates and calls the [BottomSheet] with the content for a regular test
  static Future<String?> show(BuildContext context, String? name) async {
    String? name;
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => FolderListBottomSheet(name: name)).then((value) {
      name = value;
    });
    return name;
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
        return Wrap(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const KPDragContainer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Margins.margin8, horizontal: Margins.margin32),
                child: Text(
                    widget.name != null
                        ? "add_to_folder_from_list_title".tr()
                        : "add_to_market_select_list".tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6),
              ),
              BlocProvider<FolderBloc>(
                create: (_) => FolderBloc()..add(FolderForTestEventLoading()),
                child: BlocBuilder<FolderBloc, FolderState>(
                  builder: (context, state) {
                    if (state is FolderStateFailure) {
                      return KPEmptyList(
                          showTryButton: true,
                          onRefresh: () => context
                              .read<FolderBloc>()
                              .add(FolderForTestEventLoading()),
                          message: "add_to_folder_from_list_error".tr());
                    } else if (state is FolderStateLoading) {
                      return const KPProgressIndicator();
                    } else if (state is FolderStateLoaded) {
                      return Container(
                          constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height / 3),
                          margin: const EdgeInsets.all(Margins.margin8),
                          child: state.lists.isEmpty
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: Margins.margin24),
                                  child: Text("folder_list_empty".tr()),
                                )
                              : _listSelection(state));
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              )
            ],
          ),
        ]);
      },
    );
  }

  Widget _listSelection(FolderStateLoaded state) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      itemCount: state.lists.length,
      itemBuilder: (context, index) {
        String listName = state.lists[index].folder;
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