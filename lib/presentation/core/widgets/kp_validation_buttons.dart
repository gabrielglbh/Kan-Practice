import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/core/widgets/kp_action_button.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class KPValidationButtons extends StatelessWidget {
  /// Whether to show the validation buttons or the submit one
  final bool trigger;

  /// Label to put on the submit button
  final String submitLabel;
  final Function(double) action;

  /// Action to be performed when submitting the current card
  final Function() onSubmit;
  const KPValidationButtons({
    super.key,
    required this.trigger,
    required this.action,
    required this.onSubmit,
    required this.submitLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 64, bottom: KPMargins.margin16),
        child: AnimatedSwitcher(
            duration: const Duration(milliseconds: KPAnimations.ms300),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeOut,
            child: trigger ? _validation() : _submit()),
      ),
    );
  }

  TweenAnimationBuilder _animation(
      {int duration = 1, required Widget child, bool side = false}) {
    return TweenAnimationBuilder(
      tween: Tween<Offset>(
          begin: Offset(

              /// For side ways animation --> same dx as LearningHeaderAnimation
              side ? KPAnimations.dxCardInfo : 0,
              side ? 0 : -0.3),
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

  /// This button will slide in as the info card
  Widget _submit() {
    return _animation(
        side: true,
        child: SizedBox(
          height: KPSizes.customButtonHeight,
          child: KPActionButton(
              vertical: KPMargins.margin12,
              horizontal: KPMargins.margin8,
              label: submitLabel,
              onTap: onSubmit),
        ));
  }

  /// This buttons will slide from the top one by one
  GridView _validation() {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.5,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        _animation(
            duration: 1,
            child: KPActionButton(
              label: "wrong_button_label".tr(),
              horizontal: KPMargins.margin4,
              vertical: KPMargins.margin4,
              onTap: () async => await action(0),
              color: KPColors.darkRed,
              textColor: Colors.white,
            )),
        _animation(
            duration: 2,
            child: KPActionButton(
              label: "mid_wrong_button_label".tr(),
              horizontal: KPMargins.margin4,
              vertical: KPMargins.margin4,
              onTap: () async => await action(0.20),
              color: KPColors.midRed,
              textColor: Colors.white,
            )),
        _animation(
            duration: 3,
            child: KPActionButton(
              label: "mid_button_label".tr(),
              horizontal: KPMargins.margin4,
              vertical: KPMargins.margin4,
              onTap: () async => await action(0.40),
              color: KPColors.darkOrange,
              textColor: Colors.white,
            )),
        _animation(
            duration: 4,
            child: KPActionButton(
              label: "mid_good_button_label".tr(),
              horizontal: KPMargins.margin4,
              vertical: KPMargins.margin4,
              onTap: () async => await action(0.60),
              color: KPColors.darkMidAmber,
              textColor: Colors.white,
            )),
        _animation(
            duration: 5,
            child: KPActionButton(
              label: "mid_perfect_button_label".tr(),
              horizontal: KPMargins.margin4,
              vertical: KPMargins.margin4,
              onTap: () async => await action(0.80),
              color: KPColors.darkOlive,
              textColor: Colors.white,
            )),
        _animation(
            duration: 6,
            child: KPActionButton(
              label: "perfect_button_label".tr(),
              horizontal: KPMargins.margin4,
              vertical: KPMargins.margin4,
              onTap: () async => await action(1),
              color: KPColors.darkGreen,
              textColor: Colors.white,
            ))
      ],
    );
  }
}
