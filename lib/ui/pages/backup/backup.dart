import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/ui/pages/backup/bloc/backup_bloc.dart';
import 'package:kanpractice/ui/theme/theme_consts.dart';
import 'package:kanpractice/ui/widgets/CustomAlertDialog.dart';
import 'package:kanpractice/ui/widgets/ProgressIndicator.dart';
import 'package:easy_localization/easy_localization.dart';

class BackUpPage extends StatefulWidget {
  final String uid;
  const BackUpPage({required this.uid});

  @override
  _BackUpPageState createState() => _BackUpPageState();
}

class _BackUpPageState extends State<BackUpPage> {
  BackUpBloc _bloc = BackUpBloc();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: appBarHeight,
          title: Text("backup_title".tr()),
        ),
        body: BlocProvider(
          create: (_) => _bloc..add(BackUpIdle()),
          child: BlocBuilder<BackUpBloc, BackUpState>(
            builder: (context, state) {
              if (state is BackUpStateLoading) {
                return CustomProgressIndicator();
              } else if (state is BackUpStateLoaded) {
                return ListView(
                  children: [
                    ListTile(
                      leading: Icon(Icons.backup_rounded),
                      title: Text("backup_creation_tile".tr()),
                      onTap: () => _createDialogForCreatingBackUp()
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.cloud_download),
                      title: Text("backup_merge_tile".tr()),
                      onTap: () => _createDialogForMergingBackUp(),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.delete),
                      title: Text("backup_removal_tile".tr()),
                      onTap: () => _createDialogForRemovingBackUp(),
                    ),
                    Divider(),
                    Visibility(
                      visible: state.message != "",
                      child: ListTile(
                        leading: Icon(Icons.info_rounded, color: secondaryColor),
                        title: Text(state.message)
                      ),
                    )
                  ],
                );
              } else return Container();
            },
          ),
        )
      ),
    );
  }

  _createDialogForCreatingBackUp() {
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

  _createDialogForMergingBackUp() {
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

  _createDialogForRemovingBackUp() {
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
