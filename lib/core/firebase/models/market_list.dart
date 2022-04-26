import 'package:json_annotation/json_annotation.dart';
import 'package:kanpractice/core/database/models/list.dart';

part 'market_list.g.dart';

@JsonSerializable()
class MarketList {
  KanjiList list;
  /// Rating will hold a map of authenticated users IDs with their rating on a list.
  /// A certain person will only be able to change the rating on their rating,
  /// updating the whole rating that is being done by the mean of rates.
  final Map<String, double> rating;
  final int downloads;
  final String description;
  /// Firebase ID of the author that created the KanList
  final String author;
  final int updatedToMarket;

  MarketList({required this.list, this.rating = const {}, this.downloads = 0,
    required this.description, required this.author, this.updatedToMarket = 0
  });

  /// Empty [MarketList]
  static final MarketList empty = MarketList(list: KanjiList.empty, description: "", author: "");

  factory MarketList.fromJson(Map<String, dynamic> json) => _$MarketListFromJson(json);
  Map<String, dynamic> toJson() => _$MarketListToJson(this);

  MarketList copyWithUpdatedDate({int? lastUpdated}) => MarketList(
      list: list,
      rating: rating,
      downloads: downloads,
      description: description,
      author: author,
      updatedToMarket: lastUpdated ?? updatedToMarket
  );

  MarketList copyWithReset({
    required String author
  }) => MarketList(
      list: list.copyWithReset(),
      rating: rating,
      downloads: downloads,
      description: description,
      author: author,
      updatedToMarket: updatedToMarket
  );
}