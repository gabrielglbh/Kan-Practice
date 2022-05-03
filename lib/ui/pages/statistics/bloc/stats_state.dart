part of 'stats_bloc.dart';

class StatsState extends Equatable {
  const StatsState();

  @override
  List<Object?> get props => [];
}

class StatisticsLoaded extends StatsState {
  final KanPracticeStats stats;

  const StatisticsLoaded({required this.stats});

  @override
  List<Object?> get props => [stats];
}

class StatisticsLoading extends StatsState {}