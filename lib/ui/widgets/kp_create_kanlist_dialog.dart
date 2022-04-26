import 'package:flutter/material.dart';
import 'package:kanpractice/ui/widgets/kp_alert_dialog.dart';
import 'package:kanpractice/ui/widgets/kp_text_form.dart';
import 'package:easy_localization/easy_localization.dart';

class KPCreateKanListDialog extends StatelessWidget {
  final Function(String) onSubmit;
  KPCreateKanListDialog({Key? key, required this.onSubmit}) : super(key: key);

  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  static showCreateKanListDialog(BuildContext context,
      {required Function(String) onSubmit}) {
    showDialog(
      context: context,
      builder: (context) => KPCreateKanListDialog(onSubmit: onSubmit)
    );
  }

  @override
  Widget build(BuildContext context) {
    return KPDialog(
      title: Text("kanji_lists_createDialogForAddingKanList_title".tr()),
      content: KPTextForm(
        header: "kanji_lists_createDialogForAddingKanList_header".tr(),
        maxLength: 32,
        controller: controller,
        action: TextInputAction.done,
        hint: "kanji_lists_createDialogForAddingKanList_hint".tr(),
        autofocus: true,
        onSubmitted: (name) {
          onSubmit(name);
          Navigator.of(context).pop();
        },
        focusNode: focusNode,
        onEditingComplete: () => focusNode.unfocus(),
      ),
      positiveButtonText: "kanji_lists_createDialogForAddingKanList_positive".tr(),
      onPositive: () => onSubmit(controller.text),
    );
  }
}
