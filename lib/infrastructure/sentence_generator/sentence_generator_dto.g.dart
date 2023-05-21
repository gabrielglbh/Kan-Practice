// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sentence_generator_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SentenceGeneratorDto _$SentenceGeneratorDtoFromJson(
        Map<String, dynamic> json) =>
    SentenceGeneratorDto(
      id: json['id'] as String,
      object: json['object'] as String,
      created: json['created'] as int,
      model: json['model'] as String,
      choices: (json['choices'] as List<dynamic>)
          .map((e) => ChoicesDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SentenceGeneratorDtoToJson(
        SentenceGeneratorDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'created': instance.created,
      'model': instance.model,
      'choices': instance.choices,
    };

ChoicesDto _$ChoicesDtoFromJson(Map<String, dynamic> json) => ChoicesDto(
      text: json['text'] as String,
      index: json['index'] as int,
      logprobs: json['logprobs'] as String?,
      finishReason: json['finish_reason'] as String,
    );

Map<String, dynamic> _$ChoicesDtoToJson(ChoicesDto instance) =>
    <String, dynamic>{
      'text': instance.text,
      'index': instance.index,
      'logprobs': instance.logprobs,
      'finish_reason': instance.finishReason,
    };
