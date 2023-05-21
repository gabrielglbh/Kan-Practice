part of 'ocr_page_bloc.dart';

@freezed
class OCRPageState with _$OCRPageState {
  const factory OCRPageState.initial() = OCRPageInitial;
  const factory OCRPageState.loading() = OCRPageLoading;
  const factory OCRPageState.translationLoaded(String translation,
      {File? image}) = OCRPageTranslationLoaded;
  const factory OCRPageState.imageLoaded(String text, {File? image}) =
      OCRPageImageLoaded;
  const factory OCRPageState.imageCropped(File? image) = OCRPageImageCropped;
  const factory OCRPageState.error() = OCRPageError;
}
