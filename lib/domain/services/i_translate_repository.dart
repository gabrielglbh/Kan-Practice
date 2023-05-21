abstract class ITranslateRepository {
  Future<String> translate(
    String text,
    String targetLanguage, {
    String sourceLanguge = 'ja',
  });
  Future<void> close();
  Future<void> loadModel();
}
