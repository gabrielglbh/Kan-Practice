import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/word_history/i_word_history_repository.dart';
import 'package:kanpractice/domain/word_history/word_history.dart';

part 'word_history_event.dart';
part 'word_history_state.dart';

part 'word_history_bloc.freezed.dart';

@injectable
class WordHistoryBloc extends Bloc<WordHistoryEvent, WordHistoryState> {
  final IWordHistoryRepository _wordHistoryRepository;

  WordHistoryBloc(this._wordHistoryRepository)
      : super(const WordHistoryState.initial()) {
    /// Maintain the history for pagination purposes
    List<WordHistory> history = [];

    on<WordHistoryEventLoading>((event, emit) async {
      try {
        if (event.offset == 0) {
          emit(const WordHistoryState.loading());
          history.clear();
        }

        /// For every time we want to retrieve data, we need to instantiate
        /// a new history in order for Equatable to trigger and perform a change
        /// of state. After, add to history the elements for the next iteration.
        List<WordHistory> fullList = List.of(history);
        final List<WordHistory> pagination =
            await _wordHistoryRepository.getHistory(event.offset);
        fullList.addAll(pagination);
        history.addAll(pagination);
        emit(WordHistoryState.loaded(fullList));
      } on Exception {
        emit(const WordHistoryState.error());
      }
    });

    on<WordHistoryEventRemoving>((event, emit) async {
      try {
        emit(const WordHistoryState.loading());
        final int code = await _wordHistoryRepository.removeAll();
        if (code == 0) {
          history.clear();
          emit(const WordHistoryState.loaded([]));
        } else {
          emit(const WordHistoryState.error());
        }
      } on Exception {
        emit(const WordHistoryState.error());
      }
    });
  }
}
