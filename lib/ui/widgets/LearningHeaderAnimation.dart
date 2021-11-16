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
      child: Container(
        key: ValueKey<int>(id),
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: Margins.margin16),
        padding: EdgeInsets.symmetric(vertical: Margins.margin8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(CustomRadius.radius8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset(0, 2), blurRadius: CustomRadius.radius4)
          ],
        ),
        child: Column(
          children: children
        ),
      )
    );
  }
}
