import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/types/list_details_types.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class KPWordGrammarBottomNavigation extends StatelessWidget {
  final Function(ListDetailsType) onPageChanged;
  final ListDetailsType currentPage;
  const KPWordGrammarBottomNavigation({
    super.key,
    required this.currentPage,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.grey
                : KPColors.accentLight,
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          ListDetailsType.values.length,
          (index) => _bottomBarItem(
            context,
            ListDetailsType.values[index],
          ),
        ),
      ),
    );
  }

  Widget _bottomBarItem(BuildContext context, ListDetailsType type) {
    final selectedColor = currentPage == type;
    final color = Theme.of(context).colorScheme.outline;
    return GestureDetector(
      onTap: () {
        onPageChanged(type);
      },
      child: Container(
        width:
            MediaQuery.of(context).size.width / ListDetailsType.values.length,
        height: 42,
        color: Colors.transparent,
        alignment: Alignment.center,
        child: Column(
          children: [
            Icon(
              type.icon,
              color:
                  selectedColor ? Theme.of(context).colorScheme.primary : color,
            ),
            const SizedBox(height: 2),
            Text(
              type.bottomBarLabel,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: selectedColor
                        ? Theme.of(context).colorScheme.primary
                        : color,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
