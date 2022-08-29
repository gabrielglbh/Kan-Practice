import 'package:flutter/material.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/widgets/kp_action_button.dart';
import 'package:easy_localization/easy_localization.dart';

class KPValidationButtons extends StatelessWidget {
  /// Whether to show the validation buttons or the submit one
  final bool trigger;

  /// Label to put on the submit button
  final String submitLabel;

  /// Action to be performed when tapping the WRONG button:
  /// 0% score added to the kanji.
  final Function(double) wrongAction;

  /// Action to be performed when tapping the MID-WRONG button:
  /// 33% score added to the kanji.
  final Function(double) midWrongAction;

  /// Action to be performed when tapping the MID-PERFECT button:
  /// 66% score added to the kanji.
  final Function(double) midPerfectAction;

  /// Action to be performed when tapping the PERFECT button:
  /// 100% score added to the kanji.
  final Function(double) perfectAction;

  /// Action to be performed when submitting the current card
  final Function() onSubmit;
  const KPValidationButtons(
      {Key? key,
      required this.trigger,
      required this.wrongAction,
      required this.midWrongAction,
      required this.midPerfectAction,
      required this.perfectAction,
      required this.onSubmit,
      required this.submitLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: Margins.margin16),
        child: AnimatedSwitcher(
            duration: const Duration(milliseconds: CustomAnimations.ms300),
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
              side ? CustomAnimations.dxCardInfo : 0,
              side ? 0 : -0.3),
          end: Offset.zero),
      curve: Curves.easeOut,
      duration: Duration(
          milliseconds: side
              ? CustomAnimations.ms400
              : CustomAnimations.ms200 * duration),
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
          height: CustomSizes.customButtonHeight,
          child: KPActionButton(
              vertical: Margins.margin12,
              horizontal: Margins.margin8,
              label: submitLabel,
              onTap: onSubmit),
        ));
  }

  /// This buttons will slide from the top one by one
  GridView _validation() {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.9,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        _animation(
            duration: 1,
            child: KPActionButton(
              label: "wrong_button_label".tr(),
              horizontal: Margins.margin4,
              vertical: Margins.margin4,
              onTap: () async => await wrongAction(0),
              color: Colors.red[700]!,
            )),
        _animation(
            duration: 2,
            child: KPActionButton(
              label: "mid_wrong_button_label".tr(),
              horizontal: Margins.margin4,
              vertical: Margins.margin4,
              onTap: () async => await midWrongAction(0.33),
              color: Colors.yellow[800]!,
            )),
        _animation(
            duration: 3,
            child: KPActionButton(
              label: "mid_perfect_button_label".tr(),
              horizontal: Margins.margin4,
              vertical: Margins.margin4,
              onTap: () async => await midPerfectAction(0.66),
              color: Colors.green[300]!,
            )),
        _animation(
            duration: 4,
            child: KPActionButton(
              label: "perfect_button_label".tr(),
              horizontal: Margins.margin4,
              vertical: Margins.margin4,
              onTap: () async => await perfectAction(1),
              color: Colors.green[700]!,
            ))
      ],
    );
  }
}
