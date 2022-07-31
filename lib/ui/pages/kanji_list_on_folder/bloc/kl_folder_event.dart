part of 'kl_folder_bloc.dart';

abstract class KLFolderEvent extends Equatable {
  const KLFolderEvent();

  @override
  List<Object> get props => [];
}

class KLFolderEventLoading extends KLFolderEvent {
  final String folder;

  /// Maintains the filter applied by the user for loading new lists
  final KanListFilters filter;

  /// Maintains the order applied by the user for loading new lists
  final bool order;

  /// Whether to reset the counter for the offset on the lazy loading or not
  final bool reset;

  const KLFolderEventLoading(
      {required this.folder,
      required this.filter,
      required this.order,
      this.reset = false});

  @override
  List<Object> get props => [filter, order, reset];
}

class FolderForTestEventLoading extends KLFolderEvent {
  final String folder;
  const FolderForTestEventLoading(this.folder);

  @override
  List<Object> get props => [folder];
}

class KLFolderEventSearching extends KLFolderEvent {
  final String folder;
  final String query;

  /// Whether to reset the counter for the offset on the lazy loading or not
  final bool reset;

  const KLFolderEventSearching(this.query, this.folder, {this.reset = false});

  @override
  List<Object> get props => [query, reset];
}

class KLFolderEventDelete extends KLFolderEvent {
  final String folder;
  final KanjiList list;

  /// Maintains the filter applied by the user for loading new lists
  final KanListFilters filter;

  /// Maintains the order applied by the user for loading new lists
  final bool order;

  const KLFolderEventDelete(this.folder, this.list,
      {required this.filter, required this.order});

  @override
  List<Object> get props => [folder, list, filter, order];
}
