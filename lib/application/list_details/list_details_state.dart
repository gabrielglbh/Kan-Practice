part of 'list_details_bloc.dart';

class ListDetailState extends Equatable {
  const ListDetailState();

  @override
  List<Object?> get props => [];
}

class ListDetailStateIdle extends ListDetailState {}

class ListDetailStateLoading extends ListDetailState {}

class ListDetailStateLoaded extends ListDetailState {
  final String name;

  const ListDetailStateLoaded(this.name);
}

class ListDetailStateFailure extends ListDetailState {
  final String error;

  const ListDetailStateFailure({this.error = ""});

  @override
  List<Object> get props => [error];
}
