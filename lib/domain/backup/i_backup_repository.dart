abstract class IBackupRepository {
  Future<String> getVersion();
  Future<List<String>> getVersionNotes();
  Future<String> createBackUp();
  Future<String> restoreBackUp();
  Future<String> removeBackUp();
  Future<String> getLastUpdated();
}
