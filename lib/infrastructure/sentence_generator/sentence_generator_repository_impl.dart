import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/sentence_generator/i_sentence_generator_repository.dart';
import 'package:kanpractice/infrastructure/sentence_generator/sentence_generator_dto.dart';
import 'package:kanpractice/infrastructure/services/http_service.dart';

@LazySingleton(as: ISentenceGeneratorRepository)
class SentenceGeneratorRepository implements ISentenceGeneratorRepository {
  final HttpService _httpService;
  SentenceGeneratorRepository(this._httpService);

  @override
  Future<String> getRandomSentence(List<String> words) async {
    try {
      final response = await _httpService.getOpenAIPrompt(words);
      if (response.statusCode == 200) {
        return SentenceGeneratorDto.fromJson(
                json.decode(utf8.decode(response.bodyBytes)))
            .toDomain();
      }
      return '';
    } catch (err) {
      return '';
    }
  }
}
