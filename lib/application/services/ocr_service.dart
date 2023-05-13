import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/services/i_ocr_repository.dart';

@injectable
class OCRService {
  final IOCRRepository _ocrRepository;

  OCRService(this._ocrRepository);

  Future<String> recognize(InputImage inputImage) async {
    return await _ocrRepository.recognize(inputImage);
  }

  Future<void> close() async {
    return await _ocrRepository.close();
  }
}
