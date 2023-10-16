import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:kanpractice/application/dictionary/dictionary_bloc.dart';
import 'package:kanpractice/domain/services/i_classifier_repository.dart';

@injectable
class ClassifierService {
  final IClassifierRepository _classifierRepository;

  ClassifierService(this._classifierRepository);

  Future<void> loadModel() async {
    await _classifierRepository.loadModel();
  }

  Future<List<Category>> predict(ByteData data) {
    return _classifierRepository.predict(data);
  }
}
