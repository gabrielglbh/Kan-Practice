import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/domain/test_data/i_test_data_repository.dart';
import 'package:kanpractice/domain/test_result/i_test_repository.dart';
import 'package:kanpractice/domain/test_result/test_result.dart';

part 'test_result_event.dart';
part 'test_result_state.dart';

@lazySingleton
class TestResultBloc extends Bloc<TestResultEvent, TestResultState> {
  final ITestRepository _testRepository;
  final ITestDataRepository _testDataRepository;

  TestResultBloc(
    this._testRepository,
    this._testDataRepository,
  ) : super(TestResultStateIdle()) {
    on<TestResultEventSaveTest>((event, emit) async {
      emit(TestResultStateSaving());
      await _testRepository.createTest(event.test);
      await _testDataRepository.updateStats(event.test);
      emit(TestResultStateSaved());
    });
  }
}
