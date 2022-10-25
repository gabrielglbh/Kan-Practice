part of 'add_word_bloc.dart';

class AddWordState extends Equatable {
  const AddWordState();

  @override
  List<Object?> get props => [];
}

class AddWordStateIdle extends AddWordState {}

class AddWordStateLoading extends AddWordState {}

class AddWordStateDoneCreating extends AddWordState {
  final bool exitMode;

  const AddWordStateDoneCreating({required this.exitMode});

  @override
  List<Object?> get props => [exitMode];
}

class AddWordStateDoneUpdating extends AddWordState {}

class AddWordStateFailure extends AddWordState {
  final String message;

  const AddWordStateFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
