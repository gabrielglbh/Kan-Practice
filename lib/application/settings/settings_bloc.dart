import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/infrastructure/backup/backup_repository_impl.dart';
import 'package:kanpractice/injection.dart';

part 'settings_event.dart';
part 'settings_state.dart';

@lazySingleton
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsStateBackUpDateLoaded()) {
    on<SettingsIdle>((_, __) {});

    on<SettingsLoadingBackUpDate>((event, emit) async {
      emit(SettingsStateBackUpDateLoading());
      final date =
          await getIt<BackupRepositoryImpl>().getLastUpdated(event.context);
      emit(SettingsStateBackUpDateLoaded(date: date));
    });
  }
}
