part of 'add_folder_bloc.dart';

abstract class AddFolderEvent extends Equatable {
  const AddFolderEvent();

  @override
  List<Object> get props => [];
}

class AddFolderEventIdle extends AddFolderEvent {
  final String? folder;

  const AddFolderEventIdle(this.folder);
}

class AddFolderEventOnUpload extends AddFolderEvent {
  final String folder;
  final Map<String, bool> kanLists;

  const AddFolderEventOnUpload(this.folder, this.kanLists);

  @override
  List<Object> get props => [folder, kanLists];
}

class AddFolderEventOnListAddition extends AddFolderEvent {
  final String folder;
  final Map<String, bool> kanLists;

  const AddFolderEventOnListAddition(this.folder, this.kanLists);

  @override
  List<Object> get props => [folder, kanLists];
}
