abstract class ISpeechToTextRepository {
  Future<bool> setUp();
  Future<List<String>> recognize();
}
