part of 'list_details_bloc.dart';

@freezed
class ListDetailsState with _$ListDetailsState {
  const factory ListDetailsState.loaded(String name) = ListDetailsLoaded;
  const factory ListDetailsState.initial() = ListDetailsInitial;
  const factory ListDetailsState.loading() = ListDetailsLoading;
  const factory ListDetailsState.error() = ListDetailsError;
}
