import 'package:flutter/material.dart';
import 'package:kanpractice/core/types/home_types.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/home_page/widgets/actions_bottom_sheet.dart';

class HomeBottomNavigation extends StatelessWidget {
  final Function(HomeType) onPageChanged;
  final Function(String) onShowActions;
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
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.grey.shade700,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.grey
                : Colors.black,
            blurRadius: 10,
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
          ),
        ),
      ),
    );
  }

  Widget _bottomBarItem(BuildContext context, HomeType type, GlobalKey key) {
    final selectedColor = currentPage == type;
    final color = Theme.of(context).brightness == Brightness.light
        ? Colors.grey.shade700
        : Colors.grey.shade400;
    return GestureDetector(
      onTap: () async {
        if (type != HomeType.actions) {
          onPageChanged(type);
        } else {
          final code = await ActionsBottomSheet.show(context, currentPage);
          if (code != null) {
            onShowActions(code);
          }
        }
      },
      child: Container(
        key: key,
        width: MediaQuery.of(context).size.width / 5,
        height: 42,
        color: Colors.transparent,
        child: Icon(type.icon,
            color: selectedColor ? KPColors.secondaryColor : color),
      ),
    );
  }
}
