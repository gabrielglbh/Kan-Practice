import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/types/word_categories.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/core/widgets/kp_button.dart';
import 'package:kanpractice/presentation/core/widgets/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/widgets/kp_word_category_list.dart';
import 'package:kanpractice/presentation/core/widgets/modes_grid/kp_modes_grid.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class KPKanListCategorySelectionBottomSheet extends StatefulWidget {
  final String? folder;
  const KPKanListCategorySelectionBottomSheet({super.key, this.folder});

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
  WordCategory _selectedCategory = WordCategory.noun;
  bool _selectionMode = false;
  bool _onListEmpty = false;

  @override
  Widget build(BuildContext context) {
    final folder = widget.folder != null ? ": ${widget.folder}" : "";
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
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
                  child: Text(
                      "${"categories_test_bottom_sheet_title".tr()}$folder",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                Visibility(
                  visible: _onListEmpty,
                  child: Text("categories_test_bottom_sheet_error".tr(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.w400)),
                ),
                Visibility(
                  visible: _selectionMode,
                  child: KPModesGrid(
                    type: Tests.categories,
                    folder: widget.folder,
                    selectionQuery: [_selectedCategory.name],
                    testName: widget.folder == null
                        ? "${"categories_test_bottom_sheet_label".tr()} ${_selectedCategory.category}"
                        : "${"categories_test_bottom_sheet_label".tr()} ${_selectedCategory.category} - ${widget.folder}",
                  ),
                ),
                Visibility(
                  visible: !_selectionMode,
                  child: Container(
                    margin: const EdgeInsets.all(KPMargins.margin8),
                    child: Column(
                      children: [
                        KPWordCategoryList(
                          selected: (index) => index == _selectedCategory.index,
                          onSelected: (index) => setState(() {
                            _selectedCategory = WordCategory.values[index];
                            _onListEmpty = false;
                          }),
                        ),
                        KPButton(
                          title1: "study_bottom_sheet_button_label_ext".tr(),
                          title2: "study_bottom_sheet_button_label".tr(),
                          onTap: () {
                            setState(() {
                              _selectionMode = true;
                            });
                          },
                        ),
                        const SizedBox(height: KPMargins.margin8),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
