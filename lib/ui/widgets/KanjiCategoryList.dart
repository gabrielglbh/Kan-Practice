import 'package:flutter/material.dart';
import 'package:kanpractice/core/utils/types/kanji_categories.dart';
import 'package:kanpractice/ui/theme/consts.dart';

class KanjiCategoryList extends StatelessWidget {
  /// Function called when a certain category is tapped. Index is provided
  final Function(int) onSelected;
  /// Function that should return [bool] to change style of the selected category
  final Function(int) selected;
  final bool hasScrollablePhysics;
  const KanjiCategoryList({
    required this.onSelected,
    required this.selected,
    this.hasScrollablePhysics = false
  });

  @override
  Widget build(BuildContext context) {
    return GridView(
      physics: hasScrollablePhysics ? null : NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 2.8
      ),
      children: List.generate(KanjiCategory.values.length, (index) {
        return GestureDetector(
          onTap: () => onSelected(index),
          child: Container(
            decoration: BoxDecoration(
              color: selected(index) ? CustomColors.secondaryDarkerColor : CustomColors.secondaryColor,
              borderRadius: BorderRadius.circular(CustomRadius.radius16)
            ),
            margin: EdgeInsets.symmetric(horizontal: Margins.margin4, vertical: Margins.margin2),
            alignment: Alignment.center,
            child: Text(KanjiCategory.values[index].category, style: TextStyle(
              color: Colors.white, fontSize: FontSizes.fontSize14
            ))
          ),
        );
      }),
    );
  }
}
