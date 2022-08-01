import 'package:flutter/material.dart';
import 'package:kanpractice/ui/consts.dart';

class KPLearningHeaderAnimation extends StatelessWidget {
  /// Children to be painted in the header
  final List<Widget> children;

  /// Integer value usually referring to the _macro of the list
  /// to control properly the animation and to differ each Card
  /// from each other
  final int id;
  const KPLearningHeaderAnimation(
      {Key? key, required this.children, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        duration: const Duration(milliseconds: CustomAnimations.ms400),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeOut,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation.drive(Tween(begin: 0, end: 1)),
            child: SlideTransition(
                position: animation.drive(Tween(
                    begin: const Offset(CustomAnimations.dxCardInfo, 0),
                    end: Offset.zero)),
                child: child),
          );
        },
        child: Card(
            key: ValueKey<int>(id),
            margin: const EdgeInsets.symmetric(vertical: Margins.margin16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(CustomRadius.radius8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: Margins.margin8),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Column(children: children),
              ),
            )));
  }
}
