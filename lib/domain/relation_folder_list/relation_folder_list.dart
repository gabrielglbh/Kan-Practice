import 'package:json_annotation/json_annotation.dart';

part 'relation_folder_list.g.dart';

@JsonSerializable()
class RelationFolderList {
  final String folder;
  final String list;

  RelationFolderList({required this.folder, required this.list});

  /// Empty [RelationFolderList]
  static final RelationFolderList empty =
      RelationFolderList(folder: "", list: "");

  factory RelationFolderList.fromJson(Map<String, dynamic> json) =>
      _$RelationFolderListFromJson(json);
  Map<String, dynamic> toJson() => _$RelationFolderListToJson(this);
}
