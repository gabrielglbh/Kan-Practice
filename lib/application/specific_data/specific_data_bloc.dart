import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/domain/specific_data/i_specific_data_repository.dart';
import 'package:kanpractice/domain/specific_data/specific_data.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/presentation/core/types/word_categories.dart';

part 'specific_data_event.dart';
part 'specific_data_state.dart';

part 'specific_data_bloc.freezed.dart';

@lazySingleton
class SpecificDataBloc extends Bloc<SpecificDataEvent, SpecificDataState> {
  final ISpecificDataRepository _specificDataRepository;

  SpecificDataBloc(this._specificDataRepository)
      : super(const SpecificDataState.initial()) {
    on<SpecificDataEventGatherCategory>((event, emit) async {
      final data =
          await _specificDataRepository.getSpecificCategoryData(event.category);
      emit(SpecificDataState.categoryRetrieved(data, event.category));
    });

    on<SpecificDataEventGatherTest>((event, emit) async {
      final data =
          await _specificDataRepository.getSpecificTestData(event.test);
      emit(SpecificDataState.testRetrieved(data, event.test));
    });
  }
}
