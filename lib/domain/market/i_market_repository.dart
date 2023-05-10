import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/presentation/core/types/market_filters.dart';
import 'package:kanpractice/domain/folder/folder.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/domain/market/market.dart';
import 'package:kanpractice/domain/word/word.dart';

abstract class IMarketRepository {
  /// Query to get all [Market] from Firebase with an optional [order] and [filter].
  /// If anything goes wrong, an empty list will be returned.
  ///
  /// The offset is the last document id retrieved from Firebase. This is kept
  /// on the MarketBloc for the whole instance of the page instead of this singleton.
  /// The string of the last retrieved document is updated via [onLastQueriedDocument].
  ///
  /// If [query] is not null, the user is searching for lists, thus appending a
  /// where clause to the retrieval method is performed.
  Future<List<Market>> getMarket({
    MarketFilters filter = MarketFilters.all,
    bool descending = true,
    required String offsetDocumentId,
    required Function(String) onLastQueriedDocument,
    String? query,
    bool filterByMine = false,
  });

  /// Uploads a Kanlist to the market place. Every list and word will be
  /// reset upon upload.
  /// [list] and [word] will reset their win rates and dates upon upload.
  ///
  /// In order to be able to upload to the market place, AN USER MUST BE AUTHENTICATED,
  /// else, -2 will be returned
  Future<int> uploadListToMarketPlace(
    String name,
    WordList list,
    String language,
    List<Word> words,
    List<GrammarPoint> grammarPoints,
    String description,
  );

  /// Uploads a Folder to the market place. Every list and word will be
  /// reset upon upload.
  /// [list] and [word] will reset their win rates and dates upon upload.
  ///
  /// In order to be able to upload to the market place, AN USER MUST BE AUTHENTICATED,
  /// else, -2 will be returned
  Future<int> uploadFolderToMarketPlace(
    String name,
    Folder folder,
    String language,
    List<WordList> lists,
    List<Word> words,
    List<GrammarPoint> grammarPoints,
    String description,
  );
  Future<String> downloadListFromMarketPlace(String id, String targetLanguage);
  Future<String> downloadFolderFromMarketPlace(
      String id, String targetLanguage);
  Future<String> removeListFromMarketPlace(String id);
  Future<String> removeFolderFromMarketPlace(String id);
  Future<String> rateList(String id, double rate);
}
