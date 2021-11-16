import 'package:flutter/material.dart';
import 'package:kanpractice/ui/theme/consts.dart';

class LearningHeaderAnimation extends StatelessWidget {
  final List<Widget> children;
  final int id;
  const LearningHeaderAnimation({required this.children, required this.id});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: CustomAnimations.ms300),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation.drive(Tween(begin: 0, end: 1)),
          child: SlideTransition(
              child: child,
              position: animation.drive(Tween(begin: Offset(2, 0), end: Offset.zero))
          ),
        );
      },
      child: Column(
        key: ValueKey<int>(id),
        children: children
      )
    );
  }
}
