import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/backup/backup_bloc.dart';
import 'package:kanpractice/application/folder_list/folder_bloc.dart';
import 'package:kanpractice/application/list/lists_bloc.dart';
import 'package:kanpractice/application/load_grammar_test/load_grammar_test_bloc.dart';
import 'package:kanpractice/application/load_test/load_test_bloc.dart';
import 'package:kanpractice/application/market/market_bloc.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/presentation/core/util/tutorial_coach.dart';
import 'package:kanpractice/presentation/core/types/coach_tutorial_parts.dart';
import 'package:kanpractice/presentation/core/types/folder_filters.dart';
import 'package:kanpractice/presentation/core/types/home_types.dart';
import 'package:kanpractice/presentation/core/types/wordlist_filters.dart';
import 'package:kanpractice/presentation/core/types/market_filters.dart';
import 'package:kanpractice/presentation/core/types/tab_types.dart';
import 'package:kanpractice/domain/market/market.dart';
import 'package:kanpractice/presentation/core/widgets/kanlists/kp_kanlists.dart';
import 'package:kanpractice/presentation/core/widgets/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/widgets/kp_search_bar.dart';
import 'package:kanpractice/presentation/core/widgets/kp_test_bottom_sheet.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/dictionary_page/arguments.dart';
import 'package:kanpractice/presentation/dictionary_page/dictionary_page.dart';
import 'package:kanpractice/presentation/folder_list_page/folder_list_page.dart';
import 'package:kanpractice/presentation/home_page/widgets/home_bottom_navigation.dart';
import 'package:kanpractice/presentation/market_page/market_page.dart';
import 'package:kanpractice/presentation/settings_page/settings_page.dart';

class HomePage extends StatefulWidget {
  final bool? showTestBottomSheet;
  const HomePage({Key? key, this.showTestBottomSheet}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final lists = GlobalKey();
  final folders = GlobalKey();
  final kanList = GlobalKey();
  final dictionary = GlobalKey();
  final actions = GlobalKey();
  final market = GlobalKey();
  final settings = GlobalKey();

  late PageController _controller;
  late TabController _tabController;
  HomeType _currentPage = HomeType.kanlist;
  TabType _currentTab = TabType.kanlist;

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

  MarketFilters get _currentAppliedMarketFilter {
    final filterMarketText =
        getIt<PreferencesService>().readData(SharedKeys.filtersOnMarket) ??
            Market.uploadedToMarketField;
    return MarketFiltersUtils.getFilterFrom(filterMarketText);
  }

  bool get _currentAppliedMarketOrder =>
      getIt<PreferencesService>().readData(SharedKeys.orderOnMarket) ?? true;

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
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);

    getIt<ListBloc>().add(ListEventLoading(
      filter: _currentAppliedFilter,
      order: _currentAppliedOrder,
      reset: true,
    ));

    getIt<FolderBloc>().add(FolderEventLoading(
      filter: _currentAppliedFolderFilter,
      order: _currentAppliedFolderOrder,
      reset: true,
    ));

