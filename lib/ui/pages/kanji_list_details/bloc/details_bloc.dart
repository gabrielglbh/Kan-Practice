import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/database/queries/list_queries.dart';

part 'details_event.dart';
part 'details_state.dart';

class KanjiListDetailBloc extends Bloc<KanjiListDetailEvent, KanjiListDetailState> {
  KanjiListDetailBloc() : super(KanjiListDetailStateLoading()) {
    /// Maintain the list for pagination purposes
   List<Kanji> _list = [];

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
           event.list, offset: event.offset, limit: 75);
       fullList.addAll(pagination);
       _list.addAll(pagination);
       emit(KanjiListDetailStateLoaded(fullList, event.list));
     } on Exception {
       emit(KanjiListDetailStateFailure());
     }
   });

   on<KanjiEventSearching>((event, emit) async {
     try {
       emit(KanjiListDetailStateLoading());
       final lists = await KanjiQueries.instance.getKanjiMatchingQuery(event.query);
       emit(KanjiListDetailStateLoaded(lists, event.list));
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
       final lists = await KanjiQueries.instance.getAllKanjiFromList(event.name);
       emit(KanjiListDetailStateLoaded(lists, event.name));
     }
     else emit(KanjiListDetailStateFailure());
   });
  }
}