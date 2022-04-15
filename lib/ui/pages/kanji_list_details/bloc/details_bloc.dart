import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/database/queries/list_queries.dart';
import 'package:kanpractice/core/utils/types/learning_mode.dart';
import 'package:kanpractice/core/utils/types/study_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/ui/theme/consts.dart';

part 'details_event.dart';
part 'details_state.dart';

class KanjiListDetailBloc extends Bloc<KanjiListDetailEvent, KanjiListDetailState> {
  KanjiListDetailBloc() : super(KanjiListDetailStateLoading()) {
   /// Maintain the list for pagination purposes
   List<Kanji> _list = [];
   /// Maintain the list for pagination purposes on search
   List<Kanji> _searchList = [];
   final int _limit = LazyLoadingLimits.wordList;

   on<KanjiEventLoading>((event, emit) async {
     try {
       if (event.offset == 0) {
         emit(KanjiListDetailStateLoading());
         _list.clear();
       }
       /// For every time we want to retrieve data, we need to instantiate
       /// a new list in order for Equatable to trigger and perform a change
       /// of state. After, add to _list the elements for the next iteration.
       List<Kanji> fullList = List.of(_list);
       final List<Kanji> pagination = await KanjiQueries.instance.getAllKanjiFromList(
           event.list, offset: event.offset, limit: _limit);
       fullList.addAll(pagination);
       _list.addAll(pagination);
       emit(KanjiListDetailStateLoaded(fullList, event.list));
     } on Exception {
       emit(KanjiListDetailStateFailure());
     }
   });

   on<KanjiEventSearching>((event, emit) async {
     try {
       if (event.offset == 0) {
         emit(KanjiListDetailStateLoading());
         _searchList.clear();
       }
       /// For every time we want to retrieve data, we need to instantiate
       /// a new list in order for Equatable to trigger and perform a change
       /// of state. After, add to _list the elements for the next iteration.
       List<Kanji> fullList = List.of(_searchList);
       final List<Kanji> pagination = await KanjiQueries.instance.getKanjiMatchingQuery(
           event.query, event.list, offset: event.offset, limit: _limit);
       fullList.addAll(pagination);
       _searchList.addAll(pagination);
       emit(KanjiListDetailStateLoaded(fullList, event.list));
     } on Exception {
       emit(KanjiListDetailStateFailure());
     }
   });

   on<UpdateKanList>((event, emit) async {
     emit(KanjiListDetailStateLoading());
     final error = await ListQueries.instance.updateList(event.og, {
       KanListTableFields.nameField: event.name
     });
     if (error == 0) {
       /// When updating the list's name, reset any pagination offset
       /// to load up from the start
       final List<Kanji> lists = await KanjiQueries.instance.getAllKanjiFromList(
           event.name, limit: _limit, offset: 0
       );
       /// Clear the _list and repopulate it with the newest items for KanjiListEventLoading
       /// to work properly for the next offset
       _list.clear();
       _list.addAll(lists);
       emit(KanjiListDetailStateLoaded(lists, event.name));
     }
     else emit(KanjiListDetailStateFailure());
   });

   on<KanjiEventLoadUpPractice>((event, emit) async {
     try {
       final List<Kanji> allList = await KanjiQueries.instance.getAllKanjiFromList(event.list);
       if (allList.length != 0) {
         /// Enable spatial learning, first elements are the ones with less %
         List<Kanji> list = [];
         switch (event.mode) {
           case LearningMode.spatial:
             list = await KanjiQueries.instance.getAllKanjiForPractice(event.list, event.studyMode);
             break;
           case LearningMode.random:
             allList.shuffle();
             list = allList;
             break;
         }
         emit(KanjiListDetailStateLoadedPractice(event.studyMode, list));
       }
       else emit(KanjiListDetailStateFailure(error: "list_details_loadUpPractice_failed".tr()));
     } on Exception {
       emit(KanjiListDetailStateFailure());
     }
   });
  }
}