import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/backup/i_backup_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'backup_event.dart';
part 'backup_state.dart';

part 'backup_bloc.freezed.dart';

@lazySingleton
class BackUpBloc extends Bloc<BackUpEvent, BackupState> {
  final IBackupRepository _backupRepository;

  BackUpBloc(this._backupRepository) : super(const BackupState.initial()) {
    on<BackUpLoadingCreateBackUp>((event, emit) async {
      emit(const BackupState.loading());
      final error = await _backupRepository.createBackUp();
      if (error == "") {
        emit(BackupState.loaded("backup_bloc_creation_successful".tr()));
      } else {
        emit(BackupState.error("${"backup_bloc_creation_failed".tr()} $error"));
      }
    });

    on<BackUpLoadingMergeBackUp>((event, emit) async {
      emit(const BackupState.loading());
      final error = await _backupRepository.restoreBackUp();
      if (error == "") {
        emit(BackupState.loaded("backup_bloc_merge_successful".tr()));
      } else {
        emit(BackupState.error("${"backup_bloc_merge_failed".tr()} $error"));
      }
    });

    on<BackUpLoadingRemoveBackUp>((event, emit) async {
      emit(const BackupState.loading());
      final error = await _backupRepository.removeBackUp();
      if (error == "") {
        emit(BackupState.loaded("backup_bloc_removal_successful".tr()));
      } else {
        emit(BackupState.error("${"backup_bloc_removal_failed".tr()} $error"));
      }
    });

    on<BackUpGetVersion>((event, emit) async {
      emit(const BackupState.loading());
      final version = await _backupRepository.getVersion();
      PackageInfo pi = await PackageInfo.fromPlatform();
      List<String> notes =
          // ignore: use_build_context_synchronously
          await _backupRepository.getVersionNotes(event.context);
      if (version != pi.version && version != "") {
        emit(BackupState.versionRetrieved(version, notes));
      } else {
        emit(BackupState.notesRetrieved(notes));
      }
    });
  }
}
