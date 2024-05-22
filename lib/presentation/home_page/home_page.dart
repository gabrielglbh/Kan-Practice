import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/archive_grammar_points/archive_grammar_points_bloc.dart';
import 'package:kanpractice/application/archive_words/archive_words_bloc.dart';
import 'package:kanpractice/application/backup/backup_bloc.dart';
import 'package:kanpractice/application/folder_list/folder_bloc.dart';
import 'package:kanpractice/application/generic_test/generic_test_bloc.dart';
import 'package:kanpractice/application/grammar_test/grammar_test_bloc.dart';
import 'package:kanpractice/application/lists/lists_bloc.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/archive_page/archive_grammar_list.dart';
import 'package:kanpractice/presentation/archive_page/archive_word_list.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/presentation/core/types/dictionary_types.dart';
import 'package:kanpractice/presentation/core/types/list_details_types.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/presentation/core/types/word_categories_filters.dart';
import 'package:kanpractice/presentation/core/util/tutorial_coach.dart';
import 'package:kanpractice/presentation/core/types/coach_tutorial_parts.dart';
import 'package:kanpractice/presentation/core/types/folder_filters.dart';
import 'package:kanpractice/presentation/core/types/home_types.dart';
import 'package:kanpractice/presentation/core/types/wordlist_filters.dart';
import 'package:kanpractice/presentation/core/types/tab_types.dart';
import 'package:kanpractice/presentation/core/widgets/kanlists/kp_kanlists.dart';
import 'package:kanpractice/presentation/core/widgets/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/widgets/kp_search_bar.dart';
import 'package:kanpractice/presentation/core/widgets/kp_test_bottom_sheet.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/dictionary_page/arguments.dart';
import 'package:kanpractice/presentation/folder_list_page/folder_list_page.dart';
import 'package:kanpractice/presentation/home_page/widgets/home_bottom_navigation.dart';
import 'package:kanpractice/presentation/settings_page/settings_page.dart';

class HomePage extends StatefulWidget {
  final bool? showTestBottomSheet;
  const HomePage({super.key, this.showTestBottomSheet});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final lists = GlobalKey();
  final folders = GlobalKey();
  final kanList = GlobalKey();
  final dictionary = GlobalKey();
  final actions = GlobalKey();
  final market = GlobalKey();
  final archive = GlobalKey();
  final settings = GlobalKey();

  late PageController _controller;
  late TabController _tabController, _archiveTabController;
  HomeType _currentPage = HomeType.kanlist;
  TabType _currentTab = TabType.kanlist;
  ListDetailsType _currentArchiveTab = ListDetailsType.words;

  late FocusNode _searchBarFn;
  late TextEditingController _searchTextController;
  bool _searchHasFocus = false;

  WordListFilters get _currentAppliedFilter {
    final filterText =
        getIt<PreferencesService>().readData(SharedKeys.filtersOnList) ??
            ListTableFields.lastUpdatedField;
    return KanListFiltersUtils.getFilterFrom(filterText);
  }

  bool get _currentAppliedOrder =>
      getIt<PreferencesService>().readData(SharedKeys.orderOnList) ?? true;

  FolderFilters get _currentAppliedFolderFilter {
    final filterFolderText =
        getIt<PreferencesService>().readData(SharedKeys.filtersOnFolder) ??
            FolderTableFields.lastUpdatedField;
    return FolderFiltersUtils.getFilterFrom(filterFolderText);
  }

  bool get _currentAppliedFolderOrder =>
      getIt<PreferencesService>().readData(SharedKeys.orderOnFolder) ?? true;

  String _query = "";
  bool _onTutorial = false;
  String _newVersion = "";
  List<String> _notes = [];

  @override
  void initState() {
    _searchBarFn = FocusNode();
    _searchTextController = TextEditingController();
    _searchBarFn.addListener(_focusListener);
    _controller = PageController();
    _archiveTabController = TabController(length: 2, vsync: this);
    _archiveTabController.addListener(_onArchiveTabChanged);
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);

    context.read<ListsBloc>().add(ListsEventLoading(
          filter: _currentAppliedFilter,
          order: _currentAppliedOrder,
          reset: true,
        ));

