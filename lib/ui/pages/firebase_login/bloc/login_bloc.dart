import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kanpractice/core/firebase/queries/authentication.dart';
import 'package:kanpractice/core/types/sign_in_mode.dart';
import 'package:easy_localization/easy_localization.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginStateIdle()) {
    on<LoginSubmitting>((event, emit) async {
      emit(LoginStateLoading());
      final error = await AuthRecords.instance
          .handleLogIn(event.mode, event.email, event.password);
      if (error == "") {
        final user = AuthRecords.instance.getUser();
        if (user != null) {
          emit(LoginStateSuccessful(user: user));
        } else {
          emit(LoginStateIdle(error: error));
        }
      } else {
        emit(LoginStateIdle(error: error));
      }
    });

    on<LoginIdle>((event, emit) {
      final user = AuthRecords.instance.getUser();
      if (user != null) {
        emit(LoginStateSuccessful(user: user));
      } else {
        emit(const LoginStateIdle());
      }
    });

    on<CloseSession>((event, emit) async {
      emit(LoginStateLoading());
      final error = await AuthRecords.instance.closeSession();
      if (error == 0) {
        emit(LoginStateLoggedOut(
            message: "login_bloc_close_session_successful".tr()));
      } else {
        final user = AuthRecords.instance.getUser();
        if (user != null) {
          emit(LoginStateSuccessful(user: user));
        } else {
          emit(LoginStateIdle(error: "login_bloc_close_session_failed".tr()));
        }
      }
    });

    on<RemoveAccount>((event, emit) async {
      emit(LoginStateLoading());
      final error = await AuthRecords.instance.deleteAccount(event.password);
      if (error == "") {
        emit(LoginStateLoggedOut(
            message: "login_bloc_remove_account_successful".tr()));
      } else {
        final user = AuthRecords.instance.getUser();
        if (user != null) {
          emit(LoginStateSuccessful(user: user));
        } else {
          emit(LoginStateIdle(error: "login_bloc_remove_account_failed".tr()));
        }
      }
    });

    on<ChangePassword>((event, emit) async {
      emit(LoginStateLoading());
      final error = await AuthRecords.instance
          .changePassword(event.oldPassword, event.newPassword);
      if (error == "") {
        final user = AuthRecords.instance.getUser();
        if (user != null) {
          emit(LoginStateSuccessful(user: user));
        } else {
          emit(LoginStateIdle(error: error));
        }
      } else {
        emit(LoginStateIdle(error: error));
      }
    });
  }
}
