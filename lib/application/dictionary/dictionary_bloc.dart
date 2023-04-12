import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image/image.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/services/i_classifier_repository.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

part 'dictionary_event.dart';
part 'dictionary_state.dart';

part 'dictionary_bloc.freezed.dart';

@injectable
class DictionaryBloc extends Bloc<DictionaryEvent, DictionaryState> {
  final IClassifierRepository _classifierRepository;

  DictionaryBloc(this._classifierRepository)
      : super(const DictionaryState.initial()) {
    on<DictionaryEventStart>((event, emit) async {
      try {
        emit(const DictionaryState.loading());

        /// Instantiate the classifier once the page has been animated in
        await Future.delayed(const Duration(milliseconds: 500), () async {
          await _classifierRepository.loadModel();
        });
        emit(const DictionaryState.loaded([]));
      } on Exception {
        emit(const DictionaryState.error());
      }
    });

    on<DictionaryEventLoading>((event, emit) async {
      try {
        emit(const DictionaryState.loading());
        List<Category> categories = _classifierRepository.predict(event.image);
        categories =
            categories.getRange(0, KPSizes.numberOfPredictedWords).toList();
        emit(DictionaryState.loaded(categories));
      } on Exception {
        emit(const DictionaryState.error());
      }
    });
  }
}
