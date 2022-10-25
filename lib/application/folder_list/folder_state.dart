part of 'folder_bloc.dart';

class FolderState extends Equatable {
  const FolderState();

  @override
  List<Object?> get props => [];
}

class FolderStateLoading extends FolderState {}

class FolderStateSearching extends FolderState {}

class FolderStateLoaded extends FolderState {
  final List<Folder> lists;

  const FolderStateLoaded({this.lists = const []});

  @override
  List<Object> get props => [lists];
}

class FolderStateFailure extends FolderState {}

class FolderStateAddedList extends FolderState {}
