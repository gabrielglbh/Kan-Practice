part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthStateLoading extends AuthState {}

class AuthStateSuccessful extends AuthState {
  final User user;

  const AuthStateSuccessful({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthStateIdle extends AuthState {
  final String error;
  final bool shouldPop;

  const AuthStateIdle({this.error = "", this.shouldPop = false});

  @override
  List<Object> get props => [error, shouldPop];
}
