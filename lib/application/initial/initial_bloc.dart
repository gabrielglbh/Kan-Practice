import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/initial/i_initial_repository.dart';
import 'package:kanpractice/domain/test_data/i_test_data_repository.dart';

part 'initial_event.dart';
part 'initial_state.dart';

@lazySingleton
class InitialBloc extends Bloc<InitialEvent, InitialState> {
  final IInitialRepository _initialRepository;
  final ITestDataRepository _testDataRepository;

  InitialBloc(
    this._initialRepository,
    this._testDataRepository,
  ) : super(InitialInitial()) {
    on<InitialEventIdle>((event, emit) {});

    on<InitialEventInstallData>((event, emit) async {
      await _initialRepository.setInitialDataForReference(event.context);
      await _testDataRepository.insertInitialTestData();
    });
  }
}
