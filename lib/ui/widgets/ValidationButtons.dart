import 'package:flutter/material.dart';
import 'package:kanpractice/ui/theme/theme_consts.dart';
import 'package:kanpractice/ui/widgets/ActionButton.dart';
import 'package:easy_localization/easy_localization.dart';

class ValidationButtons extends StatelessWidget {
  final bool trigger;
  final String submitLabel;
  final Function(double) wrongAction;
  final Function(double) midWrongAction;
  final Function(double) midPerfectAction;
  final Function(double) perfectAction;
  final Function() onSubmit;
  const ValidationButtons({
    required this.trigger,
    required this.wrongAction, required this.midWrongAction,
    required this.midPerfectAction, required this.perfectAction,
    required this.onSubmit, required this.submitLabel
  });

  final int animationDuration = 300;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: CustomSizes.listStudyHeight,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: animationDuration),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeOut,
        child: trigger ? _validation() : _submit()
      )
    );
  }

  TweenAnimationBuilder _animation(int duration, {required Widget child, bool up = true}) {
    return TweenAnimationBuilder(
      tween: Tween<Offset>(begin: Offset(0, up ? 0.3 : -0.3), end: Offset(0, 0)),
      curve: Curves.easeOut,
      duration: Duration(milliseconds: animationDuration * duration),
      builder: (context, offset, child) {
        return FractionalTranslation(translation: offset as Offset, child: child);
      },
      child: child,
    );
  }

  Widget _submit() {
    return _animation(1, up: false, child: ActionButton(
      vertical: 12,
      horizontal: 4,
      label: submitLabel,
      onTap: onSubmit
    ));
  }

  Row _validation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _animation(1, child: Expanded(flex: 1,
          child: ActionButton(
            label: "wrong_button_label".tr(),
            horizontal: 2,
            onTap: () async => await wrongAction(0),
            color: Colors.red[700]!,
          ),
        )),
        _animation(2, child: Expanded(flex: 1,
          child: ActionButton(
            label: "mid_wrong_button_label".tr(),
            horizontal: 2,
            onTap: () async => await midWrongAction(0.33),
            color: Colors.yellow[800]!,
          ),
        )),
        _animation(3, child: Expanded(flex: 1,
          child: ActionButton(
            label: "mid_perfect_button_label".tr(),
            horizontal: 2,
            onTap: () async => await midPerfectAction(0.66),
            color: Colors.green[300]!,
          ),
        )),
        _animation(4, child: Expanded(flex: 1,
          child: ActionButton(
            label: "perfect_button_label".tr(),
            horizontal: 2,
            onTap: () async => await perfectAction(1),
            color: Colors.green[700]!,
          ),
        ))
      ],
    );
  }
}
