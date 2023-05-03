abstract class ISentenceGeneratorRepository {
  Future<String> getRandomSentence(List<String> words);
}
