import 'package:injectable/injectable.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/domain/relation_folder_list/i_relation_folder_list_repository.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:kanpractice/domain/relation_folder_list/relation_folder_list.dart';

@LazySingleton(as: IRelationFolderListRepository)
class RelationFolderListRepositoryImpl
    implements IRelationFolderListRepository {
  final Database _database;

  RelationFolderListRepositoryImpl(this._database);

  @override
  Future<List<RelationFolderList>> getFolderRelation() async {
    try {
      final res = await _database.query(RelationFolderListTableFields.relTable);
      return List.generate(
          res.length, (i) => RelationFolderList.fromJson(res[i]));
    } catch (err) {
      print(err.toString());
      return [];
    }
  }

  @override
  Future<Batch?> mergeRelationFolderList(
      Batch? batch,
      List<RelationFolderList> relations,
      ConflictAlgorithm? conflictAlgorithm) async {
    for (var k in relations) {
      batch?.insert(RelationFolderListTableFields.relTable, k.toJson(),
          conflictAlgorithm: conflictAlgorithm);
    }
    return batch;
  }

  @override
  Future<int> moveListToFolder(String folder, String list) async {
    try {
      await _database.insert(
        RelationFolderListTableFields.relTable,
        RelationFolderList(folder: folder, list: list).toJson(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
      return 0;
    } catch (err) {
      print(err.toString());
      return -1;
    }
  }

  @override
  Future<int> removeListToFolder(String folder, String list) async {
    try {
      await _database.delete(
        RelationFolderListTableFields.relTable,
        where:
            "${RelationFolderListTableFields.listNameField}=? AND ${RelationFolderListTableFields.nameField}=?",
        whereArgs: [list, folder],
      );
      return 0;
    } catch (err) {
      print(err.toString());
      return -1;
    }
  }
}
