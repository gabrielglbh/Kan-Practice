part of 'snackbar_bloc.dart';

abstract class SnackbarEvent extends Equatable {
  const SnackbarEvent();

  @override
  List<Object> get props => [];
}

class SnackbarEventShow extends SnackbarEvent {
  final String message;

  const SnackbarEventShow(this.message);

  @override
  List<Object> get props => [message];
}
