import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/services/i_ocr_repository.dart';

@LazySingleton(as: IOCRRepository)
class OCRRepositoryImpl implements IOCRRepository {
  OCRRepositoryImpl();

  TextRecognizer? _textRecognizer;

  @override
  Future<String> recognize(InputImage image) async {
    _textRecognizer ??= TextRecognizer(script: TextRecognitionScript.japanese);
    final recognisedText = await _textRecognizer?.processImage(image);
    String result = '';

    for (TextBlock block in recognisedText!.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {
          result += "\n${element.text}";
        }
      }
    }
    return result.length > 1 ? result.substring(1) : result;
  }

  @override
  Future<void> close() async {
    await _textRecognizer?.close();
  }
}
