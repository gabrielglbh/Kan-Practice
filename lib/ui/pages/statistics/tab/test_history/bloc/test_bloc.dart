import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:kanpractice/core/database/models/test_result.dart';
import 'package:kanpractice/core/database/queries/test_queries.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestListBloc extends Bloc<TestListEvent, TestListState> {
  TestListBloc() : super(TestListStateLoading()) {
    /// Maintain the list for pagination purposes
    Map<String, List<Test>> list = {};

    on<TestListEventIdle>((_, __) {});

    on<TestListEventLoading>((event, emit) async {
      try {
        if (event.offset == 0) {
          emit(TestListStateLoading());
          list.clear();
        }

        /// For every time we want to retrieve data, we need to instantiate
        /// a new list in order for Equatable to trigger and perform a change
        /// of state. After, add to list the elements for the next iteration.
        final fullList = Map.of(list);
        final pagination = await TestQueries.instance.getTests(event.offset);
        final groupedPagination = groupBy(
          pagination,
          (Test test) {
            final format = DateFormat('dd/MM/yyyy');
            final date = DateTime.fromMillisecondsSinceEpoch(test.takenDate);
            return format.format(date);
          },
        );
        fullList.addAll(groupedPagination);
        list.addAll(groupedPagination);

        emit(TestListStateLoaded(fullList));
      } on Exception {
        emit(TestListStateFailure());
      }
    });

    on<TestListEventRemoving>((event, emit) async {
      try {
        emit(TestListStateLoading());
        final int code = await TestQueries.instance.removeTests();
        if (code == 0) {
          list.clear();
          emit(const TestListStateLoaded({}));
        } else {
          emit(TestListStateFailure());
        }
      } on Exception {
        emit(TestListStateFailure());
      }
    });
  }
}
