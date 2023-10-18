import 'dart:io';
import 'dart:isolate';
import 'package:image/image.dart' as image_lib;
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/application/dictionary/dictionary_bloc.dart';
import 'package:kanpractice/domain/services/i_classifier_repository.dart';
import 'package:kanpractice/infrastructure/services/classifier/classifier_isolate_inference.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

@LazySingleton(as: IClassifierRepository)
class ClassifierRepositoryImpl implements IClassifierRepository {
  late Interpreter _interpreter;
  late IsolateInference _isolateInference;
  late Tensor _inputTensor;
  late Tensor _outputTensor;

  final String _labelsFileName = 'assets/model/etlcb_9b_labels.txt';
  final String _modelFileName = 'assets/model/etlcb_9b_model.tflite';

  late List<String> labels;

  @override
  Future<void> loadModel() async {
    _loadInterpreter();
    _loadLabels();
    _isolateInference = IsolateInference();
    await _isolateInference.start();
  }

  Future<void> _loadInterpreter() async {
    final options = InterpreterOptions();

    // Use XNNPACK Delegate
    if (Platform.isAndroid) {
      options.addDelegate(XNNPackDelegate());
    }

    if (Platform.isIOS) {
      options.addDelegate(GpuDelegate());
    }

    _interpreter =
        await Interpreter.fromAsset(_modelFileName, options: options);
    // Get tensor input shape [1, 64, 64, 1]
    _inputTensor = _interpreter.getInputTensors().first;
    // Get tensor output shape [1, 3036]
    _outputTensor = _interpreter.getOutputTensors().first;
    print('Interpreter loaded successfully');
    print('Input: (shape: ${_inputTensor.shape} type: ${_inputTensor.type})');
    print(
        'Output: (shape: ${_outputTensor.shape} type: ${_outputTensor.type})');
  }

  Future<void> _loadLabels() async {
    final labelTxt = await rootBundle.loadString(_labelsFileName);
    labels = labelTxt.split('\n');
  }

  @override
  Future<List<Category>> predict(ByteData data, Size size) async {
    /// Transforms the ui.Image to a im.Image to feed to the tflite model
    /// https://github.com/brendan-duncan/image/blob/main/doc/flutter.md
    final image = image_lib.Image.fromBytes(
      width: size.width.toInt(),
      height: size.height.toInt(),
      bytes: data.buffer,
      numChannels: 4,
    );

    var isolateModel = InferenceModel(
      image,
      _interpreter.address,
      labels,
      _inputTensor.shape,
      _outputTensor.shape,
    );
    return await _inference(isolateModel);
  }

  Future<List<Category>> _inference(InferenceModel inferenceModel) async {
    ReceivePort responsePort = ReceivePort();
    _isolateInference.sendPort
        .send(inferenceModel..responsePort = responsePort.sendPort);
    // get inference result.
    var results = await responsePort.first;
    return results;
  }
}
