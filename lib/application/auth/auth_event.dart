part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthIdle extends AuthEvent {}

class AuthSubmitEmailProvider extends AuthEvent {
  final SignMode mode;
  final String email;
  final String password;

  const AuthSubmitEmailProvider(this.mode, this.email, this.password);

  @override
  List<Object> get props => [mode, email, password];
}

class AuthSubmitGoogleProvider extends AuthEvent {}

class CloseEmailProviderSession extends AuthEvent {}

class CloseGoogleProviderSession extends AuthEvent {}

class ChangePassword extends AuthEvent {
  final String oldPassword;
  final String newPassword;

  const ChangePassword(this.oldPassword, this.newPassword);

  @override
  List<Object> get props => [oldPassword, newPassword];
}

class RemoveAccount extends AuthEvent {
  final String password;

  const RemoveAccount(this.password);

  @override
  List<Object> get props => [password];
}
