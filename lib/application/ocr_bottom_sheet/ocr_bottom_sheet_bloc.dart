import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/services/i_ocr_repository.dart';
import 'package:kanpractice/domain/services/i_translate_repository.dart';

part 'ocr_bottom_sheet_event.dart';
part 'ocr_bottom_sheet_state.dart';

part 'ocr_bottom_sheet_bloc.freezed.dart';

@injectable
class OCRBottomSheetBloc
    extends Bloc<OCRBottomSheetEvent, OCRBottomSheetState> {
  final ITranslateRepository _translateRepository;
  final IOCRRepository _iocrRepository;

  final ImagePicker _imagePicker = ImagePicker();
  String _ocrText = '';
  String _ocrTranslatedText = '';

  OCRBottomSheetBloc(this._translateRepository, this._iocrRepository)
      : super(const OCRBottomSheetState.initial()) {
    on<OCRBottomSheetEventReset>(((event, emit) {
      _translateRepository.close();
      _iocrRepository.close();
      emit(const OCRBottomSheetState.initial());
    }));

    on<OCRBottomSheetEventLoadImage>((event, emit) async {
      emit(const OCRBottomSheetState.loading());
      final pickedFile = await _imagePicker.pickImage(source: event.source);
      if (pickedFile != null) {
        final image = File(pickedFile.path);
        final inputImage = InputImage.fromFilePath(pickedFile.path);
        _ocrText = await _iocrRepository.recognize(inputImage);
        emit(OCRBottomSheetState.imageLoaded(_ocrText, image: image));
      } else {
        emit(const OCRBottomSheetState.initial());
      }
    });

    on<OCRBottomSheetEventTranslate>((event, emit) async {
      emit(const OCRBottomSheetState.loading());
      _ocrTranslatedText =
          await _translateRepository.translate(_ocrText, event.locale);
      emit(OCRBottomSheetState.translationLoaded(_ocrTranslatedText));
    });

    on<OCRBottomSheetEventShowOriginal>((event, emit) async {
      emit(OCRBottomSheetState.imageLoaded(_ocrText));
    });

    on<OCRBottomSheetEventTraverseText>((event, emit) async {
      _ocrText = event.text.split('\n').reversed.toList().join('\n');
      emit(OCRBottomSheetState.imageLoaded(_ocrText));
    });
  }
}
