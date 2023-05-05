import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/services/i_translate_repository.dart';

@injectable
class TranslateService {
  final ITranslateRepository _translateRepository;

  TranslateService(this._translateRepository);

  Future<String> translate(String text, String targetLanguage) async {
    return await _translateRepository.translate(text, targetLanguage);
  }
}
