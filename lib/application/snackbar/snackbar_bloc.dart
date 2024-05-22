import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'snackbar_event.dart';
part 'snackbar_state.dart';

part 'snackbar_bloc.freezed.dart';

@lazySingleton
class SnackbarBloc extends Bloc<SnackbarEvent, SnackbarState> {
  SnackbarBloc() : super(const SnackbarState.hide()) {
    on<SnackbarEventShow>((event, emit) async {
      if (state is SnackbarShown) {
        emit(const SnackbarState.hide());
      }

      emit(SnackbarState.show(event.message));
      await Future.delayed(const Duration(seconds: 3));
      emit(const SnackbarState.hide());
    });
  }
}
