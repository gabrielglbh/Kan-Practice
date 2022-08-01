import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/database/models/folder.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/queries/folder_queries.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:kanpractice/ui/pages/folder_lists/bloc/folder_bloc.dart';
import 'package:kanpractice/ui/widgets/kp_drag_container.dart';
import 'package:kanpractice/ui/widgets/kp_kanlist_grid.dart';
import 'package:kanpractice/ui/widgets/kp_study_mode.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/widgets/kp_button.dart';
import 'package:kanpractice/ui/widgets/kp_empty_list.dart';
import 'package:kanpractice/ui/widgets/kp_progress_indicator.dart';
import 'package:easy_localization/easy_localization.dart';

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
  final FolderBloc _bloc = FolderBloc();
  List<Kanji> _kanji = [];
  final List<String> _selectedFolders = [];
  String _selectedFormattedFolder = "";

  bool _selectionMode = false;
  bool _onListEmpty = false;

  Future<void> _loadKanjiFromFolderSelection(List<String> folders) async {
    _kanji = await FolderQueries.instance.getAllKanjiOnListsOnFolder(folders);
    _kanji.shuffle();

    /// Keep the list names all the way to the Test Result page in a formatted way
    for (var name in _selectedFolders) {
      _selectedFormattedFolder += "$name, ";
    }
    _selectedFormattedFolder = _selectedFormattedFolder.substring(
        0, _selectedFormattedFolder.length - 2);
  }

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
              Visibility(
                visible: _selectionMode,
                child: KPTestStudyMode(
                    list: _kanji,
                    type: Tests.folder,
                    testName: _selectedFormattedFolder),
              ),
              Visibility(
                visible: !_selectionMode,
                child: BlocProvider(
                  create: (_) => _bloc..add(const FolderForTestEventLoading()),
                  child: BlocBuilder<FolderBloc, FolderState>(
                    builder: (context, state) {
                      if (state is FolderStateFailure) {
                        return KPEmptyList(
                            showTryButton: true,
                            onRefresh: () =>
                                _bloc..add(const FolderForTestEventLoading()),
                            message: "study_bottom_sheet_load_failed".tr());
                      } else if (state is FolderStateLoading) {
                        return const KPProgressIndicator();
                      } else if (state is FolderStateLoaded) {
                        return Container(
                            constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height / 2.5),
                            margin: const EdgeInsets.all(Margins.margin8),
                            child: _listSelection(state));
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ]);
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
                await _loadKanjiFromFolderSelection(_selectedFolders);
                if (_kanji.isNotEmpty) setState(() => _selectionMode = true);
              } else {
                setState(() => _onListEmpty = true);
              }
            })
      ],
    );
  }
}
