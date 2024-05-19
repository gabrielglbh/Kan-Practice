// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Market _$MarketFromJson(Map<String, dynamic> json) => Market(
      words: (json['words'] as num).toInt(),
      grammar: (json['grammar'] as num?)?.toInt() ?? 0,
      uid: json['uid'] as String,
      name: json['name'] as String,
      ratingMap: (json['ratingMap'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const {},
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      downloads: (json['downloads'] as num?)?.toInt() ?? 0,
      description: json['description'] as String,
      author: json['author'] as String,
      keywords: (json['keywords'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      uploadedToMarket: (json['uploadedToMarket'] as num?)?.toInt() ?? 0,
      isFolder: json['isFolder'] as bool? ?? false,
      language: json['language'] as String,
    );

Map<String, dynamic> _$MarketToJson(Market instance) => <String, dynamic>{
      'name': instance.name,
      'words': instance.words,
      'grammar': instance.grammar,
      'uid': instance.uid,
      'ratingMap': instance.ratingMap,
      'rating': instance.rating,
      'keywords': instance.keywords,
      'downloads': instance.downloads,
      'description': instance.description,
      'author': instance.author,
      'uploadedToMarket': instance.uploadedToMarket,
      'isFolder': instance.isFolder,
      'language': instance.language,
    };
