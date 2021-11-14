part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginStateLoading extends LoginState {}

class LoginStateLoggedOut extends LoginState {
  final String message;

  const LoginStateLoggedOut({required this.message});

  @override
  List<Object> get props => [message];
}

class LoginStateSuccessful extends LoginState {
  final User user;

  const LoginStateSuccessful({required this.user});

  @override
  List<Object> get props => [user];
}

class LoginStateIdle extends LoginState {
  final String error;

  const LoginStateIdle({this.error = ""});

  @override
  List<Object> get props => [error];
}