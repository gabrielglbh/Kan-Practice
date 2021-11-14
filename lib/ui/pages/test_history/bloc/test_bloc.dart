import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/database/models/test_result.dart';
import 'package:kanpractice/core/database/queries/test_queries.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestListBloc extends Bloc<TestListEvent,TestListState> {
  TestListBloc() : super(TestListStateLoading());

  @override
  Stream<TestListState> mapEventToState(TestListEvent event) async* {
    if (event is TestListEventLoading) yield* _mapLoadedToState(event);
    else if (event is TestListEventRemoving) yield* _mapRemovingToState(event);
  }

  Stream<TestListState> _mapLoadedToState(TestListEventLoading event) async* {
    try {
      yield TestListStateLoading();
      final List<Test> list = await TestQueries.instance.getTests(0);
      yield TestListStateLoaded(list);
    } on Exception {
      yield TestListStateFailure();
    }
  }

  Stream<TestListState> _mapRemovingToState(TestListEventRemoving event) async* {
    try {
      yield TestListStateLoading();
      final int code = await TestQueries.instance.removeTests();
      if (code == 0) yield TestListStateLoaded([]);
      else TestListStateFailure();
    } on Exception {
      yield TestListStateFailure();
    }
  }
}