import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class KPDialog extends StatelessWidget {
  /// Title of the dialog
  final Widget title;

  /// Content of the dialog
  final Widget content;

  /// Text to display within the positive button of the dialog
  final String positiveButtonText;

  /// Whether to show the negative button of the dialog or not
  final bool negativeButton;

  /// Whether to pop the dialog when tapping the positive button or not
  final bool popDialog;

  /// Action to perform when tapping the positive button
  final Function onPositive;
  const KPDialog(
      {super.key,
      required this.title,
      required this.content,
      this.negativeButton = true,
      required this.positiveButtonText,
      required this.onPositive,
      this.popDialog = true});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(KPRadius.radius16))),
      content: Wrap(children: [content]),
      actions: [
        Visibility(
          visible: negativeButton,
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.grey),
                shape: WidgetStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(KPRadius.radius8))),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: Text("back_button_label".tr(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white))),
        ),
        ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(Colors.green),
              shape: WidgetStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(KPRadius.radius8))),
            ),
            onPressed: () async {
              if (popDialog) Navigator.of(context).pop();
              await onPositive();
            },
            child: Text(positiveButtonText,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white))),
      ],
    );
  }
}
