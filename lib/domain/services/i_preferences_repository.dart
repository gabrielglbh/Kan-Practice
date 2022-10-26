abstract class IPreferencesRepository {
  saveData(String key, dynamic value);
  dynamic readData(String key);
}
