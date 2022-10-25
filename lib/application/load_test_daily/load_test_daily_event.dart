part of 'load_test_daily_bloc.dart';

abstract class LoadTestDailyEvent extends Equatable {
  const LoadTestDailyEvent();

  @override
  List<Object> get props => [];
}

class LoadTestDailyEventLoadList extends LoadTestDailyEvent {
  final String? folder;

  const LoadTestDailyEventLoadList({required this.folder});
}
