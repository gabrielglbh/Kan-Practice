import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/ui/pages/backup/bloc/backup_bloc.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/CustomAlertDialog.dart';
import 'package:kanpractice/ui/widgets/ProgressIndicator.dart';
import 'package:easy_localization/easy_localization.dart';

class BackUpPage extends StatelessWidget {
  final BackUpBloc _bloc = BackUpBloc();
  final String uid;
  BackUpPage({required this.uid});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: CustomSizes.appBarHeight,
        title: FittedBox(fit: BoxFit.fitWidth, child: Text("backup_title".tr())),
      ),
      body: BlocProvider(
        create: (_) => _bloc..add(BackUpIdle()),
        child: BlocBuilder<BackUpBloc, BackUpState>(
          builder: (context, state) {
            if (state is BackUpStateLoading) {
              return CustomProgressIndicator();
            } else if (state is BackUpStateLoaded) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.backup_rounded),
                      title: Text("backup_creation_tile".tr()),
                      onTap: () => _createDialogForCreatingBackUp(context)
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.cloud_download),
                      title: Text("backup_merge_tile".tr()),
                      onTap: () => _createDialogForMergingBackUp(context),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.delete),
                      title: Text("backup_removal_tile".tr(),
                          style: TextStyle(color: CustomColors.getSecondaryColor(context))),
                      onTap: () => _createDialogForRemovingBackUp(context),
                    ),
                    Divider(),
                    Visibility(
                      visible: state.message != "",
                      child: ListTile(
                        leading: Icon(Icons.info_rounded, color: CustomColors.getSecondaryColor(context)),
                        title: Text(state.message)
                      ),
                    )
                  ],
                ),
              );
            } else return Container();
          },
        ),
      )
    );
  }

  _createDialogForCreatingBackUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CustomDialog(
        title: Text("backup_creation_dialog_title".tr()),
        content: Text("backup_creation_dialog_content".tr()),
        positiveButtonText: "backup_creation_dialog_positive".tr(),
        onPositive: () => _bloc..add(BackUpLoadingCreateBackUp()),
      )
    );
  }

  _createDialogForMergingBackUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CustomDialog(
        title: Text("backup_merge_dialog_title".tr()),
        content: Text("backup_merge_dialog_content".tr()),
        positiveButtonText: "backup_merge_dialog_positive".tr(),
        onPositive: () => _bloc..add(BackUpLoadingMergeBackUp()),
      )
    );
  }

  _createDialogForRemovingBackUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CustomDialog(
        title: Text("backup_removal_dialog_title".tr()),
        content: Text("backup_removal_dialog_content".tr()),
        positiveButtonText: "backup_removal_dialog_positive".tr(),
        onPositive: () => _bloc..add(BackUpLoadingRemoveBackUp()),
      )
    );
  }
}
