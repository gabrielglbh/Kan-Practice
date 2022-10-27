import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/core/ui/kp_action_button.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class WritingButtonsAnimations extends StatelessWidget {
  /// Integer value usually referring to the _macro of the list
  /// to control properly the animation and to differ the _submit
  /// widget from another one
  final int id;

  ///Whether to trigger the slide animation on the submit button or not
  final bool triggerSlide;

  /// Whether to show the validation buttons or the submit one
  final bool trigger;

  /// Label to put on the submit button
  final String submitLabel;
  final Function(double) action;

  /// Action to be performed when submitting the current card
  final Function() onSubmit;
  const WritingButtonsAnimations(
      {Key? key,
      required this.trigger,
      required this.triggerSlide,
      required this.id,
      required this.action,
      required this.onSubmit,
      required this.submitLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: KPSizes.listStudyHeight * 1.6,
      child: AnimatedSwitcher(
          duration: const Duration(milliseconds: KPAnimations.ms300),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeOut,
          child: trigger ? _validation() : _submit()),
    );
  }

  TweenAnimationBuilder _animation(
      {int duration = 1, required Widget child, bool side = false}) {
    return TweenAnimationBuilder(
      tween: Tween<Offset>(
          begin: Offset(side ? KPAnimations.dxCardInfo : 0, side ? 0 : -0.3),
          end: Offset.zero),
      curve: Curves.easeOut,
      duration: Duration(
          milliseconds:
              side ? KPAnimations.ms400 : KPAnimations.ms200 * duration),
      builder: (context, offset, child) {
        return FractionalTranslation(
            translation: offset as Offset, child: child);
      },
      child: child,
    );
  }

  /// Depending on [triggerSlide], this button will slide from the right
  /// or it will come from the top
  Widget _submit() {
    return Container(
      key: ValueKey<int>(id),
      child: _animation(
          side: triggerSlide,
          child: KPActionButton(
              vertical: KPMargins.margin12,
              horizontal: 0,
              label: submitLabel,
              onTap: onSubmit)),
    );
  }

  /// This buttons will slide from the top one by one
  Widget _validation() {
    return GridView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.8,
      ),
      children: [
        _animation(
            duration: 1,
            child: KPActionButton(
              label: "wrong_button_label".tr(),
              horizontal: KPMargins.margin4,
              vertical: KPMargins.margin4,
              onTap: () async => await action(0),
              color: Colors.redAccent.shade700,
            )),
        _animation(
            duration: 2,
            child: KPActionButton(
              label: "mid_wrong_button_label".tr(),
              horizontal: KPMargins.margin4,
              vertical: KPMargins.margin4,
              onTap: () async => await action(0.20),
              color: Colors.red.shade500,
            )),
        _animation(
            duration: 3,
            child: KPActionButton(
              label: "mid_button_label".tr(),
              horizontal: KPMargins.margin4,
              vertical: KPMargins.margin4,
              onTap: () async => await action(0.40),
              color: Colors.orange.shade700,
            )),
        _animation(
            duration: 4,
            child: KPActionButton(
              label: "mid_good_button_label".tr(),
              horizontal: KPMargins.margin4,
              vertical: KPMargins.margin4,
              onTap: () async => await action(0.60),
              color: Colors.amber.shade500,
            )),
        _animation(
            duration: 5,
            child: KPActionButton(
              label: "mid_perfect_button_label".tr(),
              horizontal: KPMargins.margin4,
              vertical: KPMargins.margin4,
              onTap: () async => await action(0.80),
              color: Colors.lime.shade700,
            )),
        _animation(
            duration: 6,
            child: KPActionButton(
              label: "perfect_button_label".tr(),
              horizontal: KPMargins.margin4,
              vertical: KPMargins.margin4,
              onTap: () async => await action(1),
              color: Colors.green.shade700,
            ))
      ],
    );
  }
}
