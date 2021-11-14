part of 'backup_bloc.dart';

class BackUpState extends Equatable {
  const BackUpState();

  @override
  List<Object?> get props => [];
}

class BackUpStateLoaded extends BackUpState {
  final String message;

  const BackUpStateLoaded({this.message = ""});

  @override
  List<Object> get props => [message];
}

class BackUpStateLoading extends BackUpState {}