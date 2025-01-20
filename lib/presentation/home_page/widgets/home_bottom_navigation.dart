import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/types/home_types.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/home_page/widgets/actions_bottom_sheet.dart';

class HomeBottomNavigation extends StatelessWidget {
  final Function(HomeType) onPageChanged;
  final Function(String?) onShowActions;
  final HomeType currentPage;
  final List<GlobalKey> tutorialKeys;
  const HomeBottomNavigation({
    super.key,
    required this.onShowActions,
    required this.currentPage,
    required this.onPageChanged,
    required this.tutorialKeys,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: 64,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey
                  : KPColors.accentLight,
              blurRadius: 6,
              offset: Offset(0, -8),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            HomeType.values.length,
            (index) => _bottomBarItem(
              context,
              HomeType.values[index],
              tutorialKeys[index],
              constraints.maxWidth,
            ),
          ),
        ),
      );
    });
  }

  Widget _bottomBarItem(
      BuildContext context, HomeType type, GlobalKey key, double width) {
    final selectedColor = currentPage == type;
    final color = Theme.of(context).colorScheme.outline;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          if (type != HomeType.actions) {
            onPageChanged(type);
          } else {
            final code = await ActionsBottomSheet.show(context, currentPage);
            onShowActions(code);
          }
        },
        child: Container(
          key: key,
          width: width / HomeType.values.length,
          height: 42,
          color: Colors.transparent,
          child: Icon(type.icon,
              color: selectedColor
                  ? Theme.of(context).colorScheme.primary
                  : color),
        ),
      ),
    );
  }
}
