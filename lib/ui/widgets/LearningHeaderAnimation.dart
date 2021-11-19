import 'package:flutter/material.dart';
import 'package:kanpractice/ui/theme/consts.dart';

class LearningHeaderAnimation extends StatelessWidget {
  /// Children to be painted in the header
  final List<Widget> children;
  /// Integer value usually referring to the _macro of the list
  /// to control properly the animation and to differ each Card
  /// from each other
  final int id;
  const LearningHeaderAnimation({required this.children, required this.id});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: CustomAnimations.ms400),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeOut,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation.drive(Tween(begin: 0, end: 1)),
          child: SlideTransition(
              child: child,
              position: animation.drive(
                Tween(begin: Offset(CustomAnimations.dxCardInfo, 0), end: Offset.zero)
              )
          ),
        );
      },
      child: Card(
        key: ValueKey<int>(id),
        margin: EdgeInsets.symmetric(vertical: Margins.margin16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CustomRadius.radius8),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: Margins.margin8),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Column(
              children: children
            ),
          ),
        )
      )
    );
  }
}
