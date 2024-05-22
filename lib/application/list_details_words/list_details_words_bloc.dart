import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/word/i_word_repository.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

part 'list_details_words_event.dart';
part 'list_details_words_state.dart';

part 'list_details_words_bloc.freezed.dart';

@lazySingleton
class ListDetailsWordsBloc
    extends Bloc<ListDetailsWordsEvent, ListDetailsWordsState> {
  final IWordRepository _wordRepository;

  ListDetailsWordsBloc(this._wordRepository)
      : super(const ListDetailsWordsState.initial()) {
    /// Maintain the list for pagination purposes
    List<Word> list = [];

    /// Maintain the list for pagination purposes on search
    List<Word> searchList = [];

    /// Loading offset for normal pagination
    int loadingTimes = 0;

    /// Loading offset for search bar list pagination
    int loadingTimesForSearch = 0;

    on<ListDetailsWordsEventLoading>((event, emit) async {
      try {
        loadingTimesForSearch = 0;
        if (event.reset) {
          emit(const ListDetailsWordsState.loading());
          list.clear();
          loadingTimes = 0;
        }

        const limit = LazyLoadingLimits.wordTileList;

        /// For every time we want to retrieve data, we need to instantiate
        /// a new list in order for Equatable to trigger and perform a change
        /// of state. After, add to list the elements for the next iteration.
        List<Word> fullList = List.of(list);
        final List<Word> pagination = await _wordRepository.getAllWordsFromList(
            event.list,
            offset: loadingTimes,
            limit: limit);
        fullList.addAll(pagination);
        list.addAll(pagination);
        loadingTimes += 1;
        emit(ListDetailsWordsState.loaded(fullList, event.list));
      } on Exception {
        emit(const ListDetailsWordsState.error(''));
      }
    });

    on<ListDetailsWordsEventSearching>((event, emit) async {
      try {
        loadingTimes = 0;
        if (event.reset) {
          emit(const ListDetailsWordsState.loading());
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
                listName: event.list,
                offset: loadingTimesForSearch,
                limit: limit);
        fullList.addAll(pagination);
        searchList.addAll(pagination);
        loadingTimesForSearch += 1;
        emit(ListDetailsWordsState.loaded(fullList, event.list));
      } on Exception {
        emit(const ListDetailsWordsState.error(''));
      }
    });

    on<ListDetailsWordsEventLoadUpPractice>((event, emit) async {
      try {
        final List<Word> allList =
            await _wordRepository.getAllWordsFromList(event.list);
        if (allList.isNotEmpty) {
          allList.shuffle();
          List<Word> list = allList;
          emit(ListDetailsWordsState.practiceLoaded(event.studyMode, list));
        } else {
          emit(ListDetailsWordsState.error(
              "list_details_loadUpPractice_failed".tr()));
        }
      } on Exception {
        emit(const ListDetailsWordsState.error(''));
      }
    });
  }
}
