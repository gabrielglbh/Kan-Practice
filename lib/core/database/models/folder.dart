import 'package:json_annotation/json_annotation.dart';

part 'folder.g.dart';

@JsonSerializable()
class Folder {
  String folder;
  String kanListName;

  Folder({required this.folder, required this.kanListName});

  /// Empty [Folder]
  static final Folder empty = Folder(folder: "", kanListName: "");

  factory Folder.fromJson(Map<String, dynamic> json) => _$FolderFromJson(json);
  Map<String, dynamic> toJson() => _$FolderToJson(this);
}
