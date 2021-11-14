part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginIdle extends LoginEvent {}

class LoginSubmitting extends LoginEvent {
  final SignMode mode;
  final String email;
  final String password;

  const LoginSubmitting(this.mode, this.email, this.password);

  @override
  List<Object> get props => [mode, email, password];
}

class CloseSession extends LoginEvent {}

class ChangePassword extends LoginEvent {
  final String oldPassword;
  final String newPassword;

  const ChangePassword(this.oldPassword, this.newPassword);

  @override
  List<Object> get props => [oldPassword, newPassword];
}

class RemoveAccount extends LoginEvent {
  final String password;

  const RemoveAccount(this.password);

  @override
  List<Object> get props => [password];
}