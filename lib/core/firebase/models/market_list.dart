import 'package:json_annotation/json_annotation.dart';

part 'market_list.g.dart';

@JsonSerializable()
class MarketList {
  static const idField = "id";
  static const listNameField = "name";
  static const numberOfWordsField = "words";
  static const ratingField = "rating";
  static const downloadField = "downloads";
  static const authorField = "author";
  static const updatedToMarketField = "updatedToMarket";

  final String id;
  final String name;
  final int words;
  /// Rating will hold a map of authenticated users IDs with their rating on a list.
  /// A certain person will only be able to change the rating on their rating,
  /// updating the whole rating that is being done by the mean of rates.
  final Map<String, double> rating;
  final int downloads;
  final String description;
  /// Firebase ID of the author that created the KanList
  final String author;
  final int uploadedToMarket;

  MarketList({this.id = "", required this.words, required this.name, this.rating = const {},
    this.downloads = 0, required this.description, required this.author, this.uploadedToMarket = 0
  });

  /// Empty [MarketList]
  static final MarketList empty = MarketList(name: "", words: 0, description: "", author: "");

  factory MarketList.fromJson(Map<String, dynamic> json) => _$MarketListFromJson(json);
  Map<String, dynamic> toJson() => _$MarketListToJson(this);

  MarketList copyWithUpdatedDate({int? lastUpdated}) => MarketList(
      id: id,
      name: name,
      words: words,
      rating: rating,
      downloads: downloads,
      description: description,
      author: author,
      uploadedToMarket: lastUpdated ?? uploadedToMarket
  );

  MarketList copyWithReset({
    required String author
  }) => MarketList(
      id: id,
      name: name,
      words: words,
      rating: rating,
      downloads: downloads,
      description: description,
      author: author,
      uploadedToMarket: uploadedToMarket
  );
}