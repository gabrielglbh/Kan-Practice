part of 'add_folder_bloc.dart';

abstract class AddFolderEvent extends Equatable {
  const AddFolderEvent();

  @override
  List<Object> get props => [];
}

class AddFolderEventIdle extends AddFolderEvent {}

class AddFolderEventOnUpload extends AddFolderEvent {
  final String folder;
  final List<String> kanLists;

  const AddFolderEventOnUpload(this.folder, this.kanLists);

  @override
  List<Object> get props => [folder, kanLists];
}
