import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/widgets/kp_alert_dialog.dart';
import 'package:kanpractice/presentation/core/widgets/kp_text_form.dart';
import 'package:easy_localization/easy_localization.dart';

class KPCreateKanListDialog extends StatelessWidget {
  final Function(String)? onSubmit;
  KPCreateKanListDialog({Key? key, this.onSubmit}) : super(key: key);

  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  /// Returns, if needed, the name of the KanList created
  static Future<String?> show(BuildContext context,
      {Function(String)? onSubmit}) async {
    String? name;
    await showDialog(
            context: context,
            builder: (context) => KPCreateKanListDialog(onSubmit: onSubmit))
        .then((value) => name = value);
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return KPDialog(
      title: Text("word_lists_createDialogForAddingKanList_title".tr()),
      content: KPTextForm(
        header: "word_lists_createDialogForAddingKanList_header".tr(),
        maxLength: 32,
        controller: controller,
        action: TextInputAction.done,
        hint: "word_lists_createDialogForAddingKanList_hint".tr(),
        autofocus: true,
        onSubmitted: (name) {
          if (onSubmit != null) onSubmit!(name);
          Navigator.of(context).pop(name);
        },
        focusNode: focusNode,
        onEditingComplete: () => focusNode.unfocus(),
      ),

      /// Manage the state of the KPDialog from here to pass the name
      popDialog: onSubmit != null,
      positiveButtonText:
          "word_lists_createDialogForAddingKanList_positive".tr(),
      onPositive: () {
        if (onSubmit != null) {
          onSubmit!(controller.text);
        } else {
          Navigator.of(context).pop(controller.text);
        }
      },
    );
  }
}
