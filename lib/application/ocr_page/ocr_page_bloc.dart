import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/services/i_ocr_repository.dart';
import 'package:kanpractice/domain/services/i_translate_repository.dart';

part 'ocr_page_event.dart';
part 'ocr_page_state.dart';

part 'ocr_page_bloc.freezed.dart';

@injectable
class OCRPageBloc extends Bloc<OCRPageEvent, OCRPageState> {
  final ITranslateRepository _translateRepository;
  final IOCRRepository _iocrRepository;

  final ImagePicker _imagePicker = ImagePicker();
  File? _image;
  String _ocrText = '';
  String _ocrTranslatedText = '';

  OCRPageBloc(this._translateRepository, this._iocrRepository)
      : super(const OCRPageState.initial()) {
    on<OCRPageEventReset>(((event, emit) {
      emit(const OCRPageState.initial());
    }));

    on<OCRPageEventLoadImage>((event, emit) async {
      emit(const OCRPageState.loading());
      if (event.file != null) {
        final inputImage = InputImage.fromFilePath(event.file!.path);
        _ocrText = await _iocrRepository.recognize(inputImage);
        _image = event.file;
        emit(OCRPageState.imageLoaded(_ocrText, image: event.file));
      } else {
        emit(const OCRPageState.initial());
      }
    });

    on<OCRPageEventCrop>((event, emit) async {
      emit(const OCRPageState.loading());
      final pickedFile = event.file ??
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final image = File(pickedFile.path);
        emit(OCRPageState.imageCropped(image));
      } else {
        emit(const OCRPageState.initial());
      }
    });

    on<OCRPageEventTranslate>((event, emit) async {
      emit(const OCRPageState.loading());
      _ocrTranslatedText =
          await _translateRepository.translate(_ocrText, event.locale);
      emit(OCRPageState.translationLoaded(_ocrTranslatedText, image: _image));
    });

    on<OCRPageEventShowOriginal>((event, emit) async {
      emit(OCRPageState.imageLoaded(_ocrText, image: _image));
    });

    on<OCRPageEventTraverseText>((event, emit) async {
      _ocrText = event.text.split('\n').reversed.toList().join('\n');
      emit(OCRPageState.imageLoaded(_ocrText, image: _image));
    });

    on<OCRPageEventShowUpdateText>((event, emit) async {
      _ocrText = event.text;
      emit(OCRPageState.imageLoaded(_ocrText, image: _image));
    });
  }
}
