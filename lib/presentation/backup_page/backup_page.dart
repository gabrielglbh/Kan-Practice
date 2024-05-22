import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/application/backup/backup_bloc.dart';
import 'package:kanpractice/application/snackbar/snackbar_bloc.dart';
import 'package:kanpractice/presentation/core/widgets/kp_alert_dialog.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/widgets/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class BackUpPage extends StatelessWidget {
  final String uid;
  const BackUpPage({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BackupBloc, BackupState>(
      listener: (context, state) {
        state.mapOrNull(error: (error) {
          context.read<SnackbarBloc>().add(SnackbarEventShow(error.message));
        }, loaded: (l) {
          context.read<SnackbarBloc>().add(SnackbarEventShow(l.message));
        });
      },
      builder: (bloc, state) {
        return state.maybeWhen(
          loading: () => KPScaffold(
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
          ),
          orElse: () => KPScaffold(
            appBarTitle: "backup_title".tr(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                      leading: const Icon(Icons.backup_rounded),
                      title: Text("backup_creation_tile".tr()),
                      onTap: () => _createDialogForCreatingBackUp(bloc)),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.cloud_download),
                    title: Text("backup_merge_tile".tr()),
                    onTap: () => _createDialogForMergingBackUp(bloc),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.delete),
                    title: Text("backup_removal_tile".tr(),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error)),
                    onTap: () => _createDialogForRemovingBackUp(bloc),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _createDialogForCreatingBackUp(BuildContext bloc) {
    showDialog(
        context: bloc,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) {
                return KPDialog(
                  title: Text("backup_creation_dialog_title".tr()),
                  content: Text("backup_creation_dialog_content".tr(),
                      style: Theme.of(context).textTheme.bodyLarge),
                  positiveButtonText: "backup_creation_dialog_positive".tr(),
                  onPositive: () =>
                      bloc.read<BackupBloc>().add(BackupLoadingCreateBackUp()),
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
                  style: Theme.of(context).textTheme.bodyLarge),
              positiveButtonText: "backup_merge_dialog_positive".tr(),
              onPositive: () =>
                  bloc.read<BackupBloc>().add(BackupLoadingMergeBackUp()),
            ));
  }

  _createDialogForRemovingBackUp(BuildContext bloc) {
    showDialog(
        context: bloc,
        builder: (context) => KPDialog(
              title: Text("backup_removal_dialog_title".tr()),
              content: Text("backup_removal_dialog_content".tr(),
                  style: Theme.of(context).textTheme.bodyLarge),
              positiveButtonText: "backup_removal_dialog_positive".tr(),
              onPositive: () =>
                  bloc.read<BackupBloc>().add(BackupLoadingRemoveBackUp()),
            ));
  }
}