    context.read<FolderBloc>().add(FolderEventLoading(
          filter: _currentAppliedFolderFilter,
          order: _currentAppliedFolderOrder,
          reset: true,
        ));

    context.read<BackupBloc>().add(const BackupGetVersion());

    _addReviewEvent();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      /// Read folder from SharedPreferences, current selected folder for the latest
      /// test. If any, show that BS and navigate to that tab. Else just
      /// show the BS with all tests
      if (widget.showTestBottomSheet == true) {
        String? folder =
            getIt<PreferencesService>().readData(SharedKeys.folderWhenOnTest);
        bool hasFolder = folder != null && folder.isNotEmpty;
        if (hasFolder) _tabController.animateTo(1);
        await KPTestBottomSheet.show(
          context,
          folder: hasFolder ? folder : null,
        ).then((_) => _addReviewEvent());
      }
    });
    super.initState();
  }

  _addReviewEvent() {
    context
        .read<GenericTestBloc>()
        .add(const GenericTestEventIdle(mode: Tests.daily));
    context
        .read<GrammarTestBloc>()
        .add(const GrammarTestEventIdle(mode: Tests.daily));
  }

  _addListLoadingEvent({bool reset = true}) =>
      context.read<ListsBloc>().add(ListsEventLoading(
          filter: _currentAppliedFilter,
          order: _currentAppliedOrder,
          reset: reset));

  _addListSearchingEvent(String query, {bool reset = true}) =>
      context.read<ListsBloc>().add(ListsEventSearching(query, reset: reset));

  _addFolderListLoadingEvent({bool reset = true}) =>
      context.read<FolderBloc>().add(FolderEventLoading(
          filter: _currentAppliedFolderFilter,
          order: _currentAppliedFolderOrder,
          reset: reset));

  _addFolderListSearchingEvent(String query, {bool reset = true}) =>
      context.read<FolderBloc>().add(FolderEventSearching(query, reset: reset));

  _addWordsLoadingEvent({bool reset = true}) {
    return context.read<ArchiveWordsBloc>().add(ArchiveWordsEventLoading(
        filter: WordCategoryFilter.all, order: true, reset: reset));
  }

  _addWordsSearchingEvent(String query, {bool reset = true}) {
    return context
        .read<ArchiveWordsBloc>()
        .add(ArchiveWordsEventSearching(query, reset: reset));
  }

  _addGrammarPointLoadingEvent({bool reset = true}) {
    return context
        .read<ArchiveGrammarPointsBloc>()
        .add(ArchiveGrammarPointsEventLoading(reset: reset));
  }

  _addGrammarPointSearchingEvent(String query, {bool reset = true}) {
    return context
        .read<ArchiveGrammarPointsBloc>()
        .add(ArchiveGrammarPointsEventSearching(query, reset: reset));
  }

  _focusListener() => _searchHasFocus = _searchBarFn.hasFocus;

  _onTabChanged() =>
      setState(() => _currentTab = TabType.values[_tabController.index]);

  _onArchiveTabChanged() => setState(() =>
      _currentArchiveTab = ListDetailsType.values[_archiveTabController.index]);

  _resetLists() {
    if (_currentPage == HomeType.kanlist) {
      if (_currentTab == TabType.kanlist) return _addListLoadingEvent();
      return _addFolderListLoadingEvent();
    }
    if (_currentPage == HomeType.archive) {
      if (_currentArchiveTab == ListDetailsType.words) {
        return _addWordsLoadingEvent();
      }
      return _addGrammarPointLoadingEvent();
    }
  }

  bool _showPendingReview(List<int> toReview) {
    return toReview.isNotEmpty && toReview.any((i) => i > 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _searchTextController.dispose();
    _searchBarFn.removeListener(_focusListener);
    _searchBarFn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final updateIcon = IconButton(
      onPressed: () async {
        await Utils.showVersionNotes(context,
            version: _newVersion, notes: _notes);
      },
      icon: const Icon(Icons.update_rounded),
    );
    final marketIcon = IconButton(
      key: market,
      onPressed: () {
        Navigator.of(context).pushNamed(KanPracticePages.marketPage);
      },
      icon: const Icon(Icons.shopping_bag_rounded),
    );
    final List<Widget> updateWithAppBarIcons =
        _currentPage == HomeType.dictionary
            ? [updateIcon]
            : _currentPage == HomeType.kanlist
                ? [updateIcon, marketIcon]
                : [updateIcon];
    final List<Widget> appBarIcons = _currentPage == HomeType.dictionary
        ? []
        : _currentPage == HomeType.kanlist
            ? [marketIcon]
            : [];

    return BlocListener<BackupBloc, BackupState>(
      listener: (context, state) {
        state.mapOrNull(versionRetrieved: (v) {
          setState(() {
            _newVersion = v.version;
            _notes = v.notes;
          });
        });
      },
      child: BlocListener<ListsBloc, ListsState>(
        listener: (context, state) async {
          state.mapOrNull(loaded: (_) async {
            if (getIt<PreferencesService>()
                    .readData(SharedKeys.haveSeenKanListCoachMark) ==
                false) {
              _onTutorial = true;
              await TutorialCoach([
                lists,
                folders,
                kanList,
                dictionary,
                actions,
                archive,
                market,
                settings,
              ], CoachTutorialParts.kanList)
                  .showTutorial(context, onEnd: () {});
            }
          });
        },
        child: KPScaffold(
          setGestureDetector: false,
          onWillPop: () async {
            if (_onTutorial) return false;
            if (_searchHasFocus) {
              _resetLists();
              _searchBarFn.unfocus();
              return false;
            }
            if (_currentPage.index != 0) {
              _controller.jumpToPage(0);
              setState(() => _currentPage = HomeType.kanlist);
              return false;
            }
            return true;
          },
          appBarTitle: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(_currentPage.appBarTitle),
          ),
          appBarActions:
              _newVersion.isNotEmpty ? updateWithAppBarIcons : appBarIcons,
          bottomNavigationWidget: HomeBottomNavigation(
            tutorialKeys: [kanList, dictionary, actions, archive, settings],
            currentPage: _currentPage,
            onPageChanged: (type) {
              if (_currentPage != type && type != HomeType.actions) {
                setState(() => _currentPage = type);
                _searchBarFn.unfocus();
                _searchTextController.text = "";
                _controller.jumpToPage(type.page);
              }
            },
            onShowActions: (name) {
              _addReviewEvent();
              if (name != null) {
                if (name == "__folder") {
                  _addFolderListLoadingEvent();
                } else {
                  context.read<ListsBloc>().add(ListsEventCreate(name,
                      filter: _currentAppliedFilter,
                      order: _currentAppliedOrder));
                }
              }
            },
          ),
          child: Column(
            children: [
              if (HomeType.kanlist == _currentPage ||
                  HomeType.archive == _currentPage)
                KPSearchBar(
                  controller: _searchTextController,
                  hint: _currentPage == HomeType.archive
                      ? _currentArchiveTab.searchBarHint
                      : _currentTab.searchBarHint,
                  focus: _searchBarFn,
                  onQuery: (String query) {
                    _query = query;
                    if (_currentPage == HomeType.kanlist) {
                      if (_currentTab == TabType.kanlist) {
                        return _addListSearchingEvent(query);
                      }
                      return _addFolderListSearchingEvent(query);
                    }
                    if (_currentPage == HomeType.archive) {
                      if (_currentArchiveTab == ListDetailsType.words) {
                        return _addWordsSearchingEvent(query);
                      }
                      return _addGrammarPointSearchingEvent(query);
                    }
                  },
                  onExitSearch: () {
                    _query = "";
                    _resetLists();
                  },
                ),
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Column(
                      children: [
                        if (_currentPage == HomeType.kanlist)
                          TabBar(
                            key: folders,
                            controller: _tabController,
                            padding: const EdgeInsets.only(
                                bottom: KPMargins.margin4),
                            onTap: (tab) {
                              if (tab == 0) {
                                _addListLoadingEvent();
                                return;
                              }
                              _addFolderListLoadingEvent();
                            },
                            tabs: const [
                              Tab(icon: Icon(Icons.table_rows_rounded)),
                              Tab(icon: Icon(Icons.folder_rounded)),
                            ],
                          ),
                        if (_currentPage == HomeType.archive)
                          TabBar(
                            controller: _archiveTabController,
                            padding: const EdgeInsets.only(
                                bottom: KPMargins.margin4),
                            tabs: [
                              Tab(icon: Icon(ListDetailsType.words.icon)),
                              Tab(icon: Icon(ListDetailsType.grammar.icon)),
                            ],
                          ),
                        Expanded(child: _body()),
                      ],
                    ),
                    BlocBuilder<GenericTestBloc, GenericTestState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          initial: (wordsToReview) {
                            final show = _showPendingReview(wordsToReview);
                            if (show) return _actionChipReview();
                            return BlocBuilder<GrammarTestBloc,
                                GrammarTestState>(
                              builder: (context, state) {
                                return state.maybeWhen(
                                  initial: (grammarToReview) {
                                    final show =
                                        _showPendingReview(grammarToReview);
                                    if (show) return _actionChipReview();
                                    return const SizedBox();
                                  },
                                  orElse: () => const SizedBox(),
                                );
                              },
                            );
                          },
                          orElse: () => const SizedBox(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ActionChip _actionChipReview() {
    return ActionChip(
      avatar: Icon(
        Icons.calendar_today,
        size: 16,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      label: Text(
        "pending_review".tr(),
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      ),
      side: BorderSide.none,
      backgroundColor: Theme.of(context).colorScheme.primary,
      onPressed: () async {
        await KPTestBottomSheet.show(context).then((_) => _addReviewEvent());
      },
    );
  }

  PageView _body() {
    return PageView(
      controller: _controller,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        TabBarView(
          controller: _tabController,
          children: [
            KPKanlists(
              key: lists,
              removeFocus: () => _searchBarFn.unfocus(),
              onScrolledToBottom: (addListLoadingWithFilters) {
                if (_query.isNotEmpty) {
                  return _addListSearchingEvent(_query, reset: false);
                }
                addListLoadingWithFilters();
              },
            ),
            FolderListPage(
              removeFocus: () => _searchBarFn.unfocus(),
              onScrolledToBottom: (addFolderListLoadingWithFilters) {
                if (_query.isNotEmpty) {
                  return _addFolderListSearchingEvent(_query, reset: false);
                }
                addFolderListLoadingWithFilters();
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: KPMargins.margin12),
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: DictionaryType.values.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(DictionaryType.values[index].title),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: KPMargins.margin4),
                  child: Text(DictionaryType.values[index].explanation),
                ),
                leading: DictionaryType.values[index] == DictionaryType.ocr
                    ? ShaderMask(
                        shaderCallback: (bounds) {
                          return const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.blue,
                                Colors.green,
                                Colors.yellow,
                                Colors.red,
                                Colors.purple
                              ]).createShader(bounds);
                        },
                        child: Icon(DictionaryType.values[index].icon,
                            color: Colors.white),
                      )
                    : Icon(DictionaryType.values[index].icon),
                trailing: const Icon(Icons.arrow_forward),
                contentPadding: const EdgeInsets.all(KPMargins.margin8),
                onTap: () {
                  switch (DictionaryType.values[index]) {
                    case DictionaryType.ocr:
                      Navigator.of(context).pushNamed(KanPracticePages.ocrPage);
                      break;
                    case DictionaryType.convolution:
                      Navigator.of(context).pushNamed(
                        KanPracticePages.dictionaryPage,
                        arguments:
                            const DictionaryArguments(searchInJisho: true),
                      );
                      break;
                    case DictionaryType.history:
                      Navigator.of(context)
                          .pushNamed(KanPracticePages.historyWordPage);
                      break;
                  }
                },
              );
            },
          ),
        ),
        TabBarView(
          controller: _archiveTabController,
          children: [
            ArchiveWordListWidget(
              query: _query,
              removeFocus: () => _searchBarFn.unfocus(),
              onScrolledToBottom: (addWordsLoadingWithFilters) {
                if (_query.isNotEmpty) {
                  return _addWordsSearchingEvent(_query, reset: false);
                }
                addWordsLoadingWithFilters();
              },
            ),
            ArchiveGrammarListWidget(
              query: _query,
              removeFocus: () => _searchBarFn.unfocus(),
              onScrolledToBottom: () {
                if (_query.isNotEmpty) {
                  return _addGrammarPointSearchingEvent(_query, reset: false);
                }
                return _addGrammarPointLoadingEvent(reset: false);
              },
            ),
          ],
        ),
        const SettingsPage()
      ],
    );
  }
}
