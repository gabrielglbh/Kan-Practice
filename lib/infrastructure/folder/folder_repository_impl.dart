import 'package:injectable/injectable.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/domain/folder/folder.dart';
import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/domain/relation_folder_list/i_relation_folder_list_repository.dart';
import 'package:kanpractice/presentation/core/types/grammar_modes.dart';
import 'package:kanpractice/presentation/core/types/wordlist_filters.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/types/folder_filters.dart';
import 'package:kanpractice/domain/folder/i_folder_repository.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:sqflite/sqlite_api.dart';

@LazySingleton(as: IFolderRepository)
// TODO: Add any new study or grammar modes onto the queries
class FolderRepositoryImpl implements IFolderRepository {
  final Database _database;
  final IRelationFolderListRepository _relationFolderListRepository;

  FolderRepositoryImpl(this._database, this._relationFolderListRepository);

  @override
  Future<int> createFolder(String name, {List<String> lists = const []}) async {
    try {
      if (name.trim().isEmpty) return -1;
      await _database.insert(
          FolderTableFields.folderTable,
          Folder(
            folder: name,
            lastUpdated: Utils.getCurrentMilliseconds(),
          ).toJson());
      for (var l in lists) {
        int code =
            await _relationFolderListRepository.moveListToFolder(name, l);
        if (code != 0) throw Exception();
      }
      return 0;
    } catch (err) {
      print(err.toString());
      return -1;
    }
  }

  @override
  Future<List<Folder>> getAllFolders(
      {FolderFilters filter = FolderFilters.all,
      String order = "DESC",
      int? limit,
      int? offset}) async {
    try {
      final res = await _database.query(
        FolderTableFields.folderTable,
        orderBy: "${filter.filter} $order",
        limit: limit,
        offset: (offset != null && limit != null) ? offset * limit : null,
      );
      return List.generate(res.length, (i) => Folder.fromJson(res[i]));
    } catch (err) {
      print(err.toString());
      return [];
    }
  }

  @override
  Future<List<WordList>> getAllListsOnFolder(String folder,
      {WordListFilters filter = WordListFilters.all,
      String order = "DESC",
      int? offset,
      int? limit}) async {
    try {
      List<Map<String, dynamic>>? res = [];
      final limitParsed = limit != null ? "LIMIT $limit" : "";
      final offsetParsed =
          offset != null && limit != null ? "OFFSET ${offset * limit}" : "";

      if (filter != WordListFilters.recentlyAdded) {
        res = await _database.rawQuery(
            "SELECT DISTINCT R.${ListTableFields.nameField}, "
            "R.${ListTableFields.totalWinRateWritingField}, "
            "R.${ListTableFields.totalWinRateReadingField}, "
            "R.${ListTableFields.totalWinRateRecognitionField}, "
            "R.${ListTableFields.totalWinRateListeningField}, "
            "R.${ListTableFields.totalWinRateSpeakingField}, "
            "R.${ListTableFields.totalWinRateDefinitionField}, "
            "R.${ListTableFields.totalWinRateGrammarPointField}, "
            "R.${ListTableFields.lastUpdatedField} "
            "FROM ${RelationFolderListTableFields.relTable} L JOIN ${ListTableFields.listsTable} R "
            "ON L.${RelationFolderListTableFields.listNameField}=R.${ListTableFields.nameField} "
            "WHERE L.${RelationFolderListTableFields.nameField} LIKE '$folder' "
            "ORDER BY R.${filter.filter} $order "
            "$limitParsed $offsetParsed");
      } else {
        res = await _database.rawQuery(
            "SELECT A.${ListTableFields.nameField}, A.${ListTableFields.lastUpdatedField}, "
            "A.${ListTableFields.totalWinRateWritingField}, A.${ListTableFields.totalWinRateReadingField}, "
            "A.${ListTableFields.totalWinRateRecognitionField}, A.${ListTableFields.totalWinRateListeningField}, "
            "A.${ListTableFields.totalWinRateSpeakingField}, A.${ListTableFields.totalWinRateDefinitionField}, "
            "A.${ListTableFields.totalWinRateGrammarPointField} "
            "FROM ${ListTableFields.listsTable} A "
            "JOIN "
            "(SELECT ${WordTableFields.listNameField}, MAX(${filter.filter}) AS ${WordTableFields.dateAddedField} "
            "FROM ${WordTableFields.wordTable} "
            "GROUP BY ${WordTableFields.listNameField} "
            "ORDER BY ${WordTableFields.dateAddedField}) B "
            "ON A.${ListTableFields.nameField} = B.${WordTableFields.listNameField} "
            "JOIN "
            "${RelationFolderListTableFields.relTable} L "
            "ON L.${RelationFolderListTableFields.listNameField}=A.${ListTableFields.nameField} "
            "WHERE L.${RelationFolderListTableFields.nameField} LIKE '$folder' "
            "ORDER BY B.${filter.filter} $order "
            "$limitParsed $offsetParsed");
      }
      final list = List.generate(res.length, (i) => WordList.fromJson(res![i]));
      return list;
    } catch (err) {
      print(err.toString());
      return [];
    }
  }

