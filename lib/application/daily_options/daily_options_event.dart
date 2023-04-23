part of 'daily_options_bloc.dart';

abstract class DailyOptionsEvent extends Equatable {
  const DailyOptionsEvent();

  @override
  List<Object> get props => [];
}

class DailyOptionsEventLoadData extends DailyOptionsEvent {}
