part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthStateLoading extends AuthState {}

class AuthStateLoggedOut extends AuthState {
  final String message;

  const AuthStateLoggedOut({required this.message});

  @override
  List<Object> get props => [message];
}

class AuthStateSuccessful extends AuthState {
  final User user;

  const AuthStateSuccessful({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthStateIdle extends AuthState {
  final String error;

  const AuthStateIdle({this.error = ""});

  @override
  List<Object> get props => [error];
}
