import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/utils/types/test_modes.dart';
import 'package:kanpractice/ui/pages/kanji_lists/bloc/lists_bloc.dart';
import 'package:kanpractice/ui/widgets/DragContainer.dart';
import 'package:kanpractice/ui/widgets/StudyMode.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/CustomButton.dart';
import 'package:kanpractice/ui/widgets/EmptyList.dart';
import 'package:kanpractice/ui/widgets/ProgressIndicator.dart';
import 'package:easy_localization/easy_localization.dart';

class KanListSelectionBottomSheet extends StatefulWidget {
  const KanListSelectionBottomSheet();

  @override
  _KanListSelectionBottomSheetState createState() => _KanListSelectionBottomSheetState();

  /// Creates and calls the [BottomSheet] with the content for a regular test
  static Future<String?> show(BuildContext context) async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => KanListSelectionBottomSheet()
    );
  }
}

class _KanListSelectionBottomSheetState extends State<KanListSelectionBottomSheet> {
  KanjiListBloc _bloc = KanjiListBloc();
  List<Kanji> _kanji = [];
  List<String> _selectedLists = [];
  String _selectedFormattedLists = "";

  bool _selectionMode = false;
  bool _onListEmpty = false;

  Future<void> _loadKanjiFromListSelection(List<String> lists) async {
    _kanji = await KanjiQueries.instance.getKanjiBasedOnSelectedLists(lists);
    _kanji.shuffle();
    /// Keep the list names all the way to the Test Result page in a formatted way
    _selectedLists.forEach((name) => _selectedFormattedLists += "$name, ");
    _selectedFormattedLists = _selectedFormattedLists.substring(0, _selectedFormattedLists.length - 2);
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
        return Wrap(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DragContainer(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Margins.margin8, horizontal: Margins.margin32),
                  child: Text("study_bottom_sheet_title".tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: FontSizes.fontSize18)),
                ),
                Visibility(
                  visible: _onListEmpty,
                  child: Text("study_bottom_sheet_load_failed".tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: FontSizes.fontSize18)),
                ),
                Visibility(
                  visible: _selectionMode,
                  child: TestStudyMode(
                    list: _kanji,
                    type: Tests.lists,
                    testName: _selectedFormattedLists
                  ),
                ),
                Visibility(
                  visible: !_selectionMode,
                  child: BlocProvider(
                    create: (_) => _bloc..add(KanjiListForTestEventLoading()),
                    child: BlocBuilder<KanjiListBloc, KanjiListState>(
                      builder: (context, state) {
                        if (state is KanjiListStateFailure)
                          return EmptyList(
                            showTryButton: true,
                            onRefresh: () => _bloc..add(KanjiListForTestEventLoading()),
                            message: "study_bottom_sheet_load_failed".tr()
                          );
                        else if (state is KanjiListStateLoading)
                          return CustomProgressIndicator();
                        else if (state is KanjiListStateLoaded) {
                          return Container(
                            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 2.5),
                            margin: EdgeInsets.all(Margins.margin8),
                            child: _listSelection(state)
                          );
                        } else return Container();
                      },
                    ),
                  ),
                )
              ],
            ),
          ]
        );
      },
    );
  }

  Column _listSelection(KanjiListStateLoaded state) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 2),
            itemCount: state.lists.length,
            itemBuilder: (context, index) {
              String name = state.lists[index].name;
              return Padding(
                padding: EdgeInsets.all(Margins.margin4),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _onListEmpty = false;
                      if (_selectedLists.contains(name)) _selectedLists.remove(name);
                      else _selectedLists.add(name);
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: Margins.margin4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(CustomRadius.radius16),
                      color: _selectedLists.contains(name)
                          ? CustomColors.secondaryDarkerColor : CustomColors.secondaryColor,
                    ),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(name, style: TextStyle(color: Colors.white))
                    )
                  ),
                ),
              );
            },
          ),
        ),
        CustomButton(
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
          }
        )
      ],
    );
  }
}