import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/database/queries/list_queries.dart';

part 'lists_event.dart';
part 'lists_state.dart';

class KanjiListBloc extends Bloc<KanjiListEvent, KanjiListState> {
  KanjiListBloc() : super(KanjiListStateLoading());

  @override
  Stream<KanjiListState> mapEventToState(KanjiListEvent event) async* {
    if (event is KanjiListEventLoading) yield* _mapLoadedToState(event);
    else if (event is KanjiListEventSearching) yield* _mapSearchingToState(event);
    else if (event is KanjiListEventDelete) yield* _mapDeletedToState(event);
    else if (event is KanjiListEventCreate) yield* _mapCreatedToState(event);
  }

  Stream<KanjiListState> _mapLoadedToState(KanjiListEventLoading event) async* {
    try {
      yield KanjiListStateLoading();
      final lists = await ListQueries.instance.getAllLists(
        filter: event.filter,
        order: _getSelectedOrder(event.order)
      );
      yield KanjiListStateLoaded(lists: lists);
    } on Exception {
      yield KanjiListStateFailure();
    }
  }

  Stream<KanjiListState> _mapSearchingToState(KanjiListEventSearching event) async* {
    try {
      yield KanjiListStateLoading();
      final lists = await ListQueries.instance.getListsMatchingQuery(event.query);
      yield KanjiListStateLoaded(lists: lists);
    } on Exception {
      yield KanjiListStateFailure();
    }
  }

  Stream<KanjiListState> _mapCreatedToState(KanjiListEventCreate event) async* {
    if (state is KanjiListStateLoaded) {
      String? name = event.name;
      final code = await ListQueries.instance.createList(name);
      if (code == 0) {
        yield KanjiListStateLoading();
        final lists = await ListQueries.instance.getAllLists(
          filter: event.filter,
          order: _getSelectedOrder(event.order)
        );
        yield KanjiListStateLoaded(lists: lists);
      }
      else KanjiListStateFailure();
    }
  }

  Stream<KanjiListState> _mapDeletedToState(KanjiListEventDelete event) async* {
    if (state is KanjiListStateLoaded) {
      String name = event.list.name;
      final code = await ListQueries.instance.removeList(name);
      if (code == 0) {
        yield KanjiListStateLoading();
        final lists = await ListQueries.instance.getAllLists(
          filter: event.filter,
          order: _getSelectedOrder(event.order)
        );
        yield KanjiListStateLoaded(lists: lists);
      }
      else KanjiListStateFailure();
    }
  }

  String _getSelectedOrder(bool order) => order ? "DESC" : "ASC";
}