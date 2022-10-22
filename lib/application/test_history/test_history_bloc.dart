import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/database/models/test_result.dart';
import 'package:kanpractice/core/database/queries/test_queries.dart';
import 'package:kanpractice/core/types/study_modes_filters.dart';
import 'package:kanpractice/core/types/test_modes_filters.dart';

part 'test_history_event.dart';
part 'test_history_state.dart';

class TestHistoryBloc extends Bloc<TestHistoryEvent, TestHistoryState> {
  TestHistoryBloc() : super(TestHistoryStateLoading()) {
    on<TestHistoryEventIdle>((_, __) {});

    on<TestHistoryEventLoading>((event, emit) async {
      try {
        final tests = await TestQueries.instance.getTests(
          event.initial,
          event.last,
          event.testFilter,
          event.modesFilter,
        );
        emit(TestHistoryStateLoaded(tests));
      } on Exception {
        emit(TestHistoryStateFailure());
      }
    });

    on<TestHistoryEventRemoving>((event, emit) async {
      try {
        emit(TestHistoryStateLoading());
        final int code = await TestQueries.instance.removeTests();
        if (code == 0) {
          emit(const TestHistoryStateLoaded([]));
        } else {
          emit(TestHistoryStateFailure());
        }
      } on Exception {
        emit(TestHistoryStateFailure());
      }
    });
  }
}
