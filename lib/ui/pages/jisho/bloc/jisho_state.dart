part of 'jisho_bloc.dart';

class JishoState extends Equatable {
  const JishoState();

  @override
  List<Object?> get props => [];
}

class JishoStateLoaded extends JishoState {
  final KanjiData data;

  const JishoStateLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class JishoStateLoading extends JishoState {}

class JishoStateFailure extends JishoState {}