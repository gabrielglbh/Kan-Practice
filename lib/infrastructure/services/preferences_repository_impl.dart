import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/services/i_preferences_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class PreferencesRepositoryImpl implements IPreferencesRepository {
  final SharedPreferences? _preferences;

  PreferencesRepositoryImpl(this._preferences);

  @override
  saveData(String key, dynamic value) {
    if (value is int) {
      _preferences?.setInt(key, value);
    } else if (value is String) {
      _preferences?.setString(key, value);
    } else if (value is bool) {
      _preferences?.setBool(key, value);
    } else {
      print("Invalid Type");
    }
  }

  @override
  dynamic readData(String key) => _preferences?.get(key);
}
