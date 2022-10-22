import 'package:flutter/material.dart';
import 'package:kanpractice/core/types/kanji_categories.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class KPKanjiCategoryList extends StatelessWidget {
  /// Function called when a certain category is tapped. Index is provided
  final Function(int) onSelected;

  /// Function that should return [bool] to change style of the selected category
  final Function(int) selected;
  final bool hasScrollablePhysics;
  const KPKanjiCategoryList(
      {Key? key,
      required this.onSelected,
      required this.selected,
      this.hasScrollablePhysics = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      physics:
          hasScrollablePhysics ? null : const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 2.8),
      children: List.generate(KanjiCategory.values.length, (index) {
        return GestureDetector(
          onTap: () => onSelected(index),
          child: Container(
              decoration: BoxDecoration(
                  color: selected(index)
                      ? KPColors.secondaryDarkerColor
                      : KPColors.secondaryColor,
                  borderRadius: BorderRadius.circular(KPRadius.radius16)),
              margin: const EdgeInsets.symmetric(
                  horizontal: KPMargins.margin4, vertical: KPMargins.margin2),
              alignment: Alignment.center,
              child: Text(KanjiCategory.values[index].category,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: Colors.white))),
        );
      }),
    );
  }
}
