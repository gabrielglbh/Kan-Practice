import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/database/models/test_result.dart';
import 'package:kanpractice/core/database/queries/test_queries.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestListBloc extends Bloc<TestListEvent, TestListState> {
  TestListBloc() : super(TestListStateLoading()) {
    /// Maintain the list for pagination purposes
    List<Test> list = [];

    on<TestListEventLoading>((event, emit) async {
      try {
        if (event.offset == 0) {
          emit(TestListStateLoading());
          list.clear();
        }

        /// For every time we want to retrieve data, we need to instantiate
        /// a new list in order for Equatable to trigger and perform a change
        /// of state. After, add to list the elements for the next iteration.
        List<Test> fullList = List.of(list);
        final List<Test> pagination =
            await TestQueries.instance.getTests(event.offset);
        fullList.addAll(pagination);
        list.addAll(pagination);
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
