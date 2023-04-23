part of 'specific_data_bloc.dart';

@freezed
class SpecificDataState with _$SpecificDataState {
  const factory SpecificDataState.testRetrieved(SpecificData data, Tests test) =
      SpecificDataTestRetrieved;
  const factory SpecificDataState.categoryRetrieved(
      SpecificData data, WordCategory category) = SpecificDataCategoryRetrieved;
  const factory SpecificDataState.initial() = SpecificDataInitial;
}
