import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/application/services/sm2_algorithm.dart';
import 'package:kanpractice/domain/list/i_list_repository.dart';
import 'package:kanpractice/domain/word/i_word_repository.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';

part 'study_mode_event.dart';
part 'study_mode_state.dart';

part 'study_mode_bloc.freezed.dart';

class WordTestTracking {
  final String listName;
  final String word;
  final double score;
  final StudyModes mode;
  final int seen;

  const WordTestTracking({
    required this.listName,
    required this.word,
    required this.score,
    required this.mode,
    required this.seen,
  });
}

class WordSM2TestTracking {
  final String listName;
  final String word;
  final StudyModes mode;
  final int repetitions;
  final int previousInterval;
  final int previousIntervalAsDate;
  final double previousEaseFactor;

  const WordSM2TestTracking({
    required this.listName,
    required this.word,
    required this.mode,
    required this.repetitions,
    required this.previousInterval,
    required this.previousIntervalAsDate,
    required this.previousEaseFactor,
  });
}

@lazySingleton
class StudyModeBloc extends Bloc<StudyModeEvent, StudyModeState> {
  final IWordRepository _wordRepository;
  final IListRepository _listRepository;

  List<WordTestTracking> testTracking = [];
  List<WordSM2TestTracking> testSM2Tracking = [];

