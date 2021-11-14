import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/ui/pages/backup/bloc/backup_bloc.dart';
import 'package:kanpractice/ui/theme/theme_consts.dart';
import 'package:kanpractice/ui/widgets/CustomAlertDialog.dart';
import 'package:kanpractice/ui/widgets/ProgressIndicator.dart';

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
          title: Text("Back Ups"),
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
                      title: Text("Create Back Up"),
                      onTap: () => _createDialogForCreatingBackUp()
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.cloud_download),
                      title: Text("Merge Back Up"),
                      onTap: () => _createDialogForMergingBackUp(),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.delete),
                      title: Text("Remove Back Up"),
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
        title: Text("Creating Back Up"),
        content: Text("The back up will be created in the cloud. The current data in "
            "your device will be saved replacing the current back up data. Tests will"
            "not be saved."
            "Do you want to proceed?"),
        positiveButtonText: "Create",
        onPositive: () => _bloc..add(BackUpLoadingCreateBackUp()),
      )
    );
  }

  _createDialogForMergingBackUp() {
    showDialog(
      context: context,
      builder: (context) => CustomDialog(
        title: Text("Merging Back Up"),
        content: Text("The back up data will be installed in your device merging it "
            "with the current data you have. Do you want to proceed?"),
        positiveButtonText: "Merge",
        onPositive: () => _bloc..add(BackUpLoadingMergeBackUp()),
      )
    );
  }

  _createDialogForRemovingBackUp() {
    showDialog(
      context: context,
      builder: (context) => CustomDialog(
        title: Text("Removing Back Up"),
        content: Text("The back up data will be completely removed from the server "
            "and it will be not available anymore. Do you want to proceed?"),
        positiveButtonText: "Remove",
        onPositive: () => _bloc..add(BackUpLoadingRemoveBackUp()),
      )
    );
  }
}
