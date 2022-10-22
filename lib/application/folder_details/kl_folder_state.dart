part of 'kl_folder_bloc.dart';

class KLFolderState extends Equatable {
  const KLFolderState();

  @override
  List<Object?> get props => [];
}

class KLFolderStateLoading extends KLFolderState {}

class KLFolderStateSearching extends KLFolderState {}

class KLFolderStateLoaded extends KLFolderState {
  final List<KanjiList> lists;

  const KLFolderStateLoaded({this.lists = const []});

  @override
  List<Object> get props => [lists];
}

class KLFolderStateTestLoaded extends KLFolderState {
  final List<KanjiList> lists;

  const KLFolderStateTestLoaded({this.lists = const []});

  @override
  List<Object> get props => [lists];
}

class KLFolderStateFailure extends KLFolderState {}
