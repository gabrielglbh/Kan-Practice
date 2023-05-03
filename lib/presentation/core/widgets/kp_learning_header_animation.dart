import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class KPLearningHeaderAnimation extends StatelessWidget {
  /// Children to be painted in the header
  final Widget child;

  /// Integer value usually referring to the _macro of the list
  /// to control properly the animation and to differ each Card
  /// from each other
  final int id;
  const KPLearningHeaderAnimation({
    Key? key,
    required this.child,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        duration: const Duration(milliseconds: KPAnimations.ms400),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeOut,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation.drive(Tween(begin: 0, end: 1)),
            child: SlideTransition(
                position: animation.drive(Tween(
                    begin: const Offset(KPAnimations.dxCardInfo, 0),
                    end: Offset.zero)),
                child: child),
          );
        },
        child: Card(
            key: ValueKey<int>(id),
            margin: const EdgeInsets.symmetric(vertical: KPMargins.margin16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(KPRadius.radius8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(KPMargins.margin8),
              child: child,
            )));
  }
}
