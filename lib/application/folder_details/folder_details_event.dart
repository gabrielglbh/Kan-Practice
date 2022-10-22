part of 'folder_details_bloc.dart';

abstract class FolderDetailsEvent extends Equatable {
  const FolderDetailsEvent();

  @override
  List<Object> get props => [];
}

class FolderDetailsEventLoading extends FolderDetailsEvent {
  final String folder;

  /// Maintains the filter applied by the user for loading new lists
  final KanListFilters filter;

  /// Maintains the order applied by the user for loading new lists
  final bool order;

  /// Whether to reset the counter for the offset on the lazy loading or not
  final bool reset;

  const FolderDetailsEventLoading(
      {required this.folder,
      required this.filter,
      required this.order,
      this.reset = false});

  @override
  List<Object> get props => [filter, order, reset];
}

class FolderForTestEventLoading extends FolderDetailsEvent {
  final String folder;
  const FolderForTestEventLoading(this.folder);

  @override
  List<Object> get props => [folder];
}

class FolderDetailsEventSearching extends FolderDetailsEvent {
  final String folder;
  final String query;

  /// Whether to reset the counter for the offset on the lazy loading or not
  final bool reset;

  const FolderDetailsEventSearching(this.query, this.folder,
      {this.reset = false});

  @override
  List<Object> get props => [query, reset];
}

class FolderDetailsEventDelete extends FolderDetailsEvent {
  final String folder;
  final KanjiList list;

  /// Maintains the filter applied by the user for loading new lists
  final KanListFilters filter;

  /// Maintains the order applied by the user for loading new lists
  final bool order;

  const FolderDetailsEventDelete(this.folder, this.list,
      {required this.filter, required this.order});

  @override
  List<Object> get props => [folder, list, filter, order];
}
