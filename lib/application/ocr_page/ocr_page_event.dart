part of 'ocr_page_bloc.dart';

abstract class OCRPageEvent extends Equatable {
  const OCRPageEvent();

  @override
  List<Object> get props => [];
}

class OCRPageEventTranslate extends OCRPageEvent {
  final String locale;

  const OCRPageEventTranslate(this.locale);

  @override
  List<Object> get props => [locale];
}

class OCRPageEventLoadImage extends OCRPageEvent {
  final ImageSource source;

  const OCRPageEventLoadImage(this.source);

  @override
  List<Object> get props => [source];
}

class OCRPageEventShowOriginal extends OCRPageEvent {}

class OCRPageEventReset extends OCRPageEvent {}

class OCRPageEventTraverseText extends OCRPageEvent {
  final String text;

  const OCRPageEventTraverseText(this.text);

  @override
  List<Object> get props => [text];
}
