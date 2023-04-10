part of 'settings_bloc.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState.loading() = SettingsLoading;
  const factory SettingsState.loaded(String date) = SettingsLoaded;
  const factory SettingsState.initial() = SettingsInitial;
}
