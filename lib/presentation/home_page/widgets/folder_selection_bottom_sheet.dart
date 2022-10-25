import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/folder_list/folder_bloc.dart';
import 'package:kanpractice/application/load_test_folder_selection/load_test_folder_selection_bloc.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/folder/folder.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/ui/kp_button.dart';
import 'package:kanpractice/presentation/core/ui/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/ui/kp_empty_list.dart';
import 'package:kanpractice/presentation/core/ui/kp_kanlist_grid.dart';
import 'package:kanpractice/presentation/core/ui/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/ui/kp_study_mode.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class FolderSelectionBottomSheet extends StatefulWidget {
  const FolderSelectionBottomSheet({Key? key}) : super(key: key);

  @override
  State<FolderSelectionBottomSheet> createState() =>
      _FolderSelectionBottomSheetState();

  /// Creates and calls the [BottomSheet] with the content for a regular test
  static Future<String?> show(BuildContext context) async {
    return await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const FolderSelectionBottomSheet());
  }
}

class _FolderSelectionBottomSheetState
    extends State<FolderSelectionBottomSheet> {
  final List<String> _selectedFolders = [];
  String _selectedFormattedFolder = "";

  bool _selectionMode = false;
  bool _onListEmpty = false;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
        getIt<FolderBloc>().add(FolderForTestEventLoading());
        return BlocListener<LoadTestFolderSelectionBloc,
            LoadTestFolderSelectionState>(
          listener: (context, state) {
            if (state is LoadTestFolderSelectionStateLoadedList) {
              if (state.words.isEmpty) return;

              setState(() => _selectionMode = true);

              /// Keep the list names all the way to the Test Result page in a formatted way
              for (var name in _selectedFolders) {
                _selectedFormattedFolder += "$name, ";
              }
              _selectedFormattedFolder = _selectedFormattedFolder.substring(
                  0, _selectedFormattedFolder.length - 2);
            }
          },
          child: Wrap(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const KPDragContainer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: KPMargins.margin8,
                        horizontal: KPMargins.margin32),
                    child: Text("study_folder_bottom_sheet_title".tr(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6),
                  ),
                  Visibility(
                    visible: _onListEmpty,
                    child: Text("study_bottom_sheet_load_failed".tr(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(fontWeight: FontWeight.w400)),
                  ),
                  BlocBuilder<LoadTestFolderSelectionBloc,
                      LoadTestFolderSelectionState>(
                    builder: (context, state) {
                      if (state is! LoadTestFolderSelectionStateLoadedList) {
                        return const SizedBox();
                      }
                      return Visibility(
                        visible: _selectionMode,
                        child: KPTestStudyMode(
                          list: state.words,
                          type: Tests.folder,
                          testName: _selectedFormattedFolder,
                        ),
                      );
                    },
                  ),
                  Visibility(
                    visible: !_selectionMode,
                    child: BlocBuilder<FolderBloc, FolderState>(
                      builder: (context, state) {
                        if (state is FolderStateFailure) {
                          return KPEmptyList(
                              showTryButton: true,
                              onRefresh: () => getIt<FolderBloc>()
                                ..add(FolderForTestEventLoading()),
                              message: "study_bottom_sheet_load_failed".tr());
                        } else if (state is FolderStateLoading) {
                          return const KPProgressIndicator();
                        } else if (state is FolderStateLoaded) {
                          return Container(
                              constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height / 2.5),
                              margin: const EdgeInsets.all(KPMargins.margin8),
                              child: _listSelection(state));
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Column _listSelection(FolderStateLoaded state) {
    return Column(
      children: [
        Expanded(
          child: KPKanListGrid<Folder>(
            items: state.lists,
            isSelected: (name) => _selectedFolders.contains(name),
            onTap: (name) {
              setState(() {
                _onListEmpty = false;
                if (_selectedFolders.contains(name)) {
                  _selectedFolders.remove(name);
                } else {
                  _selectedFolders.add(name);
                }
              });
            },
          ),
        ),
        KPButton(
            width: true,
            title1: "study_bottom_sheet_button_label_ext".tr(),
            title2: "study_bottom_sheet_button_label".tr(),
            onTap: () async {
              if (_selectedFolders.isNotEmpty) {
                getIt<LoadTestFolderSelectionBloc>().add(
                    LoadTestFolderSelectionEventLoadList(
                        folders: _selectedFolders));
              } else {
                setState(() => _onListEmpty = true);
              }
            })
      ],
    );
  }
}
