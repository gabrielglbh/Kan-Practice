import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/utils/types/kanji_categories.dart';
import 'package:kanpractice/core/utils/types/test_modes.dart';
import 'package:kanpractice/ui/pages/kanji_lists/bloc/lists_bloc.dart';
import 'package:kanpractice/ui/widgets/DragContainer.dart';
import 'package:kanpractice/ui/widgets/KanjiCategoryList.dart';
import 'package:kanpractice/ui/widgets/StudyMode.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/CustomButton.dart';
import 'package:kanpractice/ui/widgets/EmptyList.dart';
import 'package:kanpractice/ui/widgets/ProgressIndicator.dart';
import 'package:easy_localization/easy_localization.dart';

class KanListCategorySelectionBottomSheet extends StatefulWidget {
  const KanListCategorySelectionBottomSheet();

  @override
  _KanListCategorySelectionBottomSheetState createState() => _KanListCategorySelectionBottomSheetState();

  /// Creates and calls the [BottomSheet] with the content for a regular test
  static Future<String?> show(BuildContext context) async {
    return await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => KanListCategorySelectionBottomSheet()
    );
  }
}

class _KanListCategorySelectionBottomSheetState extends State<KanListCategorySelectionBottomSheet> {
  KanjiListBloc _bloc = KanjiListBloc();
  List<Kanji> _kanji = [];
  KanjiCategory _selectedCategory = KanjiCategory.noun;

  bool _selectionMode = false;
  bool _onListEmpty = false;

  Future<List<Kanji>> _loadKanjiFromListSelection(KanjiCategory category) async {
    final k = await KanjiQueries.instance.getKanjiBasedOnCategory(category.index);
    k.shuffle();
    return k;
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
                  child: Text("categories_test_bottom_sheet_title".tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: FontSizes.fontSize18)),
                ),
                Visibility(
                  visible: _onListEmpty,
                  child: Text("categories_test_bottom_sheet_error".tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: FontSizes.fontSize18)),
                ),
                Visibility(
                  visible: _selectionMode,
                  child: TestStudyMode(
                    list: _kanji,
                    type: Tests.categories,
                    testName: "${"categories_test_bottom_sheet_label".tr()} ${_selectedCategory.category}"
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
        KanjiCategoryList(
          selected: (index) => index == _selectedCategory.index,
          onSelected: (index) => setState(() {
            _selectedCategory = KanjiCategory.values[index];
            _onListEmpty = false;
          })
        ),
        CustomButton(
          width: true,
          title1: "study_bottom_sheet_button_label_ext".tr(),
          title2: "study_bottom_sheet_button_label".tr(),
          onTap: () async {
            final List<Kanji> k = await _loadKanjiFromListSelection(_selectedCategory);
            if (k.isNotEmpty) {
              _kanji = k;
              setState(() => _selectionMode = true);
            } else {
              setState(() => _onListEmpty = true);
            }
          }
        )
      ],
    );
  }
}