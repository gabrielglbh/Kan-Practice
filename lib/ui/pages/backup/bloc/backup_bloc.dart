import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/firebase/queries/back_ups.dart';
import 'package:easy_localization/easy_localization.dart';

part 'backup_event.dart';
part 'backup_state.dart';

class BackUpBloc extends Bloc<BackUpEvent, BackUpState> {
  BackUpBloc() : super(BackUpStateLoaded());

  @override
  Stream<BackUpState> mapEventToState(BackUpEvent event) async* {
    if (event is BackUpLoadingCreateBackUp) yield* _mapCreatedToState();
    else if (event is BackUpLoadingMergeBackUp) yield* _mapMergedToState(event);
    else if (event is BackUpLoadingRemoveBackUp) yield* _mapRemovedToState(event);
    else if (event is BackUpIdle) yield BackUpStateLoaded();
  }

  Stream<BackUpState> _mapCreatedToState() async* {
    yield BackUpStateLoading();
    final error = await BackUpRecords.instance.createBackUp();
    if (error == "") yield BackUpStateLoaded(message: "backup_bloc_creation_successful".tr());
    else yield BackUpStateLoaded(message: "${"backup_bloc_creation_failed".tr()} $error");
  }

  Stream<BackUpState> _mapMergedToState(BackUpLoadingMergeBackUp event) async* {
    yield BackUpStateLoading();
    final error = await BackUpRecords.instance.restoreBackUp();
    if (error == "") yield BackUpStateLoaded(message: "backup_bloc_merge_successful".tr());
    else yield BackUpStateLoaded(message: "${"backup_bloc_merge_failed".tr()} $error");
  }

  Stream<BackUpState> _mapRemovedToState(BackUpLoadingRemoveBackUp event) async* {
    yield BackUpStateLoading();
    final error = await BackUpRecords.instance.removeBackUp();
    if (error == "") yield BackUpStateLoaded(message: "backup_bloc_removal_successful".tr());
    else yield BackUpStateLoaded(message: "${"backup_bloc_removal_failed".tr()} $error");
  }
}