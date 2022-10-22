part of 'add_folder_bloc.dart';

abstract class AddFolderState extends Equatable {
  const AddFolderState();

  @override
  List<Object> get props => [];
}

class AddFolderStateInitial extends AddFolderState {}

class AddFolderStateFailure extends AddFolderState {
  final String message;

  const AddFolderStateFailure(this.message);

  @override
  List<Object> get props => [message];
}

class AddFolderStateLoading extends AddFolderState {}

class AddFolderStateSuccess extends AddFolderState {}

class AddFolderStateAvailableKanLists extends AddFolderState {
  final List<WordList> lists;
  final Map<String, bool> alreadyAdded;

  const AddFolderStateAvailableKanLists(this.lists, this.alreadyAdded);

  @override
  List<Object> get props => [lists, alreadyAdded];
}
