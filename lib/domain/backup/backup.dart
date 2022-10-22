import 'package:json_annotation/json_annotation.dart';
import 'package:kanpractice/domain/folder/folder.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/domain/relation_folder_list/relation_folder_list.dart';
import 'package:kanpractice/domain/specific_data/specific_data.dart';
import 'package:kanpractice/domain/test_data/test_data.dart';
import 'package:kanpractice/domain/word/word.dart';

part 'backup.g.dart';

@JsonSerializable()
class BackUp {
  final List<WordList> lists;
  final List<Word> kanji;
  final TestData testData;
  final List<SpecificData> testSpecData;
  final List<Folder> folders;
  final List<RelationFolderList> relFolderKanList;
  final int lastUpdated;

  static const String kanjiLabel = "kanji";
  static const String listLabel = "lists";
  static const String testLabel = "testData";
  static const String testSpecLabel = "testSpecData";
  static const String folderLabel = "folders";
  static const String relFolderKanListLabel = "relFK";
  static const String updatedLabel = "lastUpdated";

  const BackUp(
      {required this.lists,
      required this.kanji,
      required this.testData,
      required this.testSpecData,
      required this.folders,
      required this.relFolderKanList,
      required this.lastUpdated});

  /// Empty instance of [BackUp]
  static const BackUp empty = BackUp(
    lists: [],
    kanji: [],
    testData: TestData.empty,
    testSpecData: [],
    folders: [],
    relFolderKanList: [],
    lastUpdated: 0,
  );

  factory BackUp.fromJson(Map<String, dynamic> json) => _$BackUpFromJson(json);
  Map<String, dynamic> toJson() => _$BackUpToJson(this);
}
