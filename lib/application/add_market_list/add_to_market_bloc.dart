import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/grammar_point/i_grammar_point_repository.dart';
import 'package:kanpractice/presentation/core/types/market_list_type.dart';
import 'package:kanpractice/domain/auth/i_auth_repository.dart';
import 'package:kanpractice/domain/folder/i_folder_repository.dart';
import 'package:kanpractice/domain/list/i_list_repository.dart';
import 'package:kanpractice/domain/market/i_market_repository.dart';
import 'package:kanpractice/domain/word/i_word_repository.dart';

part 'add_to_market_event.dart';
part 'add_to_market_state.dart';

part 'add_to_market_bloc.freezed.dart';

@injectable
class AddToMarketBloc extends Bloc<AddToMarketEvent, AddToMarketState> {
  final IAuthRepository _authRepository;
  final IMarketRepository _marketRepository;
  final IWordRepository _wordRepository;
  final IGrammarPointRepository _grammarPointRepository;
  final IListRepository _listRepository;
  final IFolderRepository _folderRepository;

  AddToMarketBloc(
    this._authRepository,
    this._marketRepository,
    this._wordRepository,
    this._grammarPointRepository,
    this._listRepository,
    this._folderRepository,
  ) : super(const AddToMarketState.initial()) {
    on<AddToMarketEventIdle>((event, emit) {
      final user = _authRepository.getUser();
      emit(AddToMarketState.userRetrieved(
          user?.displayName ?? user?.email?.split("@")[0] ?? ""));
    });

    on<AddToMarketEventOnUpload>((event, emit) async {
      emit(const AddToMarketState.loading());
      if (event.name == "add_to_market_select_list".tr() ||
          event.description.trim().isEmpty) {
        emit(AddToMarketState.error("add_to_market_validation_failed".tr()));
      } else {
        bool updated = true;
        if (event.author != _authRepository.getUser()?.displayName) {
          updated = await _authRepository.updateUserName(event.author);
        }

        if (event.author.isEmpty || !updated) {
          emit(AddToMarketState.error("add_to_market_validation_failed".tr()));
        } else {
          if (event.type == MarketListType.list) {
            final list = await _listRepository.getList(event.name);
            final words = await _wordRepository.getAllWordsFromList(event.name);
            final grammar = await _grammarPointRepository
                .getAllGrammarPointsFromList(event.name);

            if (words.isEmpty && grammar.isEmpty) {
              emit(AddToMarketState.error("add_to_market_word_empty".tr()));
            } else {
              final res = await _marketRepository.uploadListToMarketPlace(
                  event.listNameForMarket,
                  list,
                  event.language,
                  words,
                  grammar,
                  event.description);
              if (res == 0) {
                emit(const AddToMarketState.loaded());
              } else if (res == -2) {
                emit(AddToMarketState.error(
                    "add_to_market_authentication_failed".tr()));
              } else if (res == -3) {
                emit(AddToMarketState.error(
                    "add_to_market_already_uploaded".tr()));
              } else {
                emit(AddToMarketState.error(
                    "add_to_market_something_wrong".tr()));
              }
            }
          } else {
            final folder = await _folderRepository.getFolder(event.name);
            final lists =
                await _folderRepository.getAllListsOnFolder(event.name);
            final words = await _folderRepository
                .getAllWordsOnListsOnFolder([event.name]);
            final grammar = await _folderRepository
                .getAllGrammarPointsOnListsOnFolder([event.name]);

            if (words.isEmpty && grammar.isEmpty) {
              emit(AddToMarketState.error("add_to_market_word_empty".tr()));
            } else {
              final res = await _marketRepository.uploadFolderToMarketPlace(
                  event.listNameForMarket,
                  folder,
                  event.language,
                  lists,
                  words,
                  grammar,
                  event.description);
              if (res == 0) {
                emit(const AddToMarketState.loaded());
              } else if (res == -2) {
                emit(AddToMarketState.error(
                    "add_to_market_authentication_failed".tr()));
              } else if (res == -3) {
                emit(AddToMarketState.error(
                    "add_to_market_already_uploaded".tr()));
              } else {
                emit(AddToMarketState.error(
                    "add_to_market_something_wrong".tr()));
              }
            }
          }
        }
      }
    });
  }
}
