part of 'ocr_bottom_sheet_bloc.dart';

@freezed
class OCRBottomSheetState with _$OCRBottomSheetState {
  const factory OCRBottomSheetState.initial() = OCRBottomSheetInitial;
  const factory OCRBottomSheetState.loading() = OCRBottomSheetLoading;
  const factory OCRBottomSheetState.translationLoaded(String translation) =
      OCRBottomSheetTranslationLoaded;
  const factory OCRBottomSheetState.imageLoaded(String text, {File? image}) =
      OCRBottomSheetImageLoaded;
  const factory OCRBottomSheetState.error() = OCRBottomSheetError;
}
