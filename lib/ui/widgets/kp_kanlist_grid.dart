import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/ui/consts.dart';

class KPKanListGrid extends StatelessWidget {
  final Function(String name) onTap;
  final List<KanjiList> items;
  final bool Function(String name) isSelected;
  const KPKanListGrid({
    Key? key,
    required this.onTap,
    required this.items,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, childAspectRatio: 2),
      itemCount: items.length,
      itemBuilder: (context, index) {
        String name = items[index].name;
        return Padding(
          padding: const EdgeInsets.all(Margins.margin4),
          child: GestureDetector(
            onTap: () {
              onTap(name);
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: Margins.margin4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(CustomRadius.radius16),
                color: isSelected(name)
                    ? CustomColors.secondaryDarkerColor
                    : CustomColors.secondaryColor,
              ),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
