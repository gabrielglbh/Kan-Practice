part of 'add_word_bloc.dart';

@freezed
class AddWordState with _$AddWordState {
  const factory AddWordState.loading() = AddWordLoading;
  const factory AddWordState.loaded() = AddWordLoaded;
  const factory AddWordState.initial() = AddWordInitial;
  const factory AddWordState.updateDone() = AddWordUpdateDone;
  const factory AddWordState.creationDone(bool exitMode) = AddWordCreationDone;
  const factory AddWordState.error(String message) = AddWordError;
}
