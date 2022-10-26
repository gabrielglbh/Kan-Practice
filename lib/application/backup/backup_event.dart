part of 'backup_bloc.dart';

abstract class BackUpEvent extends Equatable {
  const BackUpEvent();

  @override
  List<Object> get props => [];
}

class BackUpLoadingCreateBackUp extends BackUpEvent {}

class BackUpLoadingMergeBackUp extends BackUpEvent {}

class BackUpLoadingRemoveBackUp extends BackUpEvent {}

class BackUpGetVersion extends BackUpEvent {
  final BuildContext context;
  final bool showNotes;

  const BackUpGetVersion(this.context, {this.showNotes = false});

  @override
  List<Object> get props => [context, showNotes];
}
