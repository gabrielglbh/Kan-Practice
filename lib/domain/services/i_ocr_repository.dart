import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

abstract class IOCRRepository {
  Future<String> recognize(InputImage image);
  Future<void> close();
}