  StudyModeBloc(
    this._wordRepository,
    this._listRepository,
  ) : super(const StudyModeState.loaded()) {
    on<StudyModeEventResetTracking>((event, emit) {
      testTracking.clear();
      testSM2Tracking.clear();
      emit(const StudyModeState.loaded());
    });

    on<StudyModeEventCalculateScore>((event, emit) async {
      double actualScore = 0;
      Map<String, dynamic> toUpdate = {
        WordTableFields.dateLastShown: Utils.getCurrentMilliseconds(),
      };

      /// If winRate of any mode is -1, it means that the user has not studied this
      /// word yet. Therefore, the score should be untouched.
      /// If the winRate is different than -1, the user has already studied this word
      /// and then, a mean is calculated between the upcoming score and the previous one.
      switch (event.mode) {
        case StudyModes.writing:
          if (event.word.winRateWriting == DatabaseConstants.emptyWinRate) {
            actualScore = event.score;
          } else {
            actualScore = (event.score + event.word.winRateWriting) / 2;
          }
          toUpdate.addEntries([
            MapEntry(WordTableFields.winRateWritingField, actualScore),
            MapEntry(WordTableFields.dateLastShownWriting,
                Utils.getCurrentMilliseconds()),
          ]);
          break;
        case StudyModes.reading:
          if (event.word.winRateReading == DatabaseConstants.emptyWinRate) {
            actualScore = event.score;
          } else {
            actualScore = (event.score + event.word.winRateReading) / 2;
          }
          toUpdate.addEntries([
            MapEntry(WordTableFields.winRateReadingField, actualScore),
            MapEntry(WordTableFields.dateLastShownReading,
                Utils.getCurrentMilliseconds()),
          ]);
          break;
        case StudyModes.recognition:
          if (event.word.winRateRecognition == DatabaseConstants.emptyWinRate) {
            actualScore = event.score;
          } else {
            actualScore = (event.score + event.word.winRateRecognition) / 2;
          }
          toUpdate.addEntries([
            MapEntry(WordTableFields.winRateRecognitionField, actualScore),
            MapEntry(WordTableFields.dateLastShownRecognition,
                Utils.getCurrentMilliseconds()),
          ]);
          break;
        case StudyModes.listening:
          if (event.word.winRateListening == DatabaseConstants.emptyWinRate) {
            actualScore = event.score;
          } else {
            actualScore = (event.score + event.word.winRateListening) / 2;
          }
          toUpdate.addEntries([
            MapEntry(WordTableFields.winRateListeningField, actualScore),
            MapEntry(WordTableFields.dateLastShownListening,
                Utils.getCurrentMilliseconds()),
          ]);
          break;
        case StudyModes.speaking:
          if (event.word.winRateSpeaking == DatabaseConstants.emptyWinRate) {
            actualScore = event.score;
          } else {
            actualScore = (event.score + event.word.winRateSpeaking) / 2;
          }
          toUpdate.addEntries([
            MapEntry(WordTableFields.winRateSpeakingField, actualScore),
            MapEntry(WordTableFields.dateLastShownSpeaking,
                Utils.getCurrentMilliseconds()),
          ]);
          break;
      }
      if (event.isTest) {
        return testTracking.add(WordTestTracking(
          listName: event.word.listName,
          word: event.word.word,
          score: actualScore,
          mode: event.mode,
          seen: Utils.getCurrentMilliseconds(),
        ));
      }

      final res = await _wordRepository.updateWord(
          event.word.listName, event.word.word, toUpdate);

      emit(StudyModeState.scoreCalculated(res));
    });

    on<StudyModeEventCalculateSM2Params>((event, emit) async {
      Map<String, dynamic> toUpdate = {};

      switch (event.mode) {
        case StudyModes.writing:
          final sm2 = SMAlgorithm.calc(
            quality: event.score,
            repetitions: event.word.repetitionsWriting,
            previousInterval: event.word.previousIntervalWriting,
            previousEaseFactor: event.word.previousEaseFactorWriting,
          );
          toUpdate = {
            WordTableFields.previousIntervalWritingField: sm2.interval,
            WordTableFields.previousIntervalAsDateWritingField:
                sm2.intervalAsDate,
            WordTableFields.repetitionsWritingField: sm2.repetitions,
            WordTableFields.previousEaseFactorWritingField: sm2.easeFactor,
          };
          break;
        case StudyModes.reading:
          final sm2 = SMAlgorithm.calc(
            quality: event.score,
            repetitions: event.word.repetitionsReading,
            previousInterval: event.word.previousIntervalReading,
            previousEaseFactor: event.word.previousEaseFactorReading,
          );
          toUpdate = {
            WordTableFields.previousIntervalReadingField: sm2.interval,
            WordTableFields.previousIntervalAsDateReadingField:
                sm2.intervalAsDate,
            WordTableFields.repetitionsReadingField: sm2.repetitions,
            WordTableFields.previousEaseFactorReadingField: sm2.easeFactor,
          };
          break;
        case StudyModes.recognition:
          final sm2 = SMAlgorithm.calc(
            quality: event.score,
            repetitions: event.word.repetitionsRecognition,
            previousInterval: event.word.previousIntervalRecognition,
            previousEaseFactor: event.word.previousEaseFactorRecognition,
          );
          toUpdate = {
            WordTableFields.previousIntervalRecognitionField: sm2.interval,
            WordTableFields.previousIntervalAsDateRecognitionField:
                sm2.intervalAsDate,
            WordTableFields.repetitionsRecognitionField: sm2.repetitions,
            WordTableFields.previousEaseFactorRecognitionField: sm2.easeFactor,
          };
          break;
        case StudyModes.listening:
          final sm2 = SMAlgorithm.calc(
            quality: event.score,
            repetitions: event.word.repetitionsListening,
            previousInterval: event.word.previousIntervalListening,
            previousEaseFactor: event.word.previousEaseFactorListening,
          );
          toUpdate = {
            WordTableFields.previousIntervalListeningField: sm2.interval,
            WordTableFields.previousIntervalAsDateListeningField:
                sm2.intervalAsDate,
            WordTableFields.repetitionsListeningField: sm2.repetitions,
            WordTableFields.previousEaseFactorListeningField: sm2.easeFactor,
          };
          break;
        case StudyModes.speaking:
          final sm2 = SMAlgorithm.calc(
            quality: event.score,
            repetitions: event.word.repetitionsSpeaking,
            previousInterval: event.word.previousIntervalSpeaking,
            previousEaseFactor: event.word.previousEaseFactorSpeaking,
          );
          toUpdate = {
            WordTableFields.previousIntervalSpeakingField: sm2.interval,
            WordTableFields.previousIntervalAsDateSpeakingField:
                sm2.intervalAsDate,
            WordTableFields.repetitionsSpeakingField: sm2.repetitions,
            WordTableFields.previousEaseFactorSpeakingField: sm2.easeFactor,
          };
          break;
      }

      final keys = toUpdate.keys.toList();
      testSM2Tracking.add(WordSM2TestTracking(
        listName: event.word.listName,
        word: event.word.word,
        mode: event.mode,
        previousInterval: toUpdate[keys[0]],
        previousIntervalAsDate: toUpdate[keys[1]],
        repetitions: toUpdate[keys[2]],
        previousEaseFactor: toUpdate[keys[3]],
      ));
      emit(const StudyModeState.sm2Calculated());
    });

    on<StudyModeEventUpdateScoreForTestsAffectingPractice>((event, emit) async {
      emit(const StudyModeState.loading());

      /// Map for storing the overall scores on each appearing list on the test
      Map<String, double> overallScore = {};
      Map<String, List<Word>> orderedMap = {};

      /// Update in DB all words
      Map<String, dynamic> toUpdate = {};

      for (int i = 0; i < testTracking.length; i++) {
        final s = testSM2Tracking.isEmpty ? null : testSM2Tracking[i];
        final w = testTracking[i];

        /// Populate the Word arrays by their name in the orderedMap. It will look like this:
        /// {
        ///   list2: [],
        ///   list4: [],
        ///   ...,
        ///   listN: [...]
        /// }
        /// The map is only populated with the empty lists that appears on the test.
        orderedMap[w.listName] = [];
        overallScore[w.listName] = 0;

        switch (testTracking[i].mode) {
          case StudyModes.writing:
            toUpdate.addEntries([
              MapEntry(WordTableFields.dateLastShown, w.seen),
              MapEntry(WordTableFields.dateLastShownWriting, w.seen),
              MapEntry(WordTableFields.winRateWritingField, w.score),
              if (s != null)
                MapEntry(WordTableFields.previousIntervalWritingField,
                    s.previousInterval),
              if (s != null)
                MapEntry(WordTableFields.previousIntervalAsDateWritingField,
                    s.previousIntervalAsDate),
              if (s != null)
                MapEntry(
                    WordTableFields.repetitionsWritingField, s.repetitions),
              if (s != null)
                MapEntry(WordTableFields.previousEaseFactorWritingField,
                    s.previousEaseFactor),
            ]);
            break;
          case StudyModes.reading:
            toUpdate.addEntries([
              MapEntry(WordTableFields.dateLastShown, w.seen),
              MapEntry(WordTableFields.dateLastShownReading, w.seen),
              MapEntry(WordTableFields.winRateReadingField, w.score),
              if (s != null)
                MapEntry(WordTableFields.previousIntervalReadingField,
                    s.previousInterval),
              if (s != null)
                MapEntry(WordTableFields.previousIntervalAsDateReadingField,
                    s.previousIntervalAsDate),
              if (s != null)
                MapEntry(
                    WordTableFields.repetitionsReadingField, s.repetitions),
              if (s != null)
                MapEntry(WordTableFields.previousEaseFactorReadingField,
                    s.previousEaseFactor),
            ]);
            break;
          case StudyModes.recognition:
            toUpdate.addEntries([
              MapEntry(WordTableFields.dateLastShown, w.seen),
              MapEntry(WordTableFields.dateLastShownRecognition, w.seen),
              MapEntry(WordTableFields.winRateRecognitionField, w.score),
              if (s != null)
                MapEntry(WordTableFields.previousIntervalRecognitionField,
                    s.previousInterval),
              if (s != null)
                MapEntry(WordTableFields.previousIntervalAsDateRecognitionField,
                    s.previousIntervalAsDate),
              if (s != null)
                MapEntry(
                    WordTableFields.repetitionsRecognitionField, s.repetitions),
              if (s != null)
                MapEntry(WordTableFields.previousEaseFactorRecognitionField,
                    s.previousEaseFactor),
            ]);
            break;
          case StudyModes.listening:
            toUpdate.addEntries([
              MapEntry(WordTableFields.dateLastShown, w.seen),
              MapEntry(WordTableFields.dateLastShownListening, w.seen),
              MapEntry(WordTableFields.winRateListeningField, w.score),
              if (s != null)
                MapEntry(WordTableFields.previousIntervalListeningField,
                    s.previousInterval),
              if (s != null)
                MapEntry(WordTableFields.previousIntervalAsDateListeningField,
                    s.previousIntervalAsDate),
              if (s != null)
                MapEntry(
                    WordTableFields.repetitionsListeningField, s.repetitions),
              if (s != null)
                MapEntry(WordTableFields.previousEaseFactorListeningField,
                    s.previousEaseFactor),
            ]);
            break;
          case StudyModes.speaking:
            toUpdate.addEntries([
              MapEntry(WordTableFields.dateLastShown, w.seen),
              MapEntry(WordTableFields.dateLastShownSpeaking, w.seen),
              MapEntry(WordTableFields.winRateSpeakingField, w.score),
              if (s != null)
                MapEntry(WordTableFields.previousIntervalSpeakingField,
                    s.previousInterval),
              if (s != null)
                MapEntry(WordTableFields.previousIntervalAsDateSpeakingField,
                    s.previousIntervalAsDate),
              if (s != null)
                MapEntry(
                    WordTableFields.repetitionsSpeakingField, s.repetitions),
              if (s != null)
                MapEntry(WordTableFields.previousEaseFactorSpeakingField,
                    s.previousEaseFactor),
            ]);
            break;
        }

        await _wordRepository.updateWord(w.listName, w.word, toUpdate);
      }

      /// For every entry, populate the list with all of the word of each list
      /// that appeared on the test
      for (int x = 0; x < orderedMap.keys.toList().length; x++) {
        String kanListName = orderedMap.keys.toList()[x];
        orderedMap[kanListName] =
            await _wordRepository.getAllWordsFromList(kanListName);

        /// Calculate the overall score for each list on the treated map
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

      emit(const StudyModeState.testFinished());
    });

    on<StudyModeEventGetScore>((event, emit) async {
      double overallScore = 0;

      /// Get the word from the DB rather than the args instance as the args
      /// instance does not have the updated values
      List<Word> words =
          await _wordRepository.getAllWordsFromList(event.listName);
      for (var w in words) {
        switch (event.mode) {
          case StudyModes.writing:
            if (w.winRateWriting != DatabaseConstants.emptyWinRate) {
              overallScore += w.winRateWriting;
            }
            break;
          case StudyModes.reading:
            if (w.winRateReading != DatabaseConstants.emptyWinRate) {
              overallScore += w.winRateReading;
            }
            break;
          case StudyModes.recognition:
            if (w.winRateRecognition != DatabaseConstants.emptyWinRate) {
              overallScore += w.winRateRecognition;
            }
            break;
          case StudyModes.listening:
            if (w.winRateListening != DatabaseConstants.emptyWinRate) {
              overallScore += w.winRateListening;
            }
            break;
          case StudyModes.speaking:
            if (w.winRateSpeaking != DatabaseConstants.emptyWinRate) {
              overallScore += w.winRateSpeaking;
            }
            break;
        }
      }

      emit(StudyModeState.scoreObtained(overallScore));
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
