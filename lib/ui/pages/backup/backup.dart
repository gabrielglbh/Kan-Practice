import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/ui/pages/backup/bloc/backup_bloc.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/widgets/kp_alert_dialog.dart';
import 'package:kanpractice/ui/widgets/kp_progress_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/ui/widgets/kp_scaffold.dart';

class BackUpPage extends StatelessWidget {
  final String uid;
  const BackUpPage({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KPScaffold(
        appBarTitle: "backup_title".tr(),
        child: BlocProvider<BackUpBloc>(
          create: (_) => BackUpBloc()..add(BackUpIdle()),
          child: BlocBuilder<BackUpBloc, BackUpState>(
            builder: (context, state) {
              if (state is BackUpStateLoading) {
                return const KPProgressIndicator();
              } else if (state is BackUpStateLoaded) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ListTile(
                          leading: const Icon(Icons.backup_rounded),
                          title: Text("backup_creation_tile".tr()),
                          onTap: () => _createDialogForCreatingBackUp(context)),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.cloud_download),
                        title: Text("backup_merge_tile".tr()),
                        onTap: () => _createDialogForMergingBackUp(context),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.delete),
                        title: Text("backup_removal_tile".tr(),
                            style: TextStyle(
                                color:
                                    CustomColors.getSecondaryColor(context))),
                        onTap: () => _createDialogForRemovingBackUp(context),
                      ),
                      const Divider(),
                      Visibility(
                        visible: state.message != "",
                        child: ListTile(
                            leading: Icon(Icons.info_rounded,
                                color: CustomColors.getSecondaryColor(context)),
                            title: Text(state.message)),
                      )
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ));
  }

  _createDialogForCreatingBackUp(BuildContext bloc) {
    bool _backUpTests = true;
    showDialog(
        context: bloc,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) {
                return KPDialog(
                  title: Text("backup_creation_dialog_title".tr()),
                  content: Column(
                    children: [
                      Text("backup_creation_dialog_content".tr(),
                          style: Theme.of(context).textTheme.bodyText1),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              child: Text("backup_creation_dialog_tests".tr(),
                                  style:
                                      Theme.of(context).textTheme.bodyText1)),
                          Switch(
                              value: _backUpTests,
                              onChanged: (val) =>
                                  setState(() => _backUpTests = !_backUpTests))
                        ],
                      )
                    ],
                  ),
                  positiveButtonText: "backup_creation_dialog_positive".tr(),
                  onPositive: () => BlocProvider.of<BackUpBloc>(bloc).add(
                      BackUpLoadingCreateBackUp(backUpTests: _backUpTests)),
                );
              },
            ));
  }

  _createDialogForMergingBackUp(BuildContext bloc) {
    showDialog(
        context: bloc,
        builder: (context) => KPDialog(
              title: Text("backup_merge_dialog_title".tr()),
              content: Text("backup_merge_dialog_content".tr(),
                  style: Theme.of(context).textTheme.bodyText1),
              positiveButtonText: "backup_merge_dialog_positive".tr(),
              onPositive: () => BlocProvider.of<BackUpBloc>(bloc)
                  .add(BackUpLoadingMergeBackUp()),
            ));
  }

  _createDialogForRemovingBackUp(BuildContext bloc) {
    showDialog(
        context: bloc,
        builder: (context) => KPDialog(
              title: Text("backup_removal_dialog_title".tr()),
              content: Text("backup_removal_dialog_content".tr(),
                  style: Theme.of(context).textTheme.bodyText1),
              positiveButtonText: "backup_removal_dialog_positive".tr(),
              onPositive: () => BlocProvider.of<BackUpBloc>(bloc)
                  .add(BackUpLoadingRemoveBackUp()),
            ));
  }
}
