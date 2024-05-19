import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/types/word_categories.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class KPWordCategoryList extends StatelessWidget {
  /// Function called when a certain category is tapped. Index is provided
  final Function(int) onSelected;

  /// Function that should return [bool] to change style of the selected category
  final Function(int) selected;
  final bool hasScrollablePhysics;
  const KPWordCategoryList(
      {super.key,
      required this.onSelected,
      required this.selected,
      this.hasScrollablePhysics = false});

  @override
  Widget build(BuildContext context) {
    return GridView(
      physics:
          hasScrollablePhysics ? null : const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 2.8),
      children: List.generate(WordCategory.values.length, (index) {
        return GestureDetector(
          onTap: () => onSelected(index),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(KPRadius.radius16),
              border: Border.all(
                  color: selected(index)
                      ? Colors.transparent
                      : KPColors.getSubtle(context)),
              color: selected(index)
                  ? KPColors.secondaryDarkerColor
                  : Colors.transparent,
            ),
            margin: const EdgeInsets.symmetric(
                horizontal: KPMargins.margin4, vertical: KPMargins.margin2),
            alignment: Alignment.center,
            child: Text(
              WordCategory.values[index].category,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: selected(index)
                        ? KPColors.primaryLight
                        : KPColors.getAccent(context),
                  ),
            ),
          ),
        );
      }),
    );
  }
}
