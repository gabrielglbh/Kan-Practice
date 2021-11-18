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
   on<KanjiEventLoading>((event, emit) async {
     try {
       emit(KanjiListDetailStateLoading());
       final lists = await KanjiQueries.instance.getAllKanjiFromList(event.list);
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