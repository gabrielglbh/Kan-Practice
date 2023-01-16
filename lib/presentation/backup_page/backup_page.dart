import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/application/backup/backup_bloc.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/widgets/kp_alert_dialog.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/widgets/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';

class BackUpPage extends StatelessWidget {
  final String uid;
  const BackUpPage({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BackUpBloc, BackUpState>(
      listener: (context, state) {
        if (state is BackUpStateFailure) {
          Utils.getSnackBar(context, state.message);
        }
        if (state is BackUpStateSuccess) {
          Utils.getSnackBar(context, state.message);
          Navigator.of(context).pop(); // Go to manage account, pop
          Navigator.of(context).pop(); // Go to settings, pop
        }
      },
      builder: (context, state) {
        if (state is BackUpStateLoading) {
          return KPScaffold(
            appBarTitle: "backup_title".tr(),
            onWillPop: () async => false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const KPProgressIndicator(),
                const SizedBox(height: KPMargins.margin16),
                Text('can_take_a_while_loading'.tr()),
              ],
            ),
          );
        } else {
          return KPScaffold(
            appBarTitle: "backup_title".tr(),
            child: SingleChildScrollView(
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
                            color: KPColors.getSecondaryColor(context))),
                    onTap: () => _createDialogForRemovingBackUp(context),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  _createDialogForCreatingBackUp(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) {
                return KPDialog(
                  title: Text("backup_creation_dialog_title".tr()),
                  content: Text("backup_creation_dialog_content".tr(),
                      style: Theme.of(context).textTheme.bodyText1),
                  positiveButtonText: "backup_creation_dialog_positive".tr(),
                  onPositive: () =>
                      getIt<BackUpBloc>().add(BackUpLoadingCreateBackUp()),
                );
              },
            ));
  }

  _createDialogForMergingBackUp(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => KPDialog(
              title: Text("backup_merge_dialog_title".tr()),
              content: Text("backup_merge_dialog_content".tr(),
                  style: Theme.of(context).textTheme.bodyText1),
              positiveButtonText: "backup_merge_dialog_positive".tr(),
              onPositive: () =>
                  getIt<BackUpBloc>().add(BackUpLoadingMergeBackUp()),
            ));
  }

  _createDialogForRemovingBackUp(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => KPDialog(
              title: Text("backup_removal_dialog_title".tr()),
              content: Text("backup_removal_dialog_content".tr(),
                  style: Theme.of(context).textTheme.bodyText1),
              positiveButtonText: "backup_removal_dialog_positive".tr(),
              onPositive: () =>
                  getIt<BackUpBloc>().add(BackUpLoadingRemoveBackUp()),
            ));
  }
}
