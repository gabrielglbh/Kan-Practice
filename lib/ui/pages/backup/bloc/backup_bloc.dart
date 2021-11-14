import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/firebase/queries/back_ups.dart';

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
    if (error == "") yield BackUpStateLoaded(message: "Back up created successfully");
    else yield BackUpStateLoaded(message: "Something went wrong while creating the back up: $error");
  }

  Stream<BackUpState> _mapMergedToState(BackUpLoadingMergeBackUp event) async* {
    yield BackUpStateLoading();
    final error = await BackUpRecords.instance.restoreBackUp();
    if (error == "") yield BackUpStateLoaded(message: "Back up merged successfully");
    else yield BackUpStateLoaded(message: "Something went wrong while merging the back up: $error");
  }

  Stream<BackUpState> _mapRemovedToState(BackUpLoadingRemoveBackUp event) async* {
    yield BackUpStateLoading();
    final error = await BackUpRecords.instance.removeBackUp();
    if (error == "") yield BackUpStateLoaded(message: "Back up removed successfully");
    else yield BackUpStateLoaded(message: "Something went wrong while removing the back up: $error");
  }
}