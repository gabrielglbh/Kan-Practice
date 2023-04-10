part of 'example_data_bloc.dart';

@freezed
class ExampleDataState with _$ExampleDataState {
  const factory ExampleDataState.loaded() = ExampleDataLoaded;
  const factory ExampleDataState.initial() = ExampleDataInitial;
  const factory ExampleDataState.error() = ExampleDataError;
}
