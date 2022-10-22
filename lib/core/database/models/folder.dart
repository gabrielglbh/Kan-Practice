import 'package:json_annotation/json_annotation.dart';
import 'package:kanpractice/presentation/core/util/general_utils.dart';

part 'folder.g.dart';

@JsonSerializable()
class Folder {
  final String folder;
  final int lastUpdated;

  Folder({required this.folder, required this.lastUpdated});

  /// Empty [Folder]
  static final Folder empty = Folder(folder: "", lastUpdated: 0);

  factory Folder.fromJson(Map<String, dynamic> json) => _$FolderFromJson(json);
  Map<String, dynamic> toJson() => _$FolderToJson(this);

  Folder copyWithUpdatedDate({int? lastUpdated}) =>
      Folder(folder: folder, lastUpdated: lastUpdated ?? this.lastUpdated);

  Folder copyWithReset() => Folder(
      folder: folder, lastUpdated: GeneralUtils.getCurrentMilliseconds());
}
