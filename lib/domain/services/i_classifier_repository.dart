import 'dart:typed_data';
import 'dart:ui';

import 'package:kanpractice/application/dictionary/dictionary_bloc.dart';

abstract class IClassifierRepository {
  Future<void> loadModel();

  /// Takes an image from [KPCustomCanvas] to fit in to the interpreter's model
  /// See the implementation to understand it better.
  Future<List<Category>> predict(ByteData image, Size size);
}
