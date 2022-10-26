import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/presentation/core/types/sign_in_mode.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/auth/i_auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(const AuthStateIdle()) {
    on<AuthSubmitting>((event, emit) async {
      emit(AuthStateLoading());
      final error = await _authRepository.handleLogIn(
          event.mode, event.email, event.password);
      if (error == "") {
        final user = _authRepository.getUser();
        if (user != null) {
          emit(AuthStateSuccessful(user: user));
        } else {
          emit(AuthStateIdle(error: error));
        }
      } else {
        emit(AuthStateIdle(error: error));
      }
    });

    on<AuthIdle>((event, emit) {
      final user = _authRepository.getUser();
      if (user != null) {
        emit(AuthStateSuccessful(user: user));
      } else {
        emit(const AuthStateIdle());
      }
    });

    on<CloseSession>((event, emit) async {
      emit(AuthStateLoading());
      final error = await _authRepository.closeSession();
      if (error == 0) {
        emit(const AuthStateIdle(shouldPop: true));
      } else {
        final user = _authRepository.getUser();
        if (user != null) {
          emit(AuthStateSuccessful(user: user));
        } else {
          emit(AuthStateIdle(error: "login_bloc_close_session_failed".tr()));
        }
      }
    });

    on<RemoveAccount>((event, emit) async {
      emit(AuthStateLoading());
      final error = await _authRepository.deleteAccount(event.password);
      if (error == "") {
        emit(const AuthStateIdle(shouldPop: true));
      } else {
        final user = _authRepository.getUser();
        if (user != null) {
          emit(AuthStateSuccessful(user: user));
        } else {
          emit(AuthStateIdle(error: "login_bloc_remove_account_failed".tr()));
        }
      }
    });

    on<ChangePassword>((event, emit) async {
      emit(AuthStateLoading());
      final error = await _authRepository.changePassword(
          event.oldPassword, event.newPassword);
      if (error == "") {
        final user = _authRepository.getUser();
        if (user != null) {
          emit(AuthStateSuccessful(user: user));
        } else {
          emit(AuthStateIdle(error: error));
        }
      } else {
        emit(AuthStateIdle(error: error));
      }
    });
  }
}
