import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/presentation/core/types/sign_in_mode.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/auth/i_auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

part 'auth_bloc.freezed.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(const AuthState.initial('', false)) {
    on<AuthSubmitEmailProvider>((event, emit) async {
      emit(const AuthState.loading());
      final user = await _authRepository.handleLogIn(
          event.mode, event.email, event.password);
      if (user != null) {
        emit(AuthState.loaded(user));
      } else {
        emit(const AuthState.initial("Error retrieving user", false));
      }
    });

    on<AuthSubmitGoogleProvider>((event, emit) async {
      emit(const AuthState.loading());
      final user = await _authRepository.handleGoogleLogIn();
      if (user != null) {
        emit(AuthState.loaded(user));
      } else {
        emit(const AuthState.initial("Error retrieving user", false));
      }
    });

    on<AuthIdle>((event, emit) {
      final user = _authRepository.getUser();
      if (user != null) {
        emit(AuthState.loaded(user));
      } else {
        emit(const AuthState.initial('', false));
      }
    });

    on<CloseEmailProviderSession>((event, emit) async {
      emit(const AuthState.loading());
      final error = await _authRepository.closeSession();
      if (error == 0) {
        emit(const AuthState.initial('', true));
      } else {
        final user = _authRepository.getUser();
        if (user != null) {
          emit(AuthState.loaded(user));
        } else {
          emit(
              AuthState.initial("login_bloc_close_session_failed".tr(), false));
        }
      }
    });

    on<CloseGoogleProviderSession>((event, emit) async {
      emit(const AuthState.loading());
      final error = await _authRepository.closeSession();
      if (error == 0) {
        emit(const AuthState.initial('', true));
      } else {
        final user = _authRepository.getUser();
        if (user != null) {
          emit(AuthState.loaded(user));
        } else {
          emit(
              AuthState.initial("login_bloc_close_session_failed".tr(), false));
        }
      }
    });

    on<RemoveAccount>((event, emit) async {
      emit(const AuthState.loading());
      final error = await _authRepository.deleteAccount(event.password);
      if (error == "") {
        emit(const AuthState.initial('', true));
      } else {
        final user = _authRepository.getUser();
        if (user != null) {
          emit(AuthState.loaded(user));
        } else {
          emit(AuthState.initial(
              "login_bloc_remove_account_failed".tr(), false));
        }
      }
    });

    on<ChangePassword>((event, emit) async {
      emit(const AuthState.loading());
      final error = await _authRepository.changePassword(
          event.oldPassword, event.newPassword);
      if (error == "") {
        final user = _authRepository.getUser();
        if (user != null) {
          emit(AuthState.loaded(user));
        } else {
          emit(AuthState.initial(error, false));
        }
      } else {
        emit(AuthState.initial(error, false));
      }
    });
  }
}
