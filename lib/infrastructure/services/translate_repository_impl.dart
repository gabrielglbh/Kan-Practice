import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/services/i_translate_repository.dart';

@LazySingleton(as: ITranslateRepository)
class TranslateRepositoryImpl implements ITranslateRepository {
  TranslateRepositoryImpl();

  OnDeviceTranslator? _onDeviceTranslator;

  @override
  Future<String> translate(String text, String targetLanguage) async {
    _onDeviceTranslator ??= OnDeviceTranslator(
      sourceLanguage: TranslateLanguage.japanese,
      targetLanguage: TranslateLanguage.values
          .firstWhere((element) => element.bcpCode == targetLanguage),
    );
    final translatedText = await _onDeviceTranslator?.translateText(text);
    return translatedText ?? '';
  }

  @override
  Future<void> close() async {
    await _onDeviceTranslator?.close();
  }
}
