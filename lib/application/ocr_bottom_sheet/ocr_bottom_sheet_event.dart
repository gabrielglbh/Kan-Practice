part of 'ocr_bottom_sheet_bloc.dart';

abstract class OCRBottomSheetEvent extends Equatable {
  const OCRBottomSheetEvent();

  @override
  List<Object> get props => [];
}

class OCRBottomSheetEventTranslate extends OCRBottomSheetEvent {
  final String locale;

  const OCRBottomSheetEventTranslate(this.locale);

  @override
  List<Object> get props => [locale];
}

class OCRBottomSheetEventLoadImage extends OCRBottomSheetEvent {
  final ImageSource source;

  const OCRBottomSheetEventLoadImage(this.source);

  @override
  List<Object> get props => [source];
}

class OCRBottomSheetEventShowOriginal extends OCRBottomSheetEvent {}

class OCRBottomSheetEventReset extends OCRBottomSheetEvent {}
