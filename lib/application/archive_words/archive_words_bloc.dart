import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/word/i_word_repository.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/presentation/core/types/word_categories_filters.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

part 'archive_words_event.dart';
part 'archive_words_state.dart';

part 'archive_words_bloc.freezed.dart';

@lazySingleton
class ArchiveWordsBloc extends Bloc<ArchiveWordsEvent, ArchiveWordsState> {
  final IWordRepository _wordRepository;

  ArchiveWordsBloc(this._wordRepository)
      : super(const ArchiveWordsState.initial()) {
    /// Maintain the list for pagination purposes
    List<Word> list = [];

    /// Maintain the list for pagination purposes on search
    List<Word> searchList = [];

    /// Loading offset for normal pagination
    int loadingTimes = 0;

    /// Loading offset for search bar list pagination
    int loadingTimesForSearch = 0;

    on<ArchiveWordsEventLoading>((event, emit) async {
      try {
        loadingTimesForSearch = 0;
        if (event.reset) {
          emit(const ArchiveWordsState.loading());
          list.clear();
          loadingTimes = 0;
        }

        const limit = LazyLoadingLimits.wordTileList;

        /// For every time we want to retrieve data, we need to instantiate
        /// a new list in order for Equatable to trigger and perform a change
        /// of state. After, add to list the elements for the next iteration.
        List<Word> fullList = List.of(list);
        final List<Word> pagination = await _wordRepository.getArchiveWords(
          filter: event.filter,
          order: _getSelectedOrder(event.order),
          offset: loadingTimes,
          limit: limit,
        );
        fullList.addAll(pagination);
        list.addAll(pagination);
        loadingTimes += 1;
        emit(ArchiveWordsState.loaded(fullList));
      } on Exception {
        emit(const ArchiveWordsState.error());
      }
    });

    on<ArchiveWordsEventSearching>((event, emit) async {
      try {
        loadingTimes = 0;
        if (event.reset) {
          emit(const ArchiveWordsState.loading());
          searchList.clear();
          loadingTimesForSearch = 0;
        }

        const limit = LazyLoadingLimits.wordTileList;

        /// For every time we want to retrieve data, we need to instantiate
        /// a new list in order for Equatable to trigger and perform a change
        /// of state. After, add to list the elements for the next iteration.
        List<Word> fullList = List.of(searchList);
        final List<Word> pagination =
            await _wordRepository.getWordsMatchingQuery(event.query,
                offset: loadingTimesForSearch, limit: limit);
        fullList.addAll(pagination);
        searchList.addAll(pagination);
        loadingTimesForSearch += 1;
        emit(ArchiveWordsState.loaded(fullList));
      } on Exception {
        emit(const ArchiveWordsState.error());
      }
    });
  }

  String _getSelectedOrder(bool order) => order ? "DESC" : "ASC";
}
