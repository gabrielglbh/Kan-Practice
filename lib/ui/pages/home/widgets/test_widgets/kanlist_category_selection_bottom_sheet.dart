import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/types/kanji_categories.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:kanpractice/ui/widgets/kp_kanji_lists/bloc/lists_bloc.dart';
import 'package:kanpractice/ui/widgets/kp_drag_container.dart';
import 'package:kanpractice/ui/widgets/kp_kanji_category_list.dart';
import 'package:kanpractice/ui/widgets/kp_study_mode.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/widgets/kp_button.dart';
import 'package:kanpractice/ui/widgets/kp_empty_list.dart';
import 'package:kanpractice/ui/widgets/kp_progress_indicator.dart';
import 'package:easy_localization/easy_localization.dart';

class KanListCategorySelectionBottomSheet extends StatefulWidget {
  const KanListCategorySelectionBottomSheet({Key? key}) : super(key: key);

  @override
  State<KanListCategorySelectionBottomSheet> createState() =>
      _KanListCategorySelectionBottomSheetState();

  /// Creates and calls the [BottomSheet] with the content for a regular test
  static Future<String?> show(BuildContext context) async {
    return await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const KanListCategorySelectionBottomSheet());
  }
}

class _KanListCategorySelectionBottomSheetState
    extends State<KanListCategorySelectionBottomSheet> {
  final KanjiListBloc _bloc = KanjiListBloc();
  List<Kanji> _kanji = [];
  KanjiCategory _selectedCategory = KanjiCategory.noun;

  bool _selectionMode = false;
  bool _onListEmpty = false;

  Future<List<Kanji>> _loadKanjiFromListSelection(
      KanjiCategory category) async {
    final k =
        await KanjiQueries.instance.getKanjiBasedOnCategory(category.index);
    k.shuffle();
    return k;
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
                child: Text("categories_test_bottom_sheet_title".tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6),
              ),
              Visibility(
                visible: _onListEmpty,
                child: Text("categories_test_bottom_sheet_error".tr(),
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
                    type: Tests.categories,
                    testName:
                        "${"categories_test_bottom_sheet_label".tr()} ${_selectedCategory.category}"),
              ),
              Visibility(
                visible: !_selectionMode,
                child: BlocProvider(
                  create: (_) =>
                      _bloc..add(const KanjiListForTestEventLoading()),
                  child: BlocBuilder<KanjiListBloc, KanjiListState>(
                    builder: (context, state) {
                      if (state is KanjiListStateFailure) {
                        return KPEmptyList(
                            showTryButton: true,
                            onRefresh: () => _bloc
                              ..add(const KanjiListForTestEventLoading()),
                            message: "study_bottom_sheet_load_failed".tr());
                      } else if (state is KanjiListStateLoading) {
                        return const KPProgressIndicator();
                      } else if (state is KanjiListStateLoaded) {
                        return Container(
                            margin: const EdgeInsets.all(Margins.margin8),
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

  Column _listSelection(KanjiListStateLoaded state) {
    return Column(
      children: [
        KPKanjiCategoryList(
            selected: (index) => index == _selectedCategory.index,
            onSelected: (index) => setState(() {
                  _selectedCategory = KanjiCategory.values[index];
                  _onListEmpty = false;
                })),
        KPButton(
            width: true,
            title1: "study_bottom_sheet_button_label_ext".tr(),
            title2: "study_bottom_sheet_button_label".tr(),
            onTap: () async {
              final List<Kanji> k =
                  await _loadKanjiFromListSelection(_selectedCategory);
              if (k.isNotEmpty) {
                _kanji = k;
                setState(() => _selectionMode = true);
              } else {
                setState(() => _onListEmpty = true);
              }
            })
      ],
    );
  }
}
