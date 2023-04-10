part of 'stats_bloc.dart';

@freezed
class StatsState with _$StatsState {
  const factory StatsState.loaded(KanPracticeStats stats) = StatsLoaded;
  const factory StatsState.loading() = StatsLoading;
  const factory StatsState.initial() = StatsInitial;
}
