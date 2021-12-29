import 'package:kanpractice/core/tflite/classifier.dart';

class ETLCBClassifier extends Classifier {
  ETLCBClassifier();

  @override
  String get modelName => 'model/etlcb_9b_model.tflite';
}