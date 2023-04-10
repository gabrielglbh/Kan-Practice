part of 'dictionary_bloc.dart';

@freezed
class DictionaryState with _$DictionaryState {
  const factory DictionaryState.loading() = DictionaryLoading;
  const factory DictionaryState.loaded(List<Category> predictions) =
      DictionaryLoaded;
  const factory DictionaryState.initial() = DictionaryInitial;
  const factory DictionaryState.error() = DictionaryError;
}
