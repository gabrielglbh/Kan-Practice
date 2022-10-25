part of 'folder_details_bloc.dart';

class FolderDetailsState extends Equatable {
  const FolderDetailsState();

  @override
  List<Object?> get props => [];
}

class FolderDetailsStateIdle extends FolderDetailsState {}

class FolderDetailsStateLoading extends FolderDetailsState {}

class FolderDetailsStateSearching extends FolderDetailsState {}

class FolderDetailsStateLoaded extends FolderDetailsState {
  final List<WordList> lists;

  const FolderDetailsStateLoaded({this.lists = const []});

  @override
  List<Object> get props => [lists];
}

class FolderDetailsStateTestLoaded extends FolderDetailsState {
  final List<WordList> lists;

  const FolderDetailsStateTestLoaded({this.lists = const []});

  @override
  List<Object> get props => [lists];
}

class FolderDetailsStateFailure extends FolderDetailsState {}
