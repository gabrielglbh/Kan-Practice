import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/database/models/test_result.dart';
import 'package:kanpractice/core/database/queries/test_queries.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestListBloc extends Bloc<TestListEvent,TestListState> {
  TestListBloc() : super(TestListStateLoading()) {
    on<TestListEventLoading>((event, emit) async {
      try {
        emit(TestListStateLoading());
        final List<Test> list = await TestQueries.instance.getTests(0);
        emit(TestListStateLoaded(list));
      } on Exception {
        emit(TestListStateFailure());
      }
    });

    on<TestListEventRemoving>((event, emit) async {
      try {
        emit(TestListStateLoading());
        final int code = await TestQueries.instance.removeTests();
        if (code == 0) emit(TestListStateLoaded([]));
        else emit(TestListStateFailure());
      } on Exception {
        emit(TestListStateFailure());
      }
    });
  }
}