import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/services/i_translate_repository.dart';

@LazySingleton(as: ITranslateRepository)
class TranslateRepositoryImpl implements ITranslateRepository {
  TranslateRepositoryImpl();

  @override
  Future<String> translate(String text, String targetLanguage) async {
    final onDeviceTranslator = OnDeviceTranslator(
      sourceLanguage: TranslateLanguage.japanese,
      targetLanguage: TranslateLanguage.values
          .firstWhere((element) => element.bcpCode == targetLanguage),
    );
    final translatedText = await onDeviceTranslator.translateText(text);
    await onDeviceTranslator.close();
    return translatedText;
  }
}
