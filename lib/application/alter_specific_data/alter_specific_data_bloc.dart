import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/domain/alter_specific_data/alter_specific_data.dart';
import 'package:kanpractice/domain/alter_specific_data/i_alter_specific_data_repository.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/presentation/core/types/word_categories.dart';

part 'alter_specific_data_event.dart';
part 'alter_specific_data_state.dart';

part 'alter_specific_data_bloc.freezed.dart';

@lazySingleton
class AlterSpecificDataBloc
    extends Bloc<AlterSpecificDataEvent, AlterSpecificDataState> {
  final IAlterSpecificDataRepository _alterSpecificDataRepository;

  AlterSpecificDataBloc(this._alterSpecificDataRepository)
      : super(const AlterSpecificDataState.initial()) {
    on<AlterSpecificDataEventGatherTest>((event, emit) async {
      final data = await _alterSpecificDataRepository
          .getAlterSpecificTestData(event.test);
      emit(AlterSpecificDataState.testRetrieved(data, event.test));
    });
  }
}
