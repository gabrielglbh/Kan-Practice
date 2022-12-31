import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/presentation/core/types/test_filters.dart';
import 'package:kanpractice/presentation/core/types/test_modes_filters.dart';
import 'package:kanpractice/domain/test_result/i_test_repository.dart';
import 'package:kanpractice/domain/test_result/test_result.dart';

part 'test_history_event.dart';
part 'test_history_state.dart';

@lazySingleton
class TestHistoryBloc extends Bloc<TestHistoryEvent, TestHistoryState> {
  final ITestRepository _testRepository;

  TestHistoryBloc(this._testRepository) : super(TestHistoryStateIdle()) {
    on<TestHistoryEventLoading>((event, emit) async {
      try {
        final tests = await _testRepository.getTests(
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
        final int code = await _testRepository.removeTests();
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
