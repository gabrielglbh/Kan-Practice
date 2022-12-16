import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/word/i_word_repository.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

part 'list_details_words_event.dart';
part 'list_details_words_state.dart';

@lazySingleton
class ListDetailWordsBloc
    extends Bloc<ListDetailWordsEvent, ListDetailWordsState> {
  final IWordRepository _wordRepository;

  ListDetailWordsBloc(this._wordRepository)
      : super(ListDetailWordsStateIdle()) {
    /// Maintain the list for pagination purposes
    List<Word> list = [];

    /// Maintain the list for pagination purposes on search
    List<Word> searchList = [];
    const int limit = LazyLoadingLimits.wordList;

    /// Loading offset for normal pagination
    int loadingTimes = 0;

    /// Loading offset for search bar list pagination
    int loadingTimesForSearch = 0;

    on<ListDetailWordsEventLoading>((event, emit) async {
      try {
        loadingTimesForSearch = 0;
        if (event.reset) {
          emit(ListDetailWordsStateLoading());
          list.clear();
          loadingTimes = 0;
        }

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
        emit(ListDetailWordsStateLoaded(fullList, event.list));
      } on Exception {
        emit(const ListDetailWordsStateFailure());
      }
    });

    on<ListDetailWordsEventSearching>((event, emit) async {
      try {
        loadingTimes = 0;
        if (event.reset) {
          emit(ListDetailWordsStateLoading());
          searchList.clear();
          loadingTimesForSearch = 0;
        }

        /// For every time we want to retrieve data, we need to instantiate
        /// a new list in order for Equatable to trigger and perform a change
        /// of state. After, add to list the elements for the next iteration.
        List<Word> fullList = List.of(searchList);
        final List<Word> pagination =
            await _wordRepository.getWordsMatchingQuery(event.query, event.list,
                offset: loadingTimesForSearch, limit: limit);
        fullList.addAll(pagination);
        searchList.addAll(pagination);
        loadingTimesForSearch += 1;
        emit(ListDetailWordsStateLoaded(fullList, event.list));
      } on Exception {
        emit(const ListDetailWordsStateFailure());
      }
    });

    on<ListDetailWordsEventLoadUpPractice>((event, emit) async {
      try {
        final List<Word> allList =
            await _wordRepository.getAllWordsFromList(event.list);
        if (allList.isNotEmpty) {
          allList.shuffle();
          List<Word> list = allList;
          emit(ListDetailWordsStateLoadedPractice(event.studyMode, list));
        } else {
          emit(ListDetailWordsStateFailure(
              error: "list_details_loadUpPractice_failed".tr()));
        }
      } on Exception {
        emit(const ListDetailWordsStateFailure());
      }
    });
  }
}
