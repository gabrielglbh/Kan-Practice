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
  final File? file;

  const OCRPageEventLoadImage(this.file);
}

class OCRPageEventShowOriginal extends OCRPageEvent {}

class OCRPageEventReset extends OCRPageEvent {}

class OCRPageEventShowUpdateText extends OCRPageEvent {
  final String text;

  const OCRPageEventShowUpdateText(this.text);

  @override
  List<Object> get props => [text];
}

class OCRPageEventTraverseText extends OCRPageEvent {
  final String text;

  const OCRPageEventTraverseText(this.text);

  @override
  List<Object> get props => [text];
}

class OCRPageEventCrop extends OCRPageEvent {
  final XFile? file;

  const OCRPageEventCrop({this.file});
}
