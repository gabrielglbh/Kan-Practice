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
  static const keywordsField = "keywords";
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

  /// Keywords for searching indexes
  final List<String> keywords;
  final int downloads;
  final String description;

  /// Firebase ID of the author that created the KanList
  final String author;
  final int uploadedToMarket;

  MarketList(
      {required this.words,
      required this.uid,
      required this.name,
      this.ratingMap = const {},
      this.rating = 0,
      this.downloads = 0,
      required this.description,
      required this.author,
      this.keywords = const [],
      this.uploadedToMarket = 0});

  /// Empty [MarketList]
  static final MarketList empty =
      MarketList(name: "", uid: "", words: 0, description: "", author: "");

  factory MarketList.fromJson(Map<String, dynamic> json) =>
      _$MarketListFromJson(json);
  Map<String, dynamic> toJson() => _$MarketListToJson(this);

  MarketList copyWithKeywords() {
    List<String> k = [];

    /// Set as keywords the individual words and the compendium of aggregated
    /// letters of the author and name of the Market List
    k.addAll(author.toLowerCase().split(" "));
    k.addAll(name.toLowerCase().split(" "));
    for (int x = 0; x < author.length; x++) {
      k.add(author.substring(0, x + 1).toLowerCase());
    }
    for (int x = 0; x < name.length; x++) {
      k.add(name.substring(0, x + 1).toLowerCase());
    }
    return MarketList(
        name: name,
        uid: uid,
        words: words,
        ratingMap: ratingMap,
        rating: rating,
        keywords: k,
        downloads: downloads,
        description: description,
        author: author,
        uploadedToMarket: uploadedToMarket);
  }
}
