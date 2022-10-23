import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/backup/i_backup_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

@lazySingleton
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final IBackupRepository _backupRepository;

  SettingsBloc(this._backupRepository)
      : super(const SettingsStateBackUpDateLoaded()) {
    on<SettingsIdle>((_, __) {});

    on<SettingsLoadingBackUpDate>((event, emit) async {
      emit(SettingsStateBackUpDateLoading());
      final date = await _backupRepository.getLastUpdated(event.context);
      emit(SettingsStateBackUpDateLoaded(date: date));
    });
  }
}
