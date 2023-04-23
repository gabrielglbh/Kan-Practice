import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/backup/i_backup_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

part 'settings_bloc.freezed.dart';

@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final IBackupRepository _backupRepository;

  SettingsBloc(this._backupRepository) : super(const SettingsState.initial()) {
    on<SettingsIdle>((_, __) {});

    on<SettingsLoadingBackUpDate>((event, emit) async {
      emit(const SettingsState.loading());
      final date = await _backupRepository.getLastUpdated(event.context);
      emit(SettingsState.loaded(date));
    });
  }
}
