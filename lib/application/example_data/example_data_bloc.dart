import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/example_data/i_example_data_repository.dart';
import 'package:kanpractice/domain/test_data/i_test_data_repository.dart';

part 'example_data_event.dart';
part 'example_data_state.dart';

part 'example_data_bloc.freezed.dart';

@lazySingleton
class ExampleDataBloc extends Bloc<ExampleDataEvent, ExampleDataState> {
  final IExampleDataRepository _initialRepository;
  final ITestDataRepository _testDataRepository;

  ExampleDataBloc(
    this._initialRepository,
    this._testDataRepository,
  ) : super(const ExampleDataState.initial()) {
    on<ExampleDataEventIdle>((event, emit) {});

    on<ExampleDataEventInstallData>((event, emit) async {
      final res =
          await _initialRepository.setInitialDataForReference(event.context);
      if (res == 0) {
        await _testDataRepository.insertExampleData();
        emit(const ExampleDataState.loaded());
      } else {
        emit(const ExampleDataState.error());
      }
    });
  }
}
