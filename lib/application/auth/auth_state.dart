part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.loaded(User user) = AuthLoaded;
  // error = "" and shouldPop = false
  const factory AuthState.initial(String error, bool shouldPop) = AuthInitial;
}
