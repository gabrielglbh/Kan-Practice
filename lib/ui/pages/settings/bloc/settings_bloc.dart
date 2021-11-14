import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/firebase/queries/back_ups.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsStateBackUpDateLoaded());

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is SettingsLoadingBackUpDate) yield* _mapLoadedState();
  }

  Stream<SettingsState> _mapLoadedState() async* {
    yield SettingsStateBackUpDateLoading();
    final date = await BackUpRecords.instance.getLastUpdated();
    yield SettingsStateBackUpDateLoaded(date: date);
  }
}