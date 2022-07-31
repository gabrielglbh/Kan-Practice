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
      var lists = await ListQueries.instance.getAllLists();
      if (event.folder != null) {
        final alreadyIncludedLists =
            await FolderQueries.instance.getAllListsOnFolder(event.folder!);
        final alreadyIncludedStrings = List.generate(
            alreadyIncludedLists.length, (x) => alreadyIncludedLists[x].name);
        emit(AddFolderStateAvailableKanLists(lists, alreadyIncludedStrings));
      } else {
        emit(AddFolderStateAvailableKanLists(lists, const []));
      }
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

    on<AddFolderEventOnListAddition>((event, emit) async {
      emit(AddFolderStateLoading());
      try {
        for (var l in event.kanLists) {
          final code =
              await FolderQueries.instance.moveKanListToFolder(event.folder, l);
          if (code != 0) throw Exception();
        }
        emit(AddFolderStateSuccess());
      } catch (e) {
        emit(AddFolderStateFailure("add_folder_insertion_error".tr()));
      }
    });
  }
}