  @override
  Future<List<WordList>> getAllListsOnFolderOnQuery(String query, String folder,
      {int? offset, int? limit}) async {
    try {
      final limitParsed = limit != null ? "LIMIT $limit" : "";
      final offsetParsed =
          offset != null && limit != null ? "OFFSET ${offset * limit}" : "";
      final res = await _database.rawQuery(
          "SELECT DISTINCT R.${ListTableFields.nameField}, "
          "R.${ListTableFields.totalWinRateWritingField}, "
          "R.${ListTableFields.totalWinRateReadingField}, "
          "R.${ListTableFields.totalWinRateRecognitionField}, "
          "R.${ListTableFields.totalWinRateListeningField}, "
          "R.${ListTableFields.totalWinRateSpeakingField}, "
          "R.${ListTableFields.totalWinRateDefinitionField}, "
          "R.${ListTableFields.totalWinRateGrammarPointField}, "
          "R.${ListTableFields.lastUpdatedField} "
          "FROM ${RelationFolderListTableFields.relTable} L JOIN ${ListTableFields.listsTable} R "
          "ON L.${RelationFolderListTableFields.listNameField}=R.${ListTableFields.nameField} "
          "JOIN ${WordTableFields.wordTable} K ON K.${WordTableFields.listNameField}=R.${ListTableFields.nameField} "
          "WHERE L.${RelationFolderListTableFields.nameField} LIKE '$folder' "
          "AND (R.${ListTableFields.nameField} LIKE '%$query%' OR K.${WordTableFields.meaningField} LIKE '%$query%' "
          "OR K.${WordTableFields.wordField} LIKE '%$query%' OR K.${WordTableFields.pronunciationField} LIKE '%$query%') "
          "ORDER BY ${ListTableFields.lastUpdatedField} DESC "
          "$limitParsed $offsetParsed");
      return List.generate(res.length, (i) => WordList.fromJson(res[i]));
    } catch (err) {
      print(err.toString());
      return [];
    }
  }

