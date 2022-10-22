import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/queries/folder_queries.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/types/kanji_categories.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/core/ui/kp_button.dart';
import 'package:kanpractice/presentation/core/ui/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/ui/kp_kanji_category_list.dart';
import 'package:kanpractice/presentation/core/ui/kp_study_mode.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class KPKanListCategorySelectionBottomSheet extends StatefulWidget {
  final String? folder;
  const KPKanListCategorySelectionBottomSheet({Key? key, this.folder})
      : super(key: key);

  @override
  State<KPKanListCategorySelectionBottomSheet> createState() =>
      _KPKanListCategorySelectionBottomSheetState();

  /// Creates and calls the [BottomSheet] with the content for a regular test
  static Future<String?> show(BuildContext context, {String? folder}) async {
    return await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) =>
            KPKanListCategorySelectionBottomSheet(folder: folder));
  }
}

class _KPKanListCategorySelectionBottomSheetState
    extends State<KPKanListCategorySelectionBottomSheet> {
  List<Kanji> _kanji = [];
  KanjiCategory _selectedCategory = KanjiCategory.noun;

  bool _selectionMode = false;
  bool _onListEmpty = false;

  Future<List<Kanji>> _loadKanjiFromListSelection(
      KanjiCategory category) async {
    List<Kanji> list = [];
    if (widget.folder == null) {
      list =
          await KanjiQueries.instance.getKanjiBasedOnCategory(category.index);
    } else {
      list = await FolderQueries.instance.getAllKanjiOnListsOnFolder(
        [widget.folder!],
        type: Tests.categories,
        category: category.index,
      );
    }
    list.shuffle();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final folder = widget.folder != null ? ": ${widget.folder}" : "";
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
                child: Text(
                    "${"categories_test_bottom_sheet_title".tr()}$folder",
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
                  testName: widget.folder == null
                      ? "${"categories_test_bottom_sheet_label".tr()} ${_selectedCategory.category}"
                      : "${"categories_test_bottom_sheet_label".tr()} ${_selectedCategory.category} - ${widget.folder}",
                ),
              ),
              Visibility(
                visible: !_selectionMode,
                child: Container(
                  margin: const EdgeInsets.all(KPMargins.margin8),
                  child: _categorySelection(),
                ),
              )
            ],
          ),
        ]);
      },
    );
  }

  Column _categorySelection() {
    return Column(
      children: [
        KPKanjiCategoryList(
          selected: (index) => index == _selectedCategory.index,
          onSelected: (index) => setState(() {
            _selectedCategory = KanjiCategory.values[index];
            _onListEmpty = false;
          }),
        ),
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
          },
        )
      ],
    );
  }
}
