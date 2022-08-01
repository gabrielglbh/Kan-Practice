part of 'folder_bloc.dart';

abstract class FolderEvent extends Equatable {
  const FolderEvent();

  @override
  List<Object> get props => [];
}

class FolderEventLoading extends FolderEvent {
  /// Maintains the filter applied by the user for loading new lists
  final FolderFilters filter;

  /// Maintains the order applied by the user for loading new lists
  final bool order;

  /// Whether to reset the counter for the offset on the lazy loading or not
  final bool reset;

  const FolderEventLoading(
      {required this.filter, required this.order, this.reset = false});

  @override
  List<Object> get props => [filter, order, reset];
}

class FolderForTestEventLoading extends FolderEvent {}

class FolderEventSearching extends FolderEvent {
  final String query;

  /// Whether to reset the counter for the offset on the lazy loading or not
  final bool reset;

  const FolderEventSearching(this.query, {this.reset = false});

  @override
  List<Object> get props => [query, reset];
}

class FolderEventCreate extends FolderEvent {
  final String name;

  /// Maintains the filter applied by the user for loading new lists
  final FolderFilters filter;

  /// Maintains the order applied by the user for loading new lists
  final bool order;
  final bool useLazyLoading;

  const FolderEventCreate(this.name,
      {required this.filter, required this.order, this.useLazyLoading = true});

  @override
  List<Object> get props => [name, filter, order, useLazyLoading];
}

class FolderEventAddSingleList extends FolderEvent {
  final String name;
  final String folder;

  const FolderEventAddSingleList(this.name, this.folder);

  @override
  List<Object> get props => [name, folder];
}

class FolderEventDelete extends FolderEvent {
  final Folder list;

  /// Maintains the filter applied by the user for loading new lists
  final FolderFilters filter;

  /// Maintains the order applied by the user for loading new lists
  final bool order;

  const FolderEventDelete(this.list,
      {required this.filter, required this.order});

  @override
  List<Object> get props => [list, filter, order];
}