  @override
  Future<List<Word>> getAllWordsOnListsOnFolder(List<String> folders,
      {StudyModes? mode, Tests? type, int? category}) async {
    try {
      String whereClause = "";
      String query = "";

      /// Build up the where clauses from the listName
      for (var folder in folders) {
        whereClause +=
            "${RelationFolderListTableFields.nameField} LIKE '$folder' OR ";
      }

      /// Clean up the String
      whereClause = whereClause.substring(0, whereClause.length - 4);

      final joinSelection = "SELECT DISTINCT K.${WordTableFields.wordField}, "
          "K.${WordTableFields.listNameField}, "
          "K.${WordTableFields.meaningField}, "
          "K.${WordTableFields.pronunciationField}, "
          "K.${WordTableFields.winRateWritingField}, "
          "K.${WordTableFields.winRateReadingField}, "
          "K.${WordTableFields.winRateRecognitionField}, "
          "K.${WordTableFields.winRateListeningField}, "
          "K.${WordTableFields.winRateSpeakingField}, "
          "K.${WordTableFields.dateAddedField}, "
          "K.${WordTableFields.dateLastShown}, "
          "K.${WordTableFields.dateLastShownWriting}, "
          "K.${WordTableFields.dateLastShownReading}, "
          "K.${WordTableFields.dateLastShownRecognition}, "
          "K.${WordTableFields.dateLastShownListening}, "
          "K.${WordTableFields.dateLastShownSpeaking}, "
          "K.${WordTableFields.categoryField} "
          "FROM ${RelationFolderListTableFields.relTable} L JOIN ${ListTableFields.listsTable} R "
          "ON L.${RelationFolderListTableFields.listNameField}=R.${ListTableFields.nameField} "
          "JOIN ${WordTableFields.wordTable} K "
          "ON K.${WordTableFields.listNameField}=R.${ListTableFields.nameField} "
          "WHERE $whereClause";

      if (type == Tests.categories) {
        if (category != null) {
          query =
              "$joinSelection AND K.${WordTableFields.categoryField}=$category";
        } else {
          return [];
        }
      } else if (type == Tests.daily) {
        if (mode != null) {
          switch (mode) {
            case StudyModes.writing:
              query =
                  "$joinSelection ORDER BY K.${WordTableFields.dateLastShownWriting} ASC, "
                  "K.${WordTableFields.winRateWritingField} ASC";
              break;
            case StudyModes.reading:
              query =
                  "$joinSelection ORDER BY K.${WordTableFields.dateLastShownReading} ASC, "
                  "K.${WordTableFields.winRateReadingField} ASC";
              break;
            case StudyModes.recognition:
              query =
                  "$joinSelection ORDER BY K.${WordTableFields.dateLastShownRecognition} ASC, "
                  "K.${WordTableFields.winRateRecognitionField} ASC";
              break;
            case StudyModes.listening:
              query =
                  "$joinSelection ORDER BY K.${WordTableFields.dateLastShownListening} ASC, "
                  "K.${WordTableFields.winRateListeningField} ASC";
              break;
            case StudyModes.speaking:
              query =
                  "$joinSelection ORDER BY K.${WordTableFields.dateLastShownSpeaking} ASC, "
                  "K.${WordTableFields.winRateSpeakingField} ASC";
              break;
          }
        } else {
          return [];
        }
      } else if (type == Tests.time) {
        if (mode != null) {
          switch (mode) {
            case StudyModes.writing:
              query =
                  "$joinSelection ORDER BY K.${WordTableFields.dateLastShownWriting} ASC";
              break;
            case StudyModes.reading:
              query =
                  "$joinSelection ORDER BY K.${WordTableFields.dateLastShownReading} ASC";
              break;
            case StudyModes.recognition:
              query =
                  "$joinSelection ORDER BY K.${WordTableFields.dateLastShownRecognition} ASC";
              break;
            case StudyModes.listening:
              query =
                  "$joinSelection ORDER BY K.${WordTableFields.dateLastShownListening} ASC";
              break;
            case StudyModes.speaking:
              query =
                  "$joinSelection ORDER BY K.${WordTableFields.dateLastShownSpeaking} ASC";
              break;
          }
        } else {
          return [];
        }
      } else if (type == Tests.less) {
        if (mode != null) {
          switch (mode) {
            case StudyModes.writing:
              query =
                  "$joinSelection ORDER BY K.${WordTableFields.winRateWritingField} ASC";
              break;
            case StudyModes.reading:
              query =
                  "$joinSelection ORDER BY K.${WordTableFields.winRateReadingField} ASC";
              break;
            case StudyModes.recognition:
              query =
                  "$joinSelection ORDER BY K.${WordTableFields.winRateRecognitionField} ASC";
              break;
            case StudyModes.listening:
              query =
                  "$joinSelection ORDER BY K.${WordTableFields.winRateListeningField} ASC";
              break;
            case StudyModes.speaking:
              query =
                  "$joinSelection ORDER BY K.${WordTableFields.winRateSpeakingField} ASC";
              break;
          }
        } else {
          return [];
        }
      } else {
        query = joinSelection;
      }

      final res = await _database.rawQuery(query);
      return List.generate(res.length, (i) => Word.fromJson(res[i]));
    } catch (err) {
      print(err.toString());
      return [];
    }
  }

