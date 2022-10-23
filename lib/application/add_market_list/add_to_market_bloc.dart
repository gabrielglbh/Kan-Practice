import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/core/types/market_list_type.dart';
import 'package:kanpractice/infrastructure/auth/auth_repository_impl.dart';
import 'package:kanpractice/infrastructure/folder/folder_repository_impl.dart';
import 'package:kanpractice/infrastructure/list/list_repository_impl.dart';
import 'package:kanpractice/infrastructure/market/market_repository_impl.dart';
import 'package:kanpractice/infrastructure/word/word_repository_impl.dart';
import 'package:kanpractice/injection.dart';

part 'add_to_market_event.dart';
part 'add_to_market_state.dart';

@lazySingleton
class AddToMarketBloc extends Bloc<AddToMarketEvent, AddToMarketState> {
  AddToMarketBloc() : super(AddToMarketStateInitial()) {
    on<AddToMarketEventIdle>((event, emit) {
      final user = getIt<AuthRepositoryImpl>().getUser();
      emit(AddToMarketStateGetUser(
          user?.displayName ?? user?.email?.split("@")[0] ?? ""));
    });

    on<AddToMarketEventOnUpload>((event, emit) async {
      emit(AddToMarketStateLoading());
      if (event.name == "add_to_market_select_list".tr() ||
          event.description.trim().isEmpty) {
        emit(AddToMarketStateFailure("add_to_market_validation_failed".tr()));
      } else {
        bool updated = true;
        if (event.author !=
            getIt<AuthRepositoryImpl>().getUser()?.displayName) {
          updated =
              await getIt<AuthRepositoryImpl>().updateUserName(event.author);
        }

        if (event.author.isEmpty || !updated) {
          emit(AddToMarketStateFailure("add_to_market_validation_failed".tr()));
        } else {
          if (event.type == MarketListType.list) {
            final list = await getIt<ListRepositoryImpl>().getList(event.name);
            final kanji = await getIt<WordRepositoryImpl>()
                .getAllWordsFromList(event.name);

            if (kanji.isEmpty) {
              emit(AddToMarketStateFailure("add_to_market_kanji_empty".tr()));
            } else {
              final res = await getIt<MarketRepositoryImpl>()
                  .uploadListToMarketPlace(
                      event.listNameForMarket, list, kanji, event.description);
              if (res == 0) {
                emit(AddToMarketStateSuccess());
              } else if (res == -2) {
                emit(AddToMarketStateFailure(
                    "add_to_market_authentication_failed".tr()));
              } else if (res == -3) {
                emit(AddToMarketStateFailure(
                    "add_to_market_already_uploaded".tr()));
              } else {
                emit(AddToMarketStateFailure(
                    "add_to_market_something_wrong".tr()));
              }
            }
          } else {
            final folder =
                await getIt<FolderRepositoryImpl>().getFolder(event.name);
            final lists = await getIt<FolderRepositoryImpl>()
                .getAllListsOnFolder(event.name);
            final kanji = await getIt<FolderRepositoryImpl>()
                .getAllWordsOnListsOnFolder([event.name]);

            if (kanji.isEmpty) {
              emit(AddToMarketStateFailure("add_to_market_kanji_empty".tr()));
            } else {
              final res = await getIt<MarketRepositoryImpl>()
                  .uploadFolderToMarketPlace(event.listNameForMarket, folder,
                      lists, kanji, event.description);
              if (res == 0) {
                emit(AddToMarketStateSuccess());
              } else if (res == -2) {
                emit(AddToMarketStateFailure(
                    "add_to_market_authentication_failed".tr()));
              } else if (res == -3) {
                emit(AddToMarketStateFailure(
                    "add_to_market_already_uploaded".tr()));
              } else {
                emit(AddToMarketStateFailure(
                    "add_to_market_something_wrong".tr()));
              }
            }
          }
        }
      }
    });
  }
}
