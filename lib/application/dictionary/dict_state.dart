part of 'dict_bloc.dart';

class DictState extends Equatable {
  const DictState();

  @override
  List<Object?> get props => [];
}

class DictStateIdle extends DictState {}

class DictStateLoading extends DictState {}

class DictStateLoaded extends DictState {
  final List<Category> predictions;

  const DictStateLoaded([this.predictions = const []]);

  @override
  List<Object> get props => [predictions];
}

class DictStateFailure extends DictState {}
