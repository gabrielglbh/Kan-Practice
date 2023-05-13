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
  final bool showNotes;

  const BackupGetVersion({this.showNotes = false});

  @override
  List<Object> get props => [showNotes];
}
