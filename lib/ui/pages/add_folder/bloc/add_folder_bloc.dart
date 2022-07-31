import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/database/queries/folder_queries.dart';
import 'package:kanpractice/core/database/queries/list_queries.dart';

part 'add_folder_event.dart';
part 'add_folder_state.dart';

class AddFolderBloc extends Bloc<AddFolderEvent, AddFolderState> {
  AddFolderBloc() : super(AddFolderStateInitial()) {
    on<AddFolderEventIdle>((event, emit) async {
      final lists = await ListQueries.instance.getAllLists();
      emit(AddFolderStateAvailableKanLists(lists));
    });

    on<AddFolderEventOnUpload>((event, emit) async {
      emit(AddFolderStateLoading());
      if (event.folder.trim().isEmpty) {
        emit(AddFolderStateFailure("add_folder_name_error".tr()));
      } else {
        final code = await FolderQueries.instance
            .createFolder(event.folder, kanLists: event.kanLists);
        if (code == 0) {
          emit(AddFolderStateSuccess());
        } else {
          emit(AddFolderStateFailure("add_folder_insertion_error".tr()));
        }
      }
    });
  }
}
