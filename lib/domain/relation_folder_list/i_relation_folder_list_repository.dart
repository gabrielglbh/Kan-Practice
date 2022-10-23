import 'package:kanpractice/domain/relation_folder_list/relation_folder_list.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class IRelationFolderListRepository {
  /// Get all available relations [Folder]-[RelationFolderList] for backup purposes
  Future<List<RelationFolderList>> getFolderRelation();
  Future<int> moveListToFolder(String folder, String list);
  Future<int> removeListToFolder(String folder, String list);

  /// Merges relations between folders and lists from the backup
  Future<Batch?> mergeRelationFolderList(
    Batch? batch,
    List<RelationFolderList> relations,
    ConflictAlgorithm? conflictAlgorithm,
  ); // TODO: Replace on backup and ignore on market
}
