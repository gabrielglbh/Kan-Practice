import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/preferences/i_preferences_repository.dart';

@injectable
class PreferencesService {
  final IPreferencesRepository _preferencesRepository;

  PreferencesService(this._preferencesRepository);

  dynamic saveData(String key, dynamic value) {
    _preferencesRepository.saveData(key, value);
  }

  dynamic readData(String key) => _preferencesRepository.readData(key);
}
