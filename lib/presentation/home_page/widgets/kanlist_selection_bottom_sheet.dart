import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/list/lists_bloc.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/infrastructure/word/word_repository_impl.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/ui/kp_button.dart';
import 'package:kanpractice/presentation/core/ui/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/ui/kp_empty_list.dart';
import 'package:kanpractice/presentation/core/ui/kp_kanlist_grid.dart';
import 'package:kanpractice/presentation/core/ui/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/ui/kp_study_mode.dart';
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
  final ListBloc _bloc = ListBloc();
  List<Word> _kanji = [];
  final List<String> _selectedLists = [];
  String _selectedFormattedLists = "";

  bool _selectionMode = false;
  bool _onListEmpty = false;

  Future<void> _loadKanjiFromListSelection(List<String> lists) async {
    _kanji =
        await getIt<WordRepositoryImpl>().getWordBasedOnSelectedLists(lists);
    _kanji.shuffle();

    /// Keep the list names all the way to the Test Result page in a formatted way
    for (var name in _selectedLists) {
      _selectedFormattedLists += "$name, ";
    }
    _selectedFormattedLists = _selectedFormattedLists.substring(
        0, _selectedFormattedLists.length - 2);
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
              Visibility(
                visible: _selectionMode,
                child: KPTestStudyMode(
                    list: _kanji,
                    type: Tests.lists,
                    testName: _selectedFormattedLists),
              ),
              Visibility(
                visible: !_selectionMode,
                child: BlocProvider(
                  create: (_) => _bloc..add(const ListForTestEventLoading()),
                  child: BlocBuilder<ListBloc, ListState>(
                    builder: (context, state) {
                      if (state is ListStateFailure) {
                        return KPEmptyList(
                            showTryButton: true,
                            onRefresh: () =>
                                _bloc..add(const ListForTestEventLoading()),
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
                ),
              )
            ],
          ),
        ]);
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
            width: true,
            title1: "study_bottom_sheet_button_label_ext".tr(),
            title2: "study_bottom_sheet_button_label".tr(),
            onTap: () async {
              if (_selectedLists.isNotEmpty) {
                await _loadKanjiFromListSelection(_selectedLists);
                if (_kanji.isNotEmpty) setState(() => _selectionMode = true);
              } else {
                setState(() => _onListEmpty = true);
              }
            })
      ],
    );
  }
}
