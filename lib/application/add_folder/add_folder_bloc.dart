import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/folder/i_folder_repository.dart';
import 'package:kanpractice/domain/list/i_list_repository.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/domain/relation_folder_list/i_relation_folder_list_repository.dart';

part 'add_folder_event.dart';
part 'add_folder_state.dart';

@lazySingleton
class AddFolderBloc extends Bloc<AddFolderEvent, AddFolderState> {
  final IListRepository _listRepository;
  final IFolderRepository _folderRepository;
  final IRelationFolderListRepository _relationFolderListRepository;

  AddFolderBloc(
    this._listRepository,
    this._folderRepository,
    this._relationFolderListRepository,
  ) : super(AddFolderStateInitial()) {
    on<AddFolderEventIdle>((event, emit) async {
      var lists = await _listRepository.getAllLists();
      final map = {for (var k in lists) k.name: false};

      if (event.folder != null) {
        final alreadyIncludedLists =
            await _folderRepository.getAllListsOnFolder(event.folder!);
        final alreadyIncludedStrings = List.generate(
            alreadyIncludedLists.length, (x) => alreadyIncludedLists[x].name);

        for (var a in alreadyIncludedStrings) {
          if (map.containsKey(a)) map[a] = true;
        }
        emit(AddFolderStateAvailableKanLists(lists, map));
      } else {
        emit(AddFolderStateAvailableKanLists(lists, map));
      }
    });

    on<AddFolderEventOnUpload>((event, emit) async {
      emit(AddFolderStateLoading());
      if (event.folder.trim().isEmpty) {
        emit(AddFolderStateFailure("add_folder_name_error".tr()));
      } else {
        final List<String> map = [];
        event.kanLists.forEach((key, value) {
          if (value) map.add(key);
        });
        final code =
            await _folderRepository.createFolder(event.folder, lists: map);
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
        event.kanLists.forEach((key, value) {
          if (value) {
            _createRelation(event.folder, key);
          } else {
            _removeRelation(event.folder, key);
          }
        });
        emit(AddFolderStateSuccess());
      } catch (e) {
        emit(AddFolderStateFailure("add_folder_insertion_error".tr()));
      }
    });
  }

  Future<void> _createRelation(String f, String l) async {
    final code = await _relationFolderListRepository.moveListToFolder(f, l);
    if (code != 0) throw Exception();
  }

  Future<void> _removeRelation(String f, String l) async {
    final code = await _relationFolderListRepository.removeListToFolder(f, l);
    if (code != 0) throw Exception();
  }
}
