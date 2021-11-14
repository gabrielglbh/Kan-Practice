part of 'backup_bloc.dart';

abstract class BackUpEvent extends Equatable {
  const BackUpEvent();

  @override
  List<Object> get props => [];
}

class BackUpLoadingCreateBackUp extends BackUpEvent {}

class BackUpLoadingMergeBackUp extends BackUpEvent {}

class BackUpLoadingRemoveBackUp extends BackUpEvent {}

class BackUpIdle extends BackUpEvent {}