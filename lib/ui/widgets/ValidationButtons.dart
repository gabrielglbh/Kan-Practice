import 'package:flutter/material.dart';
import 'package:kanpractice/ui/theme/consts.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: CustomSizes.listStudyHeight,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: CustomAnimations.ms300),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeOut,
        child: trigger ? _validation() : _submit()
      ),
    );
  }

  TweenAnimationBuilder _animation(int duration, {required Widget child, bool up = true}) {
    return TweenAnimationBuilder(
      tween: Tween<Offset>(begin: Offset(up ? 0.5 : -0.5, 0), end: Offset(0, 0)),
      curve: Curves.easeOut,
      duration: Duration(milliseconds: CustomAnimations.ms300 * duration),
      builder: (context, offset, child) {
        return FractionalTranslation(translation: offset as Offset, child: child);
      },
      child: child,
    );
  }

  Widget _submit() {
    return _animation(1, up: false, child: ActionButton(
      vertical: Margins.margin12,
      horizontal: Margins.margin4,
      label: submitLabel,
      onTap: onSubmit
    ));
  }

  Row _validation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 1,
          child: _animation(1, child: ActionButton(
            label: "wrong_button_label".tr(),
            horizontal: Margins.margin2,
            onTap: () async => await wrongAction(0),
            color: Colors.red[700]!,
          )),
        ),
        Expanded(
          flex: 1,
          child: _animation(2, child: ActionButton(
            label: "mid_wrong_button_label".tr(),
            horizontal: Margins.margin2,
            onTap: () async => await midWrongAction(0.33),
            color: Colors.yellow[800]!,
          )),
        ),
        Expanded(
          flex: 1,
          child: _animation(3, child: ActionButton(
            label: "mid_perfect_button_label".tr(),
            horizontal: Margins.margin2,
            onTap: () async => await midPerfectAction(0.66),
            color: Colors.green[300]!,
          ))
        ),
        Expanded(
          flex: 1,
          child: _animation(4, child: ActionButton(
            label: "perfect_button_label".tr(),
            horizontal: Margins.margin2,
            onTap: () async => await perfectAction(1),
            color: Colors.green[700]!,
          )),
        )
      ],
    );
  }
}
