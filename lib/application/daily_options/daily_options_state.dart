part of 'daily_options_bloc.dart';

@freezed
class DailyOptionsState with _$DailyOptionsState {
  const factory DailyOptionsState.loading() = DailyOptionsLoading;
  const factory DailyOptionsState.loaded(
    int words,
    int grammar,
    int wordsMean,
    int grammarMean,
  ) = DailyOptionsLoaded;
  const factory DailyOptionsState.initial() = DailyOptionsInitial;
  const factory DailyOptionsState.error() = DailyOptionsError;
}
