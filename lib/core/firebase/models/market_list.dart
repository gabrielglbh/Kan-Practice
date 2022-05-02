import 'package:json_annotation/json_annotation.dart';

part 'market_list.g.dart';

@JsonSerializable()
class MarketList {
  static const uidField = "uid";
  static const listNameField = "name";
  static const numberOfWordsField = "words";
  static const ratingMapField = "ratingMap";
  static const ratingField = "rating";
  static const downloadField = "downloads";
  static const authorField = "author";
  static const uploadedToMarketField = "uploadedToMarket";

  final String name;
  final int words;
  final String uid;
  /// Rating will hold a map of authenticated users IDs with their rating on a list.
  /// A certain person will only be able to change the rating on their rating,
  /// updating the whole rating that is being done by the mean of rates.
  final Map<String, double> ratingMap;
  /// Field to keep up with the mean of the rates
  final double rating;
  final int downloads;
  final String description;
  /// Firebase ID of the author that created the KanList
  final String author;
  final int uploadedToMarket;

  MarketList({required this.words, required this.uid, required this.name, this.ratingMap = const {},
    this.rating = 0, this.downloads = 0, required this.description, required this.author,
    this.uploadedToMarket = 0
  });

  /// Empty [MarketList]
  static final MarketList empty = MarketList(name: "", uid: "", words: 0, description: "", author: "");

  factory MarketList.fromJson(Map<String, dynamic> json) => _$MarketListFromJson(json);
  Map<String, dynamic> toJson() => _$MarketListToJson(this);

  MarketList copyWithUpdatedDate({int? lastUpdated}) => MarketList(
      name: name,
      uid: uid,
      words: words,
      ratingMap: ratingMap,
      rating: rating,
      downloads: downloads,
      description: description,
      author: author,
      uploadedToMarket: lastUpdated ?? uploadedToMarket
  );

  MarketList copyWithReset({
    required String author
  }) => MarketList(
      name: name,
      uid: uid,
      words: words,
      ratingMap: ratingMap,
      rating: rating,
      downloads: downloads,
      description: description,
      author: author,
      uploadedToMarket: uploadedToMarket
  );
}