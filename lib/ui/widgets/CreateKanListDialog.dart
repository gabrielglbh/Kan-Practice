import 'package:flutter/material.dart';
import 'package:kanpractice/ui/widgets/CustomAlertDialog.dart';
import 'package:kanpractice/ui/widgets/CustomTextForm.dart';
import 'package:easy_localization/easy_localization.dart';

class CreateKanListDialog extends StatelessWidget {
  final Function(String) onSubmit;
  CreateKanListDialog({required this.onSubmit});

  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  static showCreateKanListDialog(BuildContext context,
      {required Function(String) onSubmit}) {
    showDialog(
      context: context,
      builder: (context) => CreateKanListDialog(onSubmit: onSubmit)
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: Text("kanji_lists_createDialogForAddingKanList_title".tr()),
      content: CustomTextForm(
        header: "kanji_lists_createDialogForAddingKanList_header".tr(),
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
