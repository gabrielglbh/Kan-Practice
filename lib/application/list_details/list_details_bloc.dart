import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/domain/list/i_list_repository.dart';

part 'list_details_event.dart';
part 'list_details_state.dart';

part 'list_details_bloc.freezed.dart';

@lazySingleton
class ListDetailsBloc extends Bloc<ListDetailsEvent, ListDetailsState> {
  final IListRepository _listRepository;

  ListDetailsBloc(this._listRepository)
      : super(const ListDetailsState.initial()) {
    on<ListDetailsEventIdle>((event, emit) async {
      emit(ListDetailsState.loaded(event.name));
    });

    on<ListDetailsUpdateName>((event, emit) async {
      emit(const ListDetailsState.loading());
      final error = await _listRepository
          .updateList(event.og, {ListTableFields.nameField: event.name});
      if (error == 0) {
        emit(ListDetailsState.loaded(event.name));
      } else {
        emit(const ListDetailsState.error());
      }
    });
  }
}
