import 'package:flutter/material.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/ui/widgets/kp_button.dart';

class KPEmptyList extends StatelessWidget {
  /// Message to show when a list is empty on the center of the screen
  final String message;

  /// Action to perform when the list is empty
  final Function() onRefresh;
  final bool showTryButton;
  const KPEmptyList(
      {Key? key,
      required this.message,
      required this.onRefresh,
      this.showTryButton = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Margins.margin16),
          child: Text(message, textAlign: TextAlign.center),
        ),
        Container(),
        Visibility(
          visible: showTryButton,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 5),
            child: KPButton(
                title2: "load_failed_try_again_button_label".tr(),
                color: CustomColors.secondaryColor,
                onTap: onRefresh),
          ),
        )
      ],
    );
  }
}
