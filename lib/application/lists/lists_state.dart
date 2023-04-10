part of 'lists_bloc.dart';

@freezed
class ListsState with _$ListsState {
  const factory ListsState.loaded(List<WordList> lists) = ListsLoaded;
  const factory ListsState.loading() = ListsLoading;
  const factory ListsState.error() = ListsError;
}
