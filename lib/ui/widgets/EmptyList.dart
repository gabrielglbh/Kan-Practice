import 'package:flutter/material.dart';
import 'package:kanpractice/ui/theme/theme_consts.dart';
import 'package:kanpractice/ui/widgets/ActionButton.dart';
import 'package:easy_localization/easy_localization.dart';

class EmptyList extends StatelessWidget {
  /// Message to show when a list is empty on the center of the screen
  final String message;
  /// Action to perform when the list is empty
  final Function() onRefresh;
  const EmptyList({required this.message, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          ActionButton(
            label: "load_failed_try_again_button_label".tr(),
            color: CustomColors.secondarySubtleColor,
            onTap: onRefresh
          )
        ],
      ),
    );
  }
}
