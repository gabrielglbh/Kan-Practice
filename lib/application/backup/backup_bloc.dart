import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/backup/i_backup_repository.dart';

part 'backup_event.dart';
part 'backup_state.dart';

@lazySingleton
class BackUpBloc extends Bloc<BackUpEvent, BackUpState> {
  final IBackupRepository _backupRepository;

  BackUpBloc(this._backupRepository) : super(BackUpStateIdle()) {
    on<BackUpLoadingCreateBackUp>((event, emit) async {
      emit(BackUpStateLoading());
      final error = await _backupRepository.createBackUp();
      if (error == "") {
        emit(BackUpStateSuccess(
            message: "backup_bloc_creation_successful".tr()));
      } else {
        emit(BackUpStateFailure(
            message: "${"backup_bloc_creation_failed".tr()} $error"));
      }
    });

    on<BackUpLoadingMergeBackUp>((event, emit) async {
      emit(BackUpStateLoading());
      final error = await _backupRepository.restoreBackUp();
      if (error == "") {
        emit(BackUpStateSuccess(message: "backup_bloc_merge_successful".tr()));
      } else {
        emit(BackUpStateFailure(
            message: "${"backup_bloc_merge_failed".tr()} $error"));
      }
    });

    on<BackUpLoadingRemoveBackUp>((event, emit) async {
      emit(BackUpStateLoading());
      final error = await _backupRepository.removeBackUp();
      if (error == "") {
        emit(
            BackUpStateSuccess(message: "backup_bloc_removal_successful".tr()));
      } else {
        emit(BackUpStateFailure(
            message: "${"backup_bloc_removal_failed".tr()} $error"));
      }
    });

    on<BackUpIdle>((event, emit) {
      emit(BackUpStateIdle());
    });
  }
}
