import 'package:flutter/material.dart';
import 'package:kanpractice/ui/theme/theme_consts.dart';
import 'package:kanpractice/ui/widgets/ActionButton.dart';
import 'package:easy_localization/easy_localization.dart';

class ValidationButtons extends StatelessWidget {
  final Function(double) wrongAction;
  final Function(double) midWrongAction;
  final Function(double) midPerfectAction;
  final Function(double) perfectAction;
  const ValidationButtons({
    required this.wrongAction, required this.midWrongAction,
    required this.midPerfectAction, required this.perfectAction
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: listStudyHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(flex: 1,
            child: ActionButton(
              label: "wrong_button_label".tr(),
              horizontal: 2,
              onTap: () async => await wrongAction(0),
              color: Colors.red[700]!,
            ),
          ),
          Expanded(flex: 1,
            child: ActionButton(
              label: "mid_wrong_button_label".tr(),
              horizontal: 2,
              onTap: () async => await midWrongAction(0.33),
              color: Colors.yellow[800]!,
            ),
          ),
          Expanded(flex: 1,
            child: ActionButton(
              label: "mid_perfect_button_label".tr(),
              horizontal: 2,
              onTap: () async => await midPerfectAction(0.66),
              color: Colors.green[300]!,
            ),
          ),
          Expanded(flex: 1,
            child: ActionButton(
              label: "perfect_button_label".tr(),
              horizontal: 2,
              onTap: () async => await perfectAction(1),
              color: Colors.green[700]!,
            ),
          )
        ],
      )
    );
  }
}
