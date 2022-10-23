part of 'backup_bloc.dart';

class BackUpState extends Equatable {
  const BackUpState();

  @override
  List<Object?> get props => [];
}

class BackUpStateIdle extends BackUpState {}

class BackUpStateFailure extends BackUpState {
  final String message;

  const BackUpStateFailure({this.message = ""});

  @override
  List<Object> get props => [message];
}

class BackUpStateSuccess extends BackUpState {
  final String message;

  const BackUpStateSuccess({this.message = ""});

  @override
  List<Object> get props => [message];
}

class BackUpStateLoading extends BackUpState {}

class BackUpStateVersionRetrieved extends BackUpState {
  final String version;

  const BackUpStateVersionRetrieved(this.version);

  @override
  List<Object> get props => [version];
}
