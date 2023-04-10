part of 'dictionary_details_bloc.dart';

@freezed
class DictionaryDetailsState with _$DictionaryDetailsState {
  const factory DictionaryDetailsState.loading() = DictionaryDetailsLoading;
  const factory DictionaryDetailsState.loaded(WordData data) =
      DictionaryDetailsLoaded;
  const factory DictionaryDetailsState.initial() = DictionaryDetailsInitial;
  const factory DictionaryDetailsState.error() = DictionaryDetailsError;
}
