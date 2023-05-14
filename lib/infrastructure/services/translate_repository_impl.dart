import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/services/i_translate_repository.dart';

@LazySingleton(as: ITranslateRepository)
class TranslateRepositoryImpl implements ITranslateRepository {
  TranslateRepositoryImpl();

  OnDeviceTranslator? _onDeviceTranslator;

  @override
  Future<String> translate(
    String text,
    String targetLanguage, {
    String sourceLanguge = 'ja',
  }) async {
    _onDeviceTranslator ??= OnDeviceTranslator(
      sourceLanguage: TranslateLanguage.values
          .firstWhere((l) => l.bcpCode == sourceLanguge),
      targetLanguage: TranslateLanguage.values
          .firstWhere((l) => l.bcpCode == targetLanguage),
    );
    final translatedText = await _onDeviceTranslator?.translateText(text);
    return translatedText ?? '';
  }

  @override
  Future<void> loadModel() async {
    final modelManager = OnDeviceTranslatorModelManager();
    final isModelLoaded = await modelManager
        .isModelDownloaded(TranslateLanguage.japanese.bcpCode);
    if (isModelLoaded) return;
    await modelManager.downloadModel(TranslateLanguage.japanese.bcpCode);
  }

  @override
  Future<void> close() async {
    await _onDeviceTranslator?.close();
  }
}
