import 'package:image/image.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/services/i_classifier_repository.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

@injectable
class ClassifierService {
  final IClassifierRepository _classifierRepository;

  ClassifierService(this._classifierRepository);

  Future<void> loadModel() async {
    await _classifierRepository.loadModel();
  }

  List<Category> predict(Image image) {
    return _classifierRepository.predict(image);
  }
}
