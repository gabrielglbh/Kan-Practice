import 'package:flutter/material.dart';
import 'package:kanpractice/domain/folder/folder.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class KPKanListGrid<T> extends StatelessWidget {
  final Function(String name) onTap;
  final List<T> items;
  final bool Function(String name) isSelected;
  const KPKanListGrid({
    super.key,
    required this.onTap,
    required this.items,
    required this.isSelected,
  }) : assert(items is List<Folder> || items is List<WordList>);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 2.8),
      itemCount: items.length,
      itemBuilder: (context, index) {
        String name = items[index] is WordList
            ? (items[index] as WordList).name
            : (items[index] as Folder).folder;
        return Padding(
          padding: const EdgeInsets.all(KPMargins.margin4),
          child: GestureDetector(
            onTap: () {
              onTap(name);
            },
            child: Container(
              alignment: Alignment.center,
              padding:
                  const EdgeInsets.symmetric(horizontal: KPMargins.margin4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(KPRadius.radius16),
                border: Border.all(
                    color: isSelected(name)
                        ? Colors.transparent
                        : KPColors.getSubtle(context)),
                color: isSelected(name)
                    ? KPColors.secondaryDarkerColor
                    : Colors.transparent,
              ),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: isSelected(name)
                            ? KPColors.primaryLight
                            : KPColors.getAccent(context),
                      ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
