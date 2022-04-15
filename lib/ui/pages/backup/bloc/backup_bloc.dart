import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/firebase/queries/back_ups.dart';
import 'package:easy_localization/easy_localization.dart';

part 'backup_event.dart';
part 'backup_state.dart';

class BackUpBloc extends Bloc<BackUpEvent, BackUpState> {
  BackUpBloc() : super(BackUpStateLoaded()) {
    on<BackUpLoadingCreateBackUp>((event, emit) async {
      emit(BackUpStateLoading());
      final error = await BackUpRecords.instance.createBackUp(backUpTests: event.backUpTests);
      if (error == "") emit(BackUpStateLoaded(message: "backup_bloc_creation_successful".tr()));
      else emit(BackUpStateLoaded(message: "${"backup_bloc_creation_failed".tr()} $error"));
    });

    on<BackUpLoadingMergeBackUp>((event, emit) async {
      emit(BackUpStateLoading());
      final error = await BackUpRecords.instance.restoreBackUp();
      if (error == "") emit(BackUpStateLoaded(message: "backup_bloc_merge_successful".tr()));
      else emit(BackUpStateLoaded(message: "${"backup_bloc_merge_failed".tr()} $error"));
    });

    on<BackUpLoadingRemoveBackUp>((event, emit) async {
      emit(BackUpStateLoading());
      final error = await BackUpRecords.instance.removeBackUp();
      if (error == "") emit(BackUpStateLoaded(message: "backup_bloc_removal_successful".tr()));
      else emit(BackUpStateLoaded(message: "${"backup_bloc_removal_failed".tr()} $error"));
    });

    on<BackUpIdle>((event, emit) {
      emit(BackUpStateLoaded());
    });
  }
}