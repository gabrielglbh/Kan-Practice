import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/application/services/database/database_consts.dart';
import 'package:kanpractice/domain/list/i_list_repository.dart';
import 'package:kanpractice/domain/word/i_word_repository.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';

part 'study_mode_event.dart';
part 'study_mode_state.dart';

@lazySingleton
class StudyModeBloc extends Bloc<StudyModeEvent, StudyModeState> {
  final IWordRepository _wordRepository;
  final IListRepository _listRepository;

  StudyModeBloc(
    this._wordRepository,
    this._listRepository,
  ) : super(StudyModeStateLoaded()) {
    on<StudyModeEventCalculateScore>((event, emit) async {
      double actualScore = 0;
      Map<String, dynamic> toUpdate = {};

      /// If winRate of any mode is -1, it means that the user has not studied this
      /// kanji yet. Therefore, the score should be untouched.
      /// If the winRate is different than -1, the user has already studied this kanji
      /// and then, a mean is calculated between the upcoming score and the previous one.
      switch (event.mode) {
        case StudyModes.writing:
          if (event.word.winRateWriting == DatabaseConstants.emptyWinRate) {
            actualScore = event.score;
          } else {
            actualScore = (event.score + event.word.winRateWriting) / 2;
          }
          toUpdate = {WordTableFields.winRateWritingField: actualScore};
          break;
        case StudyModes.reading:
          if (event.word.winRateReading == DatabaseConstants.emptyWinRate) {
            actualScore = event.score;
          } else {
            actualScore = (event.score + event.word.winRateReading) / 2;
          }
          toUpdate = {WordTableFields.winRateReadingField: actualScore};
          break;
        case StudyModes.recognition:
          if (event.word.winRateRecognition == DatabaseConstants.emptyWinRate) {
            actualScore = event.score;
          } else {
            actualScore = (event.score + event.word.winRateRecognition) / 2;
          }
          toUpdate = {WordTableFields.winRateRecognitionField: actualScore};
          break;
        case StudyModes.listening:
          if (event.word.winRateListening == DatabaseConstants.emptyWinRate) {
            actualScore = event.score;
          } else {
            actualScore = (event.score + event.word.winRateListening) / 2;
          }
          toUpdate = {WordTableFields.winRateListeningField: actualScore};
          break;
        case StudyModes.speaking:
          if (event.word.winRateSpeaking == DatabaseConstants.emptyWinRate) {
            actualScore = event.score;
          } else {
            actualScore = (event.score + event.word.winRateSpeaking) / 2;
          }
          toUpdate = {WordTableFields.winRateSpeakingField: actualScore};
          break;
      }
      final res = await _wordRepository.updateWord(
          event.word.listName, event.word.word, toUpdate);
      emit(StudyModeStateScoreCalculated(res));
    });

    on<StudyModeEventUpdateDateShown>((event, emit) async {
      await _wordRepository.updateWord(event.listName, event.word, {
        WordTableFields.dateLastShown: Utils.getCurrentMilliseconds(),
        WordTableFields.dateLastShownListening: Utils.getCurrentMilliseconds()
      });
    });

    on<StudyModeEventUpdateScoreForTestsAffectingPractice>((event, emit) async {
      /// Map for storing the overall scores on each appearing list on the test
      Map<String, double> overallScore = {};
      Map<String, List<Word>> orderedMap = {};

      /// Populate the Word arrays by their name in the orderedMap. It will look like this:
      /// {
      ///   list2: [],
      ///   list4: [],
      ///   ...,
      ///   listN: [...]
      /// }
      /// The map is only populated with the empty lists that appears on the test.
      for (var word in event.words) {
        orderedMap[word.listName] = [];
        overallScore[word.listName] = 0;
      }

      /// For every entry, populate the list with all of the kanji of each list
      /// that appeared on the test
      for (int x = 0; x < orderedMap.keys.toList().length; x++) {
        String kanListName = orderedMap.keys.toList()[x];
        orderedMap[kanListName] =
            await _wordRepository.getAllWordsFromList(kanListName);
      }

      /// Calculate the overall score for each list on the treated map
      for (int x = 0; x < orderedMap.keys.toList().length; x++) {
        String kanListName = orderedMap.keys.toList()[x];
        orderedMap[kanListName]?.forEach((k) {
          switch (event.mode) {
            case StudyModes.writing:
              if (k.winRateWriting != DatabaseConstants.emptyWinRate) {
                overallScore[kanListName] =
                    (overallScore[kanListName] ?? 0) + k.winRateWriting;
              }
              break;
            case StudyModes.reading:
              if (k.winRateReading != DatabaseConstants.emptyWinRate) {
                overallScore[kanListName] =
                    (overallScore[kanListName] ?? 0) + k.winRateReading;
              }
              break;
            case StudyModes.recognition:
              if (k.winRateRecognition != DatabaseConstants.emptyWinRate) {
                overallScore[kanListName] =
                    (overallScore[kanListName] ?? 0) + k.winRateRecognition;
              }
              break;
            case StudyModes.listening:
              if (k.winRateListening != DatabaseConstants.emptyWinRate) {
                overallScore[kanListName] =
                    (overallScore[kanListName] ?? 0) + k.winRateListening;
              }
              break;
            case StudyModes.speaking:
              if (k.winRateSpeaking != DatabaseConstants.emptyWinRate) {
                overallScore[kanListName] =
                    (overallScore[kanListName] ?? 0) + k.winRateSpeaking;
              }
              break;
          }
        });

        /// For each list, update its overall rating after getting the overall score
        final double overall =
            overallScore[kanListName]! / orderedMap[kanListName]!.length;

        Map<String, dynamic> toUpdate = {};

        /// We just need to update the totalWinRate as a reflection of the already
        /// meaned out words in the KanList
        switch (event.mode) {
          case StudyModes.writing:
            toUpdate = {ListTableFields.totalWinRateWritingField: overall};
            break;
          case StudyModes.reading:
            toUpdate = {ListTableFields.totalWinRateReadingField: overall};
            break;
          case StudyModes.recognition:
            toUpdate = {ListTableFields.totalWinRateRecognitionField: overall};
            break;
          case StudyModes.listening:
            toUpdate = {ListTableFields.totalWinRateListeningField: overall};
            break;
          case StudyModes.speaking:
            toUpdate = {ListTableFields.totalWinRateSpeakingField: overall};
            break;
        }
        await _listRepository.updateList(kanListName, toUpdate);
      }
    });

    on<StudyModeEventGetScore>((event, emit) async {
      double overallScore = 0;

      /// Get the kanji from the DB rather than the args instance as the args
      /// instance does not have the updated values
      List<Word> kanji =
          await _wordRepository.getAllWordsFromList(event.listName);
      for (var k in kanji) {
        switch (event.mode) {
          case StudyModes.writing:
            if (k.winRateWriting != DatabaseConstants.emptyWinRate) {
              overallScore += k.winRateWriting;
            }
            break;
          case StudyModes.reading:
            if (k.winRateReading != DatabaseConstants.emptyWinRate) {
              overallScore += k.winRateReading;
            }
            break;
          case StudyModes.recognition:
            if (k.winRateRecognition != DatabaseConstants.emptyWinRate) {
              overallScore += k.winRateRecognition;
            }
            break;
          case StudyModes.listening:
            if (k.winRateListening != DatabaseConstants.emptyWinRate) {
              overallScore += k.winRateListening;
            }
            break;
          case StudyModes.speaking:
            if (k.winRateSpeaking != DatabaseConstants.emptyWinRate) {
              overallScore += k.winRateSpeaking;
            }
            break;
        }
      }

      emit(StudyModeStateScoreObtained(overallScore));
    });

    on<StudyModeEventUpdateListScore>((event, emit) async {
      Map<String, dynamic> toUpdate = {};

      /// We just need to update the totalWinRate as a reflection of the already
      /// meaned out words in the KanList
      switch (event.mode) {
        case StudyModes.writing:
          toUpdate = {ListTableFields.totalWinRateWritingField: event.score};
          break;
        case StudyModes.reading:
          toUpdate = {ListTableFields.totalWinRateReadingField: event.score};
          break;
        case StudyModes.recognition:
          toUpdate = {
            ListTableFields.totalWinRateRecognitionField: event.score
          };
          break;
        case StudyModes.listening:
          toUpdate = {ListTableFields.totalWinRateListeningField: event.score};
          break;
        case StudyModes.speaking:
          toUpdate = {ListTableFields.totalWinRateSpeakingField: event.score};
          break;
      }
      await _listRepository.updateList(event.listName, toUpdate);
    });
  }
}
