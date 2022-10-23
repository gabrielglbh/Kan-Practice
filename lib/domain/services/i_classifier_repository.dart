import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'package:image/image.dart' as i;

abstract class IClassifierRepository {
  Future<void> loadModel();

  /// Takes an image from [KPCustomCanvas] to fit in to the interpreter's model
  /// See the implementation to understand it better.
  List<Category> predict(i.Image image);
}
