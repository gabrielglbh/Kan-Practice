import 'package:json_annotation/json_annotation.dart';

part 'market_list.g.dart';

@JsonSerializable()
class MarketList {
  static const idField = "id";
  static const ratingField = "rating";
  static const downloadField = "download";
  static const authorField = "author";
  static const updatedToMarketField = "updatedToMarket";

  final String id;
  /// Rating will hold a map of authenticated users IDs with their rating on a list.
  /// A certain person will only be able to change the rating on their rating,
  /// updating the whole rating that is being done by the mean of rates.
  final Map<String, double> rating;
  final int downloads;
  final String description;
  /// Firebase ID of the author that created the KanList
  final String author;
  final int updatedToMarket;

  MarketList({this.id = "", this.rating = const {}, this.downloads = 0,
    required this.description, required this.author, this.updatedToMarket = 0
  });

  /// Empty [MarketList]
  static final MarketList empty = MarketList(description: "", author: "");

  factory MarketList.fromJson(Map<String, dynamic> json) => _$MarketListFromJson(json);
  Map<String, dynamic> toJson() => _$MarketListToJson(this);

  MarketList copyWithUpdatedDate({int? lastUpdated}) => MarketList(
      id: id,
      rating: rating,
      downloads: downloads,
      description: description,
      author: author,
      updatedToMarket: lastUpdated ?? updatedToMarket
  );

  MarketList copyWithReset({
    required String author
  }) => MarketList(
      id: id,
      rating: rating,
      downloads: downloads,
      description: description,
      author: author,
      updatedToMarket: updatedToMarket
  );
}