// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketList _$MarketListFromJson(Map<String, dynamic> json) => MarketList(
      words: json['words'] as int,
      uid: json['uid'] as String,
      name: json['name'] as String,
      rating: (json['rating'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const {},
      downloads: json['downloads'] as int? ?? 0,
      description: json['description'] as String,
      author: json['author'] as String,
      uploadedToMarket: json['uploadedToMarket'] as int? ?? 0,
    );

Map<String, dynamic> _$MarketListToJson(MarketList instance) =>
    <String, dynamic>{
      'name': instance.name,
      'words': instance.words,
      'uid': instance.uid,
      'rating': instance.rating,
      'downloads': instance.downloads,
      'description': instance.description,
      'author': instance.author,
      'uploadedToMarket': instance.uploadedToMarket,
    };
