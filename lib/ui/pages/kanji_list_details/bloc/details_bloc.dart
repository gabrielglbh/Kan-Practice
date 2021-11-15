import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/database/queries/list_queries.dart';

part 'details_event.dart';
part 'details_state.dart';

class KanjiListDetailBloc extends Bloc<KanjiListDetailEvent, KanjiListDetailState> {
  KanjiListDetailBloc() : super(KanjiListDetailStateLoading());

  @override
  Stream<KanjiListDetailState> mapEventToState(KanjiListDetailEvent event) async* {
    if (event is KanjiEventLoading) yield* _mapLoadedToState(event);
    else if (event is UpdateKanList) yield* _mapUpdateNameToState(event);
  }

  Stream<KanjiListDetailState> _mapLoadedToState(KanjiEventLoading event) async* {
    try {
      yield KanjiListDetailStateLoading();
      final lists = await KanjiQueries.instance.getAllKanjiFromList(event.list);
      yield KanjiListDetailStateLoaded(lists, event.list);
    } on Exception {
      yield KanjiListDetailStateFailure();
    }
  }

  Stream<KanjiListDetailState> _mapUpdateNameToState(UpdateKanList event) async* {
    yield KanjiListDetailStateLoading();
    final error = await ListQueries.instance.updateList(event.og, {
      KanListTableFields.nameField: event.name
    });
    if (error == 0) {
      final lists = await KanjiQueries.instance.getAllKanjiFromList(event.name);
      yield KanjiListDetailStateLoaded(lists, event.name);
    }
    else yield KanjiListDetailStateFailure();
  }
}