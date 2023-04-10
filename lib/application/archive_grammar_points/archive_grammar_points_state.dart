part of 'archive_grammar_points_bloc.dart';

@freezed
class ArchiveGrammarPointsState with _$ArchiveGrammarPointsState {
  const factory ArchiveGrammarPointsState.loading() =
      ArchiveGrammarPointsLoading;
  const factory ArchiveGrammarPointsState.loaded(List<GrammarPoint> list) =
      ArchiveGrammarPointsLoaded;
  const factory ArchiveGrammarPointsState.initial() =
      ArchiveGrammarPointsInitial;
  const factory ArchiveGrammarPointsState.error() = ArchiveGrammarPointsError;
}
