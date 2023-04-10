part of 'word_details_bloc.dart';

@freezed
class WordDetailsState with _$WordDetailsState {
  const factory WordDetailsState.error(String message) = WordDetailsError;
  const factory WordDetailsState.initial() = WordDetailsInitial;
  const factory WordDetailsState.loading() = WordDetailsLoading;
  const factory WordDetailsState.removed() = WordDetailsRemoved;
  const factory WordDetailsState.loaded(Word word) = WordDetailsLoaded;
}
