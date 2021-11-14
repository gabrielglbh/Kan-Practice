part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object?> get props => [];
}

class SettingsStateBackUpDateLoaded extends SettingsState {
  final String date;

  const SettingsStateBackUpDateLoaded({this.date = ""});

  @override
  List<Object> get props => [date];
}

class SettingsStateBackUpDateLoading extends SettingsState {}