import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/database/queries/list_queries.dart';

part 'lists_event.dart';
part 'lists_state.dart';

class KanjiListBloc extends Bloc<KanjiListEvent, KanjiListState> {
  KanjiListBloc() : super(KanjiListStateLoading()) {
    on<KanjiListEventLoading>((event, emit) async {
      try {
        emit(KanjiListStateLoading());
        final lists = await ListQueries.instance.getAllLists(
            filter: event.filter,
            order: _getSelectedOrder(event.order)
        );
        emit(KanjiListStateLoaded(lists: lists));
      } on Exception {
        emit(KanjiListStateFailure());
      }
    });

    on<KanjiListEventSearching>((event, emit) async {
      try {
        emit(KanjiListStateLoading());
        final lists = await ListQueries.instance.getListsMatchingQuery(event.query);
        emit(KanjiListStateLoaded(lists: lists));
      } on Exception {
        emit(KanjiListStateFailure());
      }
    });

    on<KanjiListEventDelete>((event, emit) async {
      if (state is KanjiListStateLoaded) {
        String name = event.list.name;
        final code = await ListQueries.instance.removeList(name);
        if (code == 0) {
          emit(KanjiListStateLoading());
          final lists = await ListQueries.instance.getAllLists(
              filter: event.filter,
              order: _getSelectedOrder(event.order)
          );
          emit(KanjiListStateLoaded(lists: lists));
        }
        else emit(KanjiListStateFailure());
      }
    });

    on<KanjiListEventCreate>((event, emit) async {
      if (state is KanjiListStateLoaded) {
        String? name = event.name;
        final code = await ListQueries.instance.createList(name);
        if (code == 0) {
          emit(KanjiListStateLoading());
          final lists = await ListQueries.instance.getAllLists(
              filter: event.filter,
              order: _getSelectedOrder(event.order)
          );
          emit(KanjiListStateLoaded(lists: lists));
        }
        else emit(KanjiListStateFailure());
      }
    });
  }

  String _getSelectedOrder(bool order) => order ? "DESC" : "ASC";
}