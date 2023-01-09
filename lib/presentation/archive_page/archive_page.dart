import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/application/archive_grammar_points/archive_grammar_points_bloc.dart';
import 'package:kanpractice/application/archive_words/archive_words_bloc.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/archive_page/archive_grammar_list.dart';
import 'package:kanpractice/presentation/archive_page/archive_word_list.dart';
import 'package:kanpractice/presentation/core/types/list_details_types.dart';
import 'package:kanpractice/presentation/core/ui/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/ui/kp_search_bar.dart';
import 'package:kanpractice/presentation/core/ui/kp_word_grammar_bottom_navigation.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class ArchivePage extends StatefulWidget {
  const ArchivePage({super.key});

  @override
  State<ArchivePage> createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  final _searchBarFn = FocusNode();
  final _pageController = PageController();
  final _searchTextController = TextEditingController();

  /// Saves the last state of the query
  String _query = "";

  bool _searchHasFocus = false;
  ListDetailsType _currentPage = ListDetailsType.words;

  _addWordLoadingEvent({bool reset = false}) {
    return getIt<ArchiveWordsBloc>()
        .add(ArchiveWordsEventLoading(reset: reset));
  }

  _addWordSearchingEvent(String query, {bool reset = false}) {
    return getIt<ArchiveWordsBloc>()
        .add(ArchiveWordsEventSearching(query, reset: reset));
  }

  _addGrammarPointLoadingEvent({bool reset = false}) {
    return getIt<ArchiveGrammarPointsBloc>()
        .add(ArchiveGrammarPointsEventLoading(reset: reset));
  }

  _addGrammarPointSearchingEvent(String query, {bool reset = false}) {
    return getIt<ArchiveGrammarPointsBloc>()
        .add(ArchiveGrammarPointsEventSearching(query, reset: reset));
  }

  _focusListener() => setState(() => _searchHasFocus = _searchBarFn.hasFocus);

  @override
  void initState() {
    _searchBarFn.addListener(_focusListener);
    super.initState();
  }

  @override
  void dispose() {
    _searchBarFn.removeListener(_focusListener);
    _searchBarFn.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KPScaffold(
      appBarTitle: 'Archive',
      onWillPop: () async {
        if (_searchHasFocus) {
          _searchBarFn.unfocus();
          return false;
        } else {
          return true;
        }
      },
      bottomNavigationWidget: KPWordGrammarBottomNavigation(
        currentPage: _currentPage,
        onPageChanged: (type) {
          setState(() => _currentPage = type);
          _searchBarFn.unfocus();
          _searchTextController.text = "";
          _pageController.animateToPage(
            type.page,
            duration: const Duration(milliseconds: KPAnimations.ms300),
            curve: Curves.easeInOut,
          );
        },
      ),
      child: Column(
        children: [
          KPSearchBar(
            controller: _searchTextController,
            hint: _currentPage == ListDetailsType.words
                ? "list_details_searchBar_hint".tr()
                : "list_details_searchBar_hint_grammar".tr(),
            focus: _searchBarFn,
            onQuery: (String query) {
              /// Everytime the user queries, reset the query itself and
              /// the pagination index
              _query = query;
              if (_currentPage == ListDetailsType.words) {
                _addWordSearchingEvent(query, reset: true);
              } else {
                _addGrammarPointSearchingEvent(query, reset: true);
              }
            },
            onExitSearch: () {
              /// Empty the query
              _query = "";
              if (_currentPage == ListDetailsType.words) {
                _addWordLoadingEvent(reset: true);
              } else {
                _addGrammarPointLoadingEvent(reset: true);
              }
            },
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (p) {
                setState(() {
                  _currentPage = ListDetailsType.values[p];
                });
              },
              children: [
                ArchiveWordListWidget(
                  query: _query,
                  searchBarFn: _searchBarFn,
                ),
                ArchiveGrammarListWidget(
                  query: _query,
                  searchBarFn: _searchBarFn,
                ),
              ],
            ),
          ),
          const SizedBox(height: KPMargins.margin12),
        ],
      ),
    );
  }
}
