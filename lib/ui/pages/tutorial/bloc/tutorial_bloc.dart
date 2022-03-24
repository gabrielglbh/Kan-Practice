import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/queries/initial_queries.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';

part 'tutorial_event.dart';
part 'tutorial_state.dart';

class TutorialBloc extends Bloc<TutorialEvent, TutorialState> {
  TutorialBloc() : super(TutorialStateIdle()) {
    on<TutorialEventLoading>((event, emit) async {
      try {
        emit(TutorialStateLoading());
        StorageManager.saveData(StorageManager.hasDoneTutorial, true);
        final code = await InitialQueries.instance.setInitialDataForReference(event.context);
        if (code == 0) emit(TutorialStateLoaded());
        else emit(TutorialStateFailure());
      } on Exception {
        emit(TutorialStateFailure());
      }
    });

    on<TutorialEventIdle>((event, emit) {});
  }
}