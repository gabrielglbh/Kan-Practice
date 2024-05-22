part of 'snackbar_bloc.dart';

@freezed
class SnackbarState with _$SnackbarState {
  const factory SnackbarState.show(String message) = SnackbarShown;
  const factory SnackbarState.hide() = SnackbarHidden;
}
