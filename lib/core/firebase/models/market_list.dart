import 'package:json_annotation/json_annotation.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';

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
    this.description = "", this.author = "", this.updatedToMarket = 0
  });

  /// Empty [MarketList]
  static final MarketList empty = MarketList(list: KanjiList.empty);

  factory MarketList.fromJson(Map<String, dynamic> json) => _$MarketListFromJson(json);
  Map<String, dynamic> toJson() => _$MarketListToJson(this);

  MarketList copyWithUpdatedDate({int? lastUpdated}) => MarketList(
      list: this.list,
      rating: this.rating,
      downloads: this.downloads,
      description: this.description,
      author: this.author,
      updatedToMarket: lastUpdated ?? this.updatedToMarket
  );

  MarketList copyWithReset() => MarketList(
      list: this.list.copyWithReset(),
      rating: this.rating,
      downloads: this.downloads,
      description: this.description,
      author: this.author,
      updatedToMarket: this.updatedToMarket
  );
}