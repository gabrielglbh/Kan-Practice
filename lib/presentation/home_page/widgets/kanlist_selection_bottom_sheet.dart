import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/list/lists_bloc.dart';
import 'package:kanpractice/application/load_test_list_selection/load_test_list_selection_bloc.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/ui/kp_button.dart';
import 'package:kanpractice/presentation/core/ui/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/ui/kp_empty_list.dart';
import 'package:kanpractice/presentation/core/ui/kp_kanlist_grid.dart';
import 'package:kanpractice/presentation/core/ui/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/ui/modes_grid/kp_modes_grid.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class KanListSelectionBottomSheet extends StatefulWidget {
  const KanListSelectionBottomSheet({Key? key}) : super(key: key);

  @override
  State<KanListSelectionBottomSheet> createState() =>
      _KanListSelectionBottomSheetState();

  /// Creates and calls the [BottomSheet] with the content for a regular test
  static Future<String?> show(BuildContext context) async {
    return await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const KanListSelectionBottomSheet());
  }
}

class _KanListSelectionBottomSheetState
    extends State<KanListSelectionBottomSheet> {
  final List<String> _selectedLists = [];
  String _selectedFormattedLists = "";

  bool _selectionMode = false;
  bool _onListEmpty = false;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
        getIt<ListBloc>().add(const ListForTestEventLoading());
        return BlocListener<LoadTestListSelectionBloc,
                LoadTestListSelectionState>(
            listener: (context, state) {
              if (state is LoadTestListSelectionStateLoadedList) {
                if (state.words.isEmpty) return;

                setState(() => _selectionMode = true);

                /// Keep the list names all the way to the Test Result page in a formatted way
                for (var name in _selectedLists) {
                  _selectedFormattedLists += "$name, ";
                }
                _selectedFormattedLists = _selectedFormattedLists.substring(
                    0, _selectedFormattedLists.length - 2);
              }
            },
            child: Wrap(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const KPDragContainer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: KPMargins.margin8,
                        horizontal: KPMargins.margin32),
                    child: Text("study_bottom_sheet_title".tr(),
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
                  BlocBuilder<LoadTestListSelectionBloc,
                      LoadTestListSelectionState>(
                    builder: (context, state) {
                      if (state is! LoadTestListSelectionStateLoadedList) {
                        return const SizedBox();
                      }
                      return Visibility(
                        visible: _selectionMode,
                        // TODO: List selection test on grammar - pass list load to LoadTestBloc / LoadGrammarTestBloc
                        child: KPModesGrid(
                          list: state.words,
                          type: Tests.lists,
                          testName: _selectedFormattedLists,
                        ),
                      );
                    },
                  ),
                  Visibility(
                    visible: !_selectionMode,
                    child: BlocBuilder<ListBloc, ListState>(
                      builder: (context, state) {
                        if (state is ListStateFailure) {
                          return KPEmptyList(
                              showTryButton: true,
                              onRefresh: () => getIt<ListBloc>()
                                ..add(const ListForTestEventLoading()),
                              message: "study_bottom_sheet_load_failed".tr());
                        } else if (state is ListStateLoading) {
                          return const KPProgressIndicator();
                        } else if (state is ListStateLoaded) {
                          return Container(
                              constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height / 2.5),
                              margin: const EdgeInsets.all(KPMargins.margin8),
                              child: _listSelection(state));
                        } else {
                          return Container();
                        }
                      },
                    ),
                  )
                ],
              ),
            ]));
      },
    );
  }

  Column _listSelection(ListStateLoaded state) {
    return Column(
      children: [
        Expanded(
          child: KPKanListGrid(
            items: state.lists,
            isSelected: (name) => _selectedLists.contains(name),
            onTap: (name) {
              setState(() {
                _onListEmpty = false;
                if (_selectedLists.contains(name)) {
                  _selectedLists.remove(name);
                } else {
                  _selectedLists.add(name);
                }
              });
            },
          ),
        ),
        KPButton(
          title1: "study_bottom_sheet_button_label_ext".tr(),
          title2: "study_bottom_sheet_button_label".tr(),
          onTap: () async {
            if (_selectedLists.isNotEmpty) {
              getIt<LoadTestListSelectionBloc>().add(
                  LoadTestListSelectionEventLoadList(lists: _selectedLists));
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
