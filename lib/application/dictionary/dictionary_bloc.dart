import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/services/i_classifier_repository.dart';

part 'dictionary_event.dart';
part 'dictionary_state.dart';

part 'dictionary_bloc.freezed.dart';

class Category {
  final String label;
  final double score;

  const Category(this.label, this.score);
}

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
        final categories = await _classifierRepository.predict(event.data);
        emit(DictionaryState.loaded(categories));
      } on Exception {
        emit(const DictionaryState.error());
      }
    });
  }
}
