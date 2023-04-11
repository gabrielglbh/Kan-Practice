part of 'backup_bloc.dart';

abstract class BackupEvent extends Equatable {
  const BackupEvent();

  @override
  List<Object> get props => [];
}

class BackupLoadingCreateBackUp extends BackupEvent {}

class BackupLoadingMergeBackUp extends BackupEvent {}

class BackupLoadingRemoveBackUp extends BackupEvent {}

class BackupGetVersion extends BackupEvent {
  final BuildContext context;
  final bool showNotes;

  const BackupGetVersion(this.context, {this.showNotes = false});

  @override
  List<Object> get props => [context, showNotes];
}
