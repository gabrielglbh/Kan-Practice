import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/domain/list/i_list_repository.dart';

part 'list_details_event.dart';
part 'list_details_state.dart';

@lazySingleton
class ListDetailBloc extends Bloc<ListDetailEvent, ListDetailState> {
  final IListRepository _listRepository;

  ListDetailBloc(this._listRepository) : super(ListDetailStateIdle()) {
    on<ListDetailEventIdle>((event, emit) async {
      emit(ListDetailStateLoaded(event.name));
    });

    on<ListDetailUpdateName>((event, emit) async {
      emit(ListDetailStateLoading());
      final error = await _listRepository
          .updateList(event.og, {ListTableFields.nameField: event.name});
      if (error == 0) {
        emit(ListDetailStateLoaded(event.name));
      } else {
        emit(const ListDetailStateFailure());
      }
    });
  }
}