  @override
  Future<List<GrammarPoint>> getAllGrammarPointsOnListsOnFolder(
      List<String> folders,
      {GrammarModes? mode,
      Tests? type,
      int? category}) async {
    try {
      String whereClause = "";
      String query = "";

      /// Build up the where clauses from the listName
      for (var folder in folders) {
        whereClause +=
            "${RelationFolderListTableFields.nameField} LIKE '$folder' OR ";
      }

      /// Clean up the String
      whereClause = whereClause.substring(0, whereClause.length - 4);

      final joinSelection =
          "SELECT DISTINCT K.${GrammarTableFields.nameField}, "
          "K.${GrammarTableFields.definitionField}, "
          "K.${GrammarTableFields.exampleField}, "
          "K.${GrammarTableFields.listNameField}, "
          "K.${GrammarTableFields.winRateDefinitionField}, "
          "K.${GrammarTableFields.winRateGrammarPointField}, "
          "K.${GrammarTableFields.dateAddedField}, "
          "K.${GrammarTableFields.dateLastShownField}, "
          "K.${GrammarTableFields.dateLastShownDefinitionField}, "
          "K.${GrammarTableFields.dateLastShownGrammarPointField} "
          "FROM ${RelationFolderListTableFields.relTable} L JOIN ${ListTableFields.listsTable} R "
          "ON L.${RelationFolderListTableFields.listNameField}=R.${ListTableFields.nameField} "
          "JOIN ${GrammarTableFields.grammarTable} K "
          "ON K.${GrammarTableFields.listNameField}=R.${ListTableFields.nameField} "
          "WHERE $whereClause";

      if (type == Tests.daily) {
        if (mode != null) {
          switch (mode) {
            case GrammarModes.definition:
              query =
                  "$joinSelection ORDER BY K.${GrammarTableFields.dateLastShownDefinitionField} ASC, "
                  "K.${GrammarTableFields.winRateDefinitionField} ASC";
              break;
            case GrammarModes.grammarPoints:
              query =
                  "$joinSelection ORDER BY K.${GrammarTableFields.dateLastShownGrammarPointField} ASC, "
                  "K.${GrammarTableFields.winRateGrammarPointField} ASC";
              break;
          }
        } else {
          return [];
        }
      } else if (type == Tests.time) {
        if (mode != null) {
          switch (mode) {
            case GrammarModes.definition:
              query =
                  "$joinSelection ORDER BY K.${GrammarTableFields.dateLastShownDefinitionField} ASC";
              break;
            case GrammarModes.grammarPoints:
              query =
                  "$joinSelection ORDER BY K.${GrammarTableFields.dateLastShownGrammarPointField} ASC";
              break;
          }
        } else {
          return [];
        }
      } else if (type == Tests.less) {
        if (mode != null) {
          switch (mode) {
            case GrammarModes.definition:
              query =
                  "$joinSelection ORDER BY K.${GrammarTableFields.winRateDefinitionField} ASC";
              break;
            case GrammarModes.grammarPoints:
              query =
                  "$joinSelection ORDER BY K.${GrammarTableFields.winRateGrammarPointField} ASC";
              break;
          }
        } else {
          return [];
        }
      } else {
        query = joinSelection;
      }

      final res = await _database.rawQuery(query);
      return List.generate(res.length, (i) => GrammarPoint.fromJson(res[i]));
    } catch (err) {
      print(err.toString());
      return [];
    }
  }

  @override
  Future<Folder> getFolder(String name) async {
    try {
      final res = await _database.query(
        FolderTableFields.folderTable,
        where: "${FolderTableFields.nameField}=?",
        whereArgs: [name],
      );
      return Folder.fromJson(res[0]);
    } catch (err) {
      print(err.toString());
      return Folder.empty;
    }
  }

  @override
  Future<List<Folder>> getListsMatchingQuery(String query,
      {required int offset, required int limit}) async {
    try {
      List<Map<String, dynamic>>? res = [];
      res = await _database
          .rawQuery("SELECT * FROM ${FolderTableFields.folderTable} "
              "WHERE ${FolderTableFields.nameField} LIKE '%$query%' "
              "ORDER BY ${FolderTableFields.lastUpdatedField} DESC "
              "LIMIT $limit OFFSET ${offset * limit}");
      return List.generate(res.length, (i) => Folder.fromJson(res![i]));
    } catch (err) {
      print(err.toString());
      return [];
    }
  }

  @override
  Batch? mergeFolders(
    Batch? batch,
    List<Folder> folders,
    ConflictAlgorithm conflictAlgorithm,
  ) {
    for (int x = 0; x < folders.length; x++) {
      batch?.insert(FolderTableFields.folderTable, folders[x].toJson(),
          conflictAlgorithm: conflictAlgorithm);
    }
    return batch;
  }

  @override
  Future<int> removeFolder(String folder) async {
    try {
      await _database.delete(FolderTableFields.folderTable,
          where: "${FolderTableFields.nameField}=?", whereArgs: [folder]);
      return 0;
    } catch (err) {
      print(err.toString());
      return -1;
    }
  }
}
