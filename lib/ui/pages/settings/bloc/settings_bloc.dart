import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/core/firebase/queries/back_ups.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsStateBackUpDateLoaded()) {
    on<SettingsLoadingBackUpDate>((event, emit) async {
      emit(SettingsStateBackUpDateLoading());
      final date = await BackUpRecords.instance.getLastUpdated(event.context);
      emit(SettingsStateBackUpDateLoaded(date: date));
    });
  }
}
