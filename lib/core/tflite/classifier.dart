import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:image/image.dart';
import 'package:collection/collection.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

abstract class Classifier {
  late Interpreter interpreter;

  final String _labelsFileName = 'assets/model/etlcb_9b_labels.txt';
  final int _labelsLength = 3036;

  static final int width = 64;
  static final int height = 64;

  late List<String> labels;

  String get modelName;

  Classifier() {
    loadModel();
    loadLabels();
  }

  /// Initializes the TFLite interpreter on android.
  ///
  /// Uses NnAPI for devices with Android API >= 27. Otherwise uses the
  /// GPUDelegate. If it is detected that the apps runs on an emulator CPU mode
  /// is used
  Future<void> loadModel() async {
    Interpreter interpreter;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    try{
      if(androidInfo.isPhysicalDevice ?? true){
        // use NNAPI on android if android API >= 27
        if ((androidInfo.version.sdkInt ?? 27) >= 27)
          interpreter = await _nnapiInterpreter();
        // otherwise fallback to GPU delegate
        else interpreter = await _gpuInterpreterAndroid();
      }
      // use CPU inference on emulators
      else interpreter = await _cpuInterpreter();
    }
    catch (e) {
      interpreter = await _cpuInterpreter();
    }
    this.interpreter = interpreter;
    print('Interpreter loaded successfully');
  }

  Future<void> loadLabels() async {
    labels = await FileUtil.loadLabels(_labelsFileName);
    if (labels.length == _labelsLength) {
      print('Labels loaded successfully');
    } else {
      print('Unable to load labels');
    }
  }

  TensorImage _processImage(Image image) {
    TensorImage img = TensorImage(TfLiteType.float32);
    img.loadImage(image);
    return ImageProcessorBuilder()
        .add(ResizeOp(width, height, ResizeMethod.BILINEAR))
        .add(NormalizeOp(0, 255))
        .build()
        .process(img);
  }

  List<Category> predict(Image image) {
    //TensorImage im = _processImage(image);
    var _inputImage = List<List<double>>.generate(height, (i) =>
        List.generate(width, (j) => 0.0)).reshape<double>([1, height, width, 1]);

    for (int x = 0; x < height; x++) {
      for (int y = 0; y < width; y++) {
        double val = image[(x * width) + y].toDouble();
        val = val > 50 ? 1.0 : 0;
        _inputImage[0][x][y][0] = val;
      }
    }

    TensorBuffer outputBuffer = TensorBuffer.createFixedSize(
      interpreter.getOutputTensor(0).shape,
      interpreter.getOutputTensor(0).type);

    interpreter.run(_inputImage, outputBuffer);

    final probabilityProcessor = TensorProcessorBuilder().build();

    Map<String, double> labeledProb = TensorLabel.fromList(
        labels, probabilityProcessor.process(outputBuffer))
        .getMapWithFloatValue();
    print(outputBuffer.getDoubleList());
    final pred = getProbability(labeledProb).toList();
    List<Category> categories = [];

    for (int x = 0; x < pred.length; x++)
      categories.add(Category(pred[x].key, pred[x].value));

    return categories;
  }

  /// Initializes the interpreter with NPU acceleration for Android.
  Future<Interpreter> _nnapiInterpreter() async {
    final options = InterpreterOptions()..useNnApiForAndroid = true;
    Interpreter i = await Interpreter.fromAsset(modelName, options: options);
    return i;
  }

  /// Initializes the interpreter with GPU acceleration for Android.
  Future<Interpreter> _gpuInterpreterAndroid() async {
    final gpuDelegateV2 = GpuDelegateV2();
    final options = InterpreterOptions()..addDelegate(gpuDelegateV2);
    Interpreter i = await Interpreter.fromAsset(modelName, options: options);
    return i;
  }

  /// Initializes the interpreter with CPU mode set.
  Future<Interpreter> _cpuInterpreter() async {
    final options = InterpreterOptions()..threads = Platform.numberOfProcessors - 1;
    Interpreter i = await Interpreter.fromAsset(modelName, options: options);
    return i;
  }

  close() => interpreter.close();
}

PriorityQueue<MapEntry<String, double>> getProbability(Map<String, double> labeledProb) {
  var pq = PriorityQueue<MapEntry<String, double>>(compare);
  pq.addAll(labeledProb.entries);
  return pq;
}

int compare(MapEntry<String, double> e1, MapEntry<String, double> e2) {
  if (e1.value > e2.value) return -1;
  else if (e1.value == e2.value) return 0;
  else return 1;
}