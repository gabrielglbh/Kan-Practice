import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/folder_list/folder_bloc.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/folder/folder.dart';
import 'package:kanpractice/presentation/core/widgets/kp_button.dart';
import 'package:kanpractice/presentation/core/widgets/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/widgets/kp_empty_list.dart';
import 'package:kanpractice/presentation/core/widgets/kp_kanlist_grid.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/widgets/modes_grid/kp_modes_grid.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class FolderSelectionBottomSheet extends StatefulWidget {
  const FolderSelectionBottomSheet({super.key});

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
        context.read<FolderBloc>().add(FolderForTestEventLoading());
        return Wrap(
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
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                Visibility(
                  visible: _onListEmpty,
                  child: Text("study_bottom_sheet_load_failed".tr(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.w400)),
                ),
                Visibility(
                  visible: _selectionMode,
                  child: KPModesGrid(
                    type: Tests.folder,
                    testName: _selectedFormattedFolder,
                    selectionQuery: _selectedFolders,
                  ),
                ),
                Visibility(
                  visible: !_selectionMode,
                  child: BlocBuilder<FolderBloc, FolderState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        error: () => KPEmptyList(
                          showTryButton: true,
                          onRefresh: () => context.read<FolderBloc>()
                            ..add(FolderForTestEventLoading()),
                          message: "study_bottom_sheet_load_failed".tr(),
                        ),
                        loaded: (folders) => Container(
                            constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height / 2.5),
                            margin: const EdgeInsets.all(KPMargins.margin8),
                            child: _listSelection(folders)),
                        loading: () => const KPProgressIndicator(),
                        orElse: () => const SizedBox(),
                      );
                    },
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }

  Column _listSelection(List<Folder> folders) {
    return Column(
      children: [
        Expanded(
          child: KPKanListGrid<Folder>(
            items: folders,
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
          title1: "study_bottom_sheet_button_label_ext".tr(),
          title2: "study_bottom_sheet_button_label".tr(),
          onTap: () async {
            if (_selectedFolders.isNotEmpty) {
              /// Keep the list names all the way to the Test Result page in a formatted way
              for (var name in _selectedFolders) {
                _selectedFormattedFolder += "$name, ";
              }
              _selectedFormattedFolder = _selectedFormattedFolder.substring(
                  0, _selectedFormattedFolder.length - 2);
              setState(() => _selectionMode = true);
            } else {
              setState(() => _onListEmpty = true);
            }
          },
        ),
        const SizedBox(height: KPMargins.margin8),
      ],
    );
  }
}
