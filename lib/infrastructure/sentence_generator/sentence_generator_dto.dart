import 'package:freezed_annotation/freezed_annotation.dart';

part 'sentence_generator_dto.g.dart';

@JsonSerializable()
class SentenceGeneratorDto {
  final String id;
  final String object;
  final int created;
  final String model;
  final List<ChoicesDto> choices;

  const SentenceGeneratorDto({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.choices,
  });

  factory SentenceGeneratorDto.fromJson(Map<String, dynamic> json) =>
      _$SentenceGeneratorDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SentenceGeneratorDtoToJson(this);

  String toDomain() => choices[0].toDomain().replaceAll('\n', '');
}

@JsonSerializable()
class ChoicesDto {
  final String text;
  final int index;
  final String? logprobs;
  @JsonKey(name: 'finish_reason')
  final String finishReason;

  const ChoicesDto({
    required this.text,
    required this.index,
    required this.logprobs,
    required this.finishReason,
  });

  factory ChoicesDto.fromJson(Map<String, dynamic> json) =>
      _$ChoicesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChoicesDtoToJson(this);

  String toDomain() => text;
}
