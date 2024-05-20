import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/lists/lists_bloc.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/core/widgets/kp_button.dart';
import 'package:kanpractice/presentation/core/widgets/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/widgets/kp_empty_list.dart';
import 'package:kanpractice/presentation/core/widgets/kp_kanlist_grid.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/widgets/modes_grid/kp_modes_grid.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class KanListSelectionBottomSheet extends StatefulWidget {
  const KanListSelectionBottomSheet({super.key});

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
        context.read<ListsBloc>().add(const ListForTestEventLoading());
        return Wrap(children: [
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
                  type: Tests.lists,
                  testName: _selectedFormattedLists,
                  selectionQuery: _selectedLists,
                ),
              ),
              Visibility(
                visible: !_selectionMode,
                child: BlocBuilder<ListsBloc, ListsState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      error: () => KPEmptyList(
                        showTryButton: true,
                        onRefresh: () => context.read<ListsBloc>()
                          ..add(const ListForTestEventLoading()),
                        message: "study_bottom_sheet_load_failed".tr(),
                      ),
                      loading: () => const KPProgressIndicator(),
                      loaded: (lists) => Container(
                          constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height / 2.5),
                          margin: const EdgeInsets.all(KPMargins.margin8),
                          child: _listSelection(lists)),
                      orElse: () => const SizedBox(),
                    );
                  },
                ),
              )
            ],
          ),
        ]);
      },
    );
  }

  Column _listSelection(List<WordList> lists) {
    return Column(
      children: [
        Expanded(
          child: KPKanListGrid(
            items: lists,
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
          onTap: () {
            if (_selectedLists.isNotEmpty) {
              setState(() {
                /// Keep the list names all the way to the Test Result page in a formatted way
                for (var name in _selectedLists) {
                  _selectedFormattedLists += "$name, ";
                }
                _selectedFormattedLists = _selectedFormattedLists.substring(
                    0, _selectedFormattedLists.length - 2);

                _selectionMode = true;
              });
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
