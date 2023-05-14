abstract class ISentenceGeneratorRepository {
  Future<String> getRandomSentence(String uid, List<String> words);
}
