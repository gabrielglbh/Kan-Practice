import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/jisho/models/jisho_data.dart';
import 'package:kanpractice/core/types/kanlist_filters.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/core/types/kanji_categories.dart';
import 'package:kanpractice/ui/pages/folder_lists/bloc/folder_bloc.dart';
import 'package:kanpractice/ui/widgets/kp_kanji_lists/bloc/lists_bloc.dart';
import 'package:kanpractice/ui/widgets/kp_create_kanlist_dialog.dart';
import 'package:kanpractice/ui/widgets/kp_drag_container.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/widgets/kp_empty_list.dart';
import 'package:kanpractice/ui/widgets/kp_kanji_category_list.dart';
import 'package:kanpractice/ui/widgets/kp_progress_indicator.dart';
import 'package:easy_localization/easy_localization.dart';

class AddToFolderBottomSheet extends StatefulWidget {
  final String? name;
  const AddToFolderBottomSheet({Key? key, required this.name})
      : super(key: key);

  /// Creates and calls the [BottomSheet] with the content for a regular test
  static Future<String?> show(BuildContext context, String? name) async {
    return await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => AddToFolderBottomSheet(name: name));
  }

  @override
  State<AddToFolderBottomSheet> createState() => _AddToFolderBottomSheetState();
}

class _AddToFolderBottomSheetState extends State<AddToFolderBottomSheet> {
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
                child: Text("add_to_folder_from_list_title".tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6),
              ),
              BlocProvider<FolderBloc>(
                create: (_) =>
                    FolderBloc()..add(const FolderForTestEventLoading()),
                child: BlocConsumer<FolderBloc, FolderState>(
                  listener: (context, state) {
                    if (state is FolderStateLoaded && state.lists.isEmpty) {
                      Navigator.of(context).pop();
                    }
                  },
                  builder: (context, state) {
                    if (state is FolderStateFailure) {
                      return KPEmptyList(
                          showTryButton: true,
                          onRefresh: () => context
                              .read<FolderBloc>()
                              .add(const FolderForTestEventLoading()),
                          message: "add_to_folder_from_list_error".tr());
                    } else if (state is FolderStateLoading) {
                      return const KPProgressIndicator();
                    } else if (state is FolderStateLoaded) {
                      return Container(
                          constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height / 2),
                          margin: const EdgeInsets.all(Margins.margin8),
                          child: _listSelection(state));
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
            context
                .read<FolderBloc>()
                .add(FolderEventAddSingleList(widget.name!, listName));
          },
          title: Text(listName),
        );
      },
    );
  }
}