    getIt<BackUpBloc>().add(BackUpGetVersion(context));

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
    getIt<LoadTestBloc>().add(const LoadTestEventIdle(mode: Tests.daily));
    getIt<LoadGrammarTestBloc>()
        .add(const LoadGrammarTestEventIdle(mode: Tests.daily));
  }

  _addListLoadingEvent({bool reset = true}) =>
      getIt<ListBloc>().add(ListEventLoading(
          filter: _currentAppliedFilter,
          order: _currentAppliedOrder,
          reset: reset));

  _addListSearchingEvent(String query, {bool reset = true}) =>
      getIt<ListBloc>().add(ListEventSearching(query, reset: reset));

  _addFolderListLoadingEvent({bool reset = true}) =>
      getIt<FolderBloc>().add(FolderEventLoading(
          filter: _currentAppliedFolderFilter,
          order: _currentAppliedFolderOrder,
          reset: reset));

  _addFolderListSearchingEvent(String query, {bool reset = true}) =>
      getIt<FolderBloc>().add(FolderEventSearching(query, reset: reset));

  _addMarketLoadingEvent({bool reset = true}) =>
      getIt<MarketBloc>().add(MarketEventLoading(
          filter: _currentAppliedMarketFilter,
          order: _currentAppliedMarketOrder,
          reset: reset));

  _addMarketSearchingEvent(String query, {bool reset = true}) =>
      getIt<MarketBloc>().add(MarketEventSearching(query,
          reset: reset,
          order: _currentAppliedMarketOrder,
          filter: _currentAppliedMarketFilter));

  _focusListener() => _searchHasFocus = _searchBarFn.hasFocus;

  _onTabChanged() =>
      setState(() => _currentTab = TabType.values[_tabController.index]);

  _resetLists() {
    if (_currentPage == HomeType.kanlist) {
      if (_currentTab == TabType.kanlist) return _addListLoadingEvent();
      return _addFolderListLoadingEvent();
    }
    return _addMarketLoadingEvent();
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
      icon: const Icon(Icons.update_rounded, color: KPColors.secondaryColor),
    );
    final dictHistory = IconButton(
      onPressed: () {
        Navigator.of(context).pushNamed(KanPracticePages.historyWordPage);
      },
      icon: const Icon(Icons.history_rounded),
    );
    final listArchive = IconButton(
      onPressed: () {
        Navigator.of(context).pushNamed(KanPracticePages.archivePage);
      },
      icon: const Icon(Icons.all_inbox),
    );

    final List<IconButton> updateWithAppBarIcons =
        _currentPage == HomeType.dictionary
            ? [updateIcon, dictHistory]
            : _currentPage == HomeType.kanlist
                ? [updateIcon, listArchive]
                : [updateIcon];
    final List<IconButton> appBarIcons = _currentPage == HomeType.dictionary
        ? [dictHistory]
        : _currentPage == HomeType.kanlist
            ? [listArchive]
            : [];

    return BlocListener<BackUpBloc, BackUpState>(
      listener: (context, state) {
        if (state is BackUpStateVersionRetrieved) {
          setState(() {
            _newVersion = state.version;
            _notes = state.notes;
          });
        }
      },
      child: BlocConsumer<ListBloc, ListState>(
        listener: (context, state) async {
          if (state is ListStateLoaded) {
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
                market,
                settings,
              ], CoachTutorialParts.kanList)
                  .showTutorial(context, onEnd: () => _onTutorial = false);
            }
          }
        },
        builder: (c, state) => BlocBuilder<FolderBloc, FolderState>(
          builder: (cFolder, stateFolder) =>
              BlocBuilder<MarketBloc, MarketState>(
            builder: (cMarket, stateMarket) => KPScaffold(
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
              appBarTitle: _currentPage.appBarTitle,
              appBarActions:
                  _newVersion.isNotEmpty ? updateWithAppBarIcons : appBarIcons,
              bottomNavigationWidget: HomeBottomNavigation(
                tutorialKeys: [kanList, dictionary, actions, market, settings],
                currentPage: _currentPage,
                onPageChanged: (type) {
                  if (_currentPage != type && type != HomeType.actions) {
                    setState(() => _currentPage = type);
                    _searchBarFn.unfocus();
                    _searchTextController.text = "";
                    _controller.jumpToPage(type.page);
                    if (_currentPage == HomeType.market) {
                      _addMarketLoadingEvent();
                    }
                  }
                },
                onShowActions: (name) {
                  _addReviewEvent();
                  if (name != null) {
                    if (name == "__folder") {
                      _addFolderListLoadingEvent();
                    } else {
                      getIt<ListBloc>().add(ListEventCreate(name,
                          filter: _currentAppliedFilter,
                          order: _currentAppliedOrder));
                    }
                  }
                },
              ),
              child: Column(
                children: [
                  if (HomeType.kanlist == _currentPage ||
                      HomeType.market == _currentPage)
                    KPSearchBar(
                      controller: _searchTextController,
                      hint: _currentPage == HomeType.market
                          ? _currentPage.searchBarHint
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
                        return _addMarketSearchingEvent(query);
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
                            Expanded(child: _body()),
                          ],
                        ),
                        BlocBuilder<LoadTestBloc, LoadTestState>(
                          builder: (context, state) {
                            if (state is LoadTestStateIdle) {
                              final show =
                                  _showPendingReview(state.wordsToReview);
                              if (show) return _actionChipReview();
                              return BlocBuilder<LoadGrammarTestBloc,
                                  LoadGrammarTestState>(
                                builder: (context, state) {
                                  if (state is LoadGrammarTestStateIdle) {
                                    final show = _showPendingReview(
                                        state.grammarToReview);
                                    if (show) return _actionChipReview();
                                  }
                                  return const SizedBox();
                                },
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ActionChip _actionChipReview() {
    return ActionChip(
      avatar: const Icon(
        Icons.calendar_today,
        size: 16,
        color: Colors.white,
      ),
      label: Text("pending_review".tr()),
      backgroundColor: KPColors.getSecondaryColor(context),
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
              onScrolledToBottom: () {
                if (_query.isNotEmpty) {
                  return _addListSearchingEvent(_query, reset: false);
                }
                return _addListLoadingEvent(reset: false);
              },
            ),
            FolderListPage(
              removeFocus: () => _searchBarFn.unfocus(),
              onScrolledToBottom: () {
                if (_query.isNotEmpty) {
                  return _addFolderListSearchingEvent(_query, reset: false);
                }
                return _addFolderListLoadingEvent(reset: false);
              },
            ),
          ],
        ),
        const DictionaryPage(args: DictionaryArguments(searchInJisho: true)),
        MarketPage(
          removeFocus: () => _searchBarFn.unfocus(),
          onScrolledToBottom: () {
            if (_query.isNotEmpty) {
              return _addMarketSearchingEvent(_query, reset: false);
            }
            return _addMarketLoadingEvent(reset: false);
          },
        ),
        const SettingsPage()
      ],
    );
  }
}
