abstract class ITranslateRepository {
  Future<String> translate(String text, String targetLanguage);
  Future<void> close();
}
