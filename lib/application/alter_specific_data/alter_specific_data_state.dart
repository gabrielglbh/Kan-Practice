part of 'alter_specific_data_bloc.dart';

@freezed
class AlterSpecificDataState with _$AlterSpecificDataState {
  const factory AlterSpecificDataState.testRetrieved(
      AlterSpecificData data, Tests test) = AlterSpecificDataTestRetrieved;
  const factory AlterSpecificDataState.categoryRetrieved(
          AlterSpecificData data, WordCategory category) =
      AlterSpecificDataCategoryRetrieved;
  const factory AlterSpecificDataState.initial() = AlterSpecificDataInitial;
}
