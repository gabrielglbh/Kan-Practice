import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/presentation/core/types/test_filters.dart';
import 'package:kanpractice/presentation/core/types/test_modes_filters.dart';
import 'package:kanpractice/domain/test_result/i_test_repository.dart';
import 'package:kanpractice/domain/test_result/test_result.dart';

part 'test_history_event.dart';
part 'test_history_state.dart';

part 'test_history_bloc.freezed.dart';

@lazySingleton
class TestHistoryBloc extends Bloc<TestHistoryEvent, TestHistoryState> {
  final ITestRepository _testRepository;

  TestHistoryBloc(this._testRepository)
      : super(const TestHistoryState.initial()) {
    on<TestHistoryEventLoading>((event, emit) async {
      try {
        final tests = await _testRepository.getTests(
          event.initial,
          event.last,
          event.testFilter,
          event.modesFilter,
        );
        emit(TestHistoryState.loaded(tests));
      } on Exception {
        emit(const TestHistoryState.error());
      }
    });

    on<TestHistoryEventRemoving>((event, emit) async {
      try {
        emit(const TestHistoryState.loading());
        final int code = await _testRepository.removeTests();
        if (code == 0) {
          emit(const TestHistoryState.loaded([]));
        } else {
          emit(const TestHistoryState.error());
        }
      } on Exception {
        emit(const TestHistoryState.error());
      }
    });
  }
}
