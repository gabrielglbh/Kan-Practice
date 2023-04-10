part of 'generic_test_bloc.dart';

@freezed
class GenericTestState with _$GenericTestState {
  const factory GenericTestState.initial(List<int> wordsToReview) =
      GenericTestInitial;
  const factory GenericTestState.loaded(List<Word> words, StudyModes mode) =
      GenericTestLoaded;
}
