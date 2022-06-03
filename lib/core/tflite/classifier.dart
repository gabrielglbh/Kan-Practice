import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:image/image.dart' as i;
import 'package:collection/collection.dart';
import 'package:kanpractice/ui/widgets/canvas/kp_custom_canvas.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

class Classifier {
  late Interpreter interpreter;

  final String _labelsFileName = 'assets/model/etlcb_9b_labels.txt';
  final String _modelFileName = 'model/etlcb_9b_model.tflite';
  final int _labelsLength = 3036;

  static const int width = 64;
  static const int height = 64;

  late List<String> labels;

  Classifier() {
    _loadModel();
    _loadLabels();
  }

  /// Initializes the TFLite interpreter on android.
  ///
  /// Uses NnAPI for devices with Android API >= 27. Otherwise uses the
  /// GPUDelegate. If it is detected that the apps runs on an emulator CPU mode
  /// is used
  Future<void> _loadModel() async {
    Interpreter interpreter;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    try {
      if (androidInfo.isPhysicalDevice ?? true) {
        // use NNAPI on android if android API >= 27
        if ((androidInfo.version.sdkInt ?? 27) >= 27) {
          interpreter = await _nnapiInterpreter();
        } else {
          interpreter = await _gpuInterpreterAndroid();
        }
      }
      // use CPU inference on emulators
      else {
        interpreter = await _cpuInterpreter();
      }
    } catch (e) {
      interpreter = await _cpuInterpreter();
    }
    this.interpreter = interpreter;
    print('Interpreter loaded successfully');
  }

  Future<void> _loadLabels() async {
    labels = await FileUtil.loadLabels(_labelsFileName);
    if (labels.length == _labelsLength) {
      print('Labels loaded successfully');
    } else {
      print('Unable to load labels');
    }
  }

  /// Takes an image from [KPCustomCanvas] to fit in to the interpreter's model
  /// See the implementation to understand it better.
  List<Category> predict(i.Image image) {
    /// Resizes the image to its actual size to fit model's input shape
    final resizedImage = i.copyResize(image, width: width, height: height);

    var _inputImage = List<List<double>>.generate(
            height, (i) => List.generate(width, (j) => 0.0))
        .reshape<double>([1, height, width, 1]);

    /// Reshape the input image from [64, 64, 3] to [1, 64, 64, 1] with normalization.
    /// That is, get only 1 batch of a 64x64 image in gray scale to feed to the model
    for (int x = 0; x < height; x++) {
      for (int y = 0; y < width; y++) {
        double val = resizedImage[(x * width) + y].toDouble();
        val = val > 50 ? 1.0 : 0;
        _inputImage[0][x][y][0] = val;
      }
    }

    TensorBuffer outputBuffer = TensorBuffer.createFixedSize(
        interpreter.getOutputTensor(0).shape,
        interpreter.getOutputTensor(0).type);

    /// Run the interpreter on the given image
    interpreter.run(_inputImage, outputBuffer.getBuffer());

    /// Normalize the output to go from 0 to 1 only
    final probabilityProcessor =
        TensorProcessorBuilder().add(NormalizeOp(0, 1)).build();

    /// And get the probabilities and parse them to a List<Category>
    Map<String, double> labeledProb =
        TensorLabel.fromList(labels, probabilityProcessor.process(outputBuffer))
            .getMapWithFloatValue();

    final predictions = _getProbability(labeledProb).toList();
    List<Category> categories = [];

    for (int x = 0; x < predictions.length; x++) {
      categories.add(Category(predictions[x].key, predictions[x].value));
    }

    return categories;
  }

  /// Initializes the interpreter with NPU acceleration for Android.
  Future<Interpreter> _nnapiInterpreter() async {
    final options = InterpreterOptions()..useNnApiForAndroid = true;
    Interpreter i =
        await Interpreter.fromAsset(_modelFileName, options: options);
    return i;
  }

  /// Initializes the interpreter with GPU acceleration for Android.
  Future<Interpreter> _gpuInterpreterAndroid() async {
    final gpuDelegateV2 = GpuDelegateV2();
    final options = InterpreterOptions()..addDelegate(gpuDelegateV2);
    Interpreter i =
        await Interpreter.fromAsset(_modelFileName, options: options);
    return i;
  }

  /// Initializes the interpreter with CPU mode set.
  Future<Interpreter> _cpuInterpreter() async {
    final options = InterpreterOptions()
      ..threads = Platform.numberOfProcessors - 1;
    Interpreter i =
        await Interpreter.fromAsset(_modelFileName, options: options);
    return i;
  }

  PriorityQueue<MapEntry<String, double>> _getProbability(
      Map<String, double> labeledProb) {
    var pq = PriorityQueue<MapEntry<String, double>>(_compare);
    pq.addAll(labeledProb.entries);
    return pq;
  }

  int _compare(MapEntry<String, double> e1, MapEntry<String, double> e2) {
    if (e1.value > e2.value) {
      return -1;
    } else if (e1.value == e2.value) {
      return 0;
    } else {
      return 1;
    }
  }

  close() => interpreter.close();
}
