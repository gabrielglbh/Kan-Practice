import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/database/models/word_history.dart';
import 'package:kanpractice/core/database/queries/word_history_queries.dart';

part 'word_history_event.dart';
part 'word_history_state.dart';

class WordHistoryBloc extends Bloc<WordHistoryEvent, WordHistoryState> {
  WordHistoryBloc() : super(WordHistoryStateLoading()) {
    /// Maintain the history for pagination purposes
    List<WordHistory> history = [];

    on<WordHistoryEventLoading>((event, emit) async {
      try {
        if (event.offset == 0) {
          emit(WordHistoryStateLoading());
          history.clear();
        }

        /// For every time we want to retrieve data, we need to instantiate
        /// a new history in order for Equatable to trigger and perform a change
        /// of state. After, add to history the elements for the next iteration.
        List<WordHistory> fullList = List.of(history);
        final List<WordHistory> pagination =
            await WordHistoryQueries.instance.getHistory(event.offset);
        fullList.addAll(pagination);
        history.addAll(pagination);
        emit(WordHistoryStateLoaded(fullList));
      } on Exception {
        emit(WordHistoryStateFailure());
      }
    });

    on<WordHistoryEventRemoving>((event, emit) async {
      try {
        emit(WordHistoryStateLoading());
        final int code = await WordHistoryQueries.instance.removeAll();
        if (code == 0) {
          history.clear();
          emit(const WordHistoryStateLoaded([]));
        } else {
          emit(WordHistoryStateFailure());
        }
      } on Exception {
        emit(WordHistoryStateFailure());
      }
    });
  }
}