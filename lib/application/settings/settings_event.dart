part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class SettingsIdle extends SettingsEvent {}

class SettingsLoadingBackUpDate extends SettingsEvent {}
