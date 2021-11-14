import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';

part 'details_event.dart';
part 'details_state.dart';

class KanjiListDetailBloc extends Bloc<KanjiListDetailEvent, KanjiListDetailState> {
  KanjiListDetailBloc() : super(KanjiListDetailStateLoading());

  @override
  Stream<KanjiListDetailState> mapEventToState(KanjiListDetailEvent event) async* {
    if (event is KanjiEventLoading) yield* _mapLoadedToState(event);
  }

  Stream<KanjiListDetailState> _mapLoadedToState(KanjiEventLoading event) async* {
    try {
      final lists = await KanjiQueries.instance.getAllKanjiFromList(event.list);
      yield KanjiListDetailStateLoaded(lists);
    } on Exception {
      yield KanjiListDetailStateFailure();
    }
  }
}