import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/database/models/test_result.dart';
import 'package:kanpractice/core/database/queries/test_queries.dart';
import 'package:kanpractice/core/types/study_modes_filters.dart';
import 'package:kanpractice/core/types/test_modes_filters.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestListBloc extends Bloc<TestListEvent, TestListState> {
  TestListBloc() : super(TestListStateLoading()) {
    on<TestListEventIdle>((_, __) {});

    on<TestListEventLoading>((event, emit) async {
      try {
        final tests = await TestQueries.instance.getTests(
          event.initial,
          event.last,
          event.testFilter,
          event.modesFilter,
        );
        emit(TestListStateLoaded(tests));
      } on Exception {
        emit(TestListStateFailure());
      }
    });

    on<TestListEventRemoving>((event, emit) async {
      try {
        emit(TestListStateLoading());
        final int code = await TestQueries.instance.removeTests();
        if (code == 0) {
          emit(const TestListStateLoaded([]));
        } else {
          emit(TestListStateFailure());
        }
      } on Exception {
        emit(TestListStateFailure());
      }
    });
  }
}
