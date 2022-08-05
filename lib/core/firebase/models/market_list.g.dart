// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketList _$MarketListFromJson(Map<String, dynamic> json) => MarketList(
      words: json['words'] as int,
      uid: json['uid'] as String,
      name: json['name'] as String,
      ratingMap: (json['ratingMap'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const {},
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      downloads: json['downloads'] as int? ?? 0,
      description: json['description'] as String,
      author: json['author'] as String,
      keywords: (json['keywords'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      uploadedToMarket: json['uploadedToMarket'] as int? ?? 0,
      isFolder: json['isFolder'] as bool? ?? false,
    );

Map<String, dynamic> _$MarketListToJson(MarketList instance) =>
    <String, dynamic>{
      'name': instance.name,
      'words': instance.words,
      'uid': instance.uid,
      'ratingMap': instance.ratingMap,
      'rating': instance.rating,
      'keywords': instance.keywords,
      'downloads': instance.downloads,
      'description': instance.description,
      'author': instance.author,
      'uploadedToMarket': instance.uploadedToMarket,
      'isFolder': instance.isFolder,
    };
