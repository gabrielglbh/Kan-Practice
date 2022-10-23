import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/core/types/study_modes_filters.dart';
import 'package:kanpractice/core/types/test_modes_filters.dart';
import 'package:kanpractice/domain/test_result/test_result.dart';
import 'package:kanpractice/infrastructure/test_result/test_result_repository_impl.dart';
import 'package:kanpractice/injection.dart';

part 'test_history_event.dart';
part 'test_history_state.dart';

@lazySingleton
class TestHistoryBloc extends Bloc<TestHistoryEvent, TestHistoryState> {
  TestHistoryBloc() : super(TestHistoryStateLoading()) {
    on<TestHistoryEventIdle>((_, __) {});

    on<TestHistoryEventLoading>((event, emit) async {
      try {
        final tests = await getIt<TestResultRepositoryImpl>().getTests(
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
        final int code = await getIt<TestResultRepositoryImpl>().removeTests();
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
