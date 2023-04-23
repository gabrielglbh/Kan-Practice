import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/domain/folder/i_folder_repository.dart';
import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/domain/grammar_point/i_grammar_point_repository.dart';
import 'package:kanpractice/domain/services/i_preferences_repository.dart';
import 'package:kanpractice/presentation/core/types/grammar_modes.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

part 'grammar_test_event.dart';
part 'grammar_test_state.dart';

part 'grammar_test_bloc.freezed.dart';

@lazySingleton
class GrammarTestBloc extends Bloc<GrammarTestEvent, GrammarTestState> {
  final IGrammarPointRepository _grammarPointRepository;
  final IFolderRepository _folderRepository;
  final IPreferencesRepository _preferencesRepository;

  GrammarTestBloc(
    this._grammarPointRepository,
    this._folderRepository,
    this._preferencesRepository,
  ) : super(const GrammarTestState.initial([])) {
    on<GrammarTestEventIdle>((event, emit) async {
      if (event.mode == Tests.daily) {
        final grammarToReview =
            await _grammarPointRepository.getSM2ReviewGrammarPointsAsForToday();
        emit(GrammarTestState.initial(grammarToReview));
      } else {
        emit(const GrammarTestState.initial([]));
      }
    });

    on<GrammarTestEventLoadList>((event, emit) async {
      List<GrammarPoint> finalList = [];

      if (event.practiceList == null) {
        if (event.type == Tests.folder ||
            (event.type == Tests.blitz && event.folder != null)) {
          final folders = event.folder == null
              ? event.selectionQuery ?? []
              : [event.folder!];
          finalList =
              await _folderRepository.getAllGrammarPointsOnListsOnFolder(
            folders,
          );
          finalList.shuffle();
        } else if ((event.type == Tests.time || event.type == Tests.less) &&
            event.folder != null) {
          finalList =
              await _folderRepository.getAllGrammarPointsOnListsOnFolder(
            [event.folder!],
            mode: event.mode,
            type: event.type,
          );
        } else if (event.type == Tests.daily) {
          finalList = await _grammarPointRepository
              .getDailySM2GrammarPoints(event.mode);
        } else if (event.type == Tests.lists) {
          finalList = await _grammarPointRepository
              .getGrammarPointBasedOnSelectedLists(event.selectionQuery ?? []);
          finalList.shuffle();
        } else {
          List<GrammarPoint> list = await _grammarPointRepository
              .getAllGrammarPoints(mode: event.mode, type: event.type);

          /// If it is a remembrance or less % test, do NOT shuffle the list
          if (event.type != Tests.time && event.type != Tests.less) {
            list.shuffle();
          }
          finalList = list;
        }
      }

      /// If the listName is not empty, it means that the user wants to have
      /// a Blitz Test on a certain KanList defined in "listName"
      else {
        List<GrammarPoint> list = await _grammarPointRepository
            .getAllGrammarPointsFromList(event.practiceList!);
        list.shuffle();
        finalList = list;
      }

      final controlledPace =
          _preferencesRepository.readData(SharedKeys.dailyTestOnControlledPace);
      if (event.type == Tests.daily && controlledPace == true) {
        emit(GrammarTestState.loaded(finalList, event.mode));
      } else {
        final gpInTest =
            _preferencesRepository.readData(SharedKeys.numberOfWordInTest) ??
                KPSizes.numberOfWordInTest;

        List<GrammarPoint> sortedList = finalList.sublist(
            0, finalList.length < gpInTest ? finalList.length : gpInTest);

        emit(GrammarTestState.loaded(sortedList, event.mode));
      }
    });
  }
}
