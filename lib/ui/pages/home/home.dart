import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/firebase/models/market_list.dart';
import 'package:kanpractice/core/firebase/queries/messaging.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/tutorial/tutorial_manager.dart';
import 'package:kanpractice/core/types/coach_tutorial_parts.dart';
import 'package:kanpractice/core/types/folder_filters.dart';
import 'package:kanpractice/core/types/home_types.dart';
import 'package:kanpractice/core/types/kanlist_filters.dart';
import 'package:kanpractice/core/types/market_filters.dart';
import 'package:kanpractice/core/types/tab_types.dart';
import 'package:kanpractice/ui/pages/dictionary/arguments.dart';
import 'package:kanpractice/ui/pages/dictionary/bloc/dict_bloc.dart';
import 'package:kanpractice/ui/pages/dictionary/dictionary.dart';
import 'package:kanpractice/ui/pages/folder_lists/bloc/folder_bloc.dart';
import 'package:kanpractice/ui/pages/folder_lists/folder_list.dart';
import 'package:kanpractice/ui/pages/home/widgets/bottom_navigation.dart';
import 'package:kanpractice/ui/pages/home/widgets/update_container.dart';
import 'package:kanpractice/ui/pages/settings/bloc/settings_bloc.dart';
import 'package:kanpractice/ui/pages/settings/settings.dart';
import 'package:kanpractice/ui/widgets/kp_test_bottom_sheet.dart';
import 'package:kanpractice/ui/widgets/kp_kanji_lists/bloc/lists_bloc.dart';
import 'package:kanpractice/ui/widgets/kp_kanji_lists/kanji_lists.dart';
import 'package:kanpractice/ui/pages/market/bloc/market_bloc.dart';
import 'package:kanpractice/ui/pages/market/market.dart';
import 'package:kanpractice/ui/widgets/kp_scaffold.dart';
import 'package:kanpractice/ui/widgets/kp_search_bar.dart';

class HomePage extends StatefulWidget {
  final bool? showTestBottomSheet;
  const HomePage({Key? key, this.showTestBottomSheet}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final lists = GlobalKey();
  final bottomActions = GlobalKey();
  final folders = GlobalKey();

  late PageController _controller;
  late TabController _tabController;
  HomeType _currentPage = HomeType.kanlist;
  TabType _currentTab = TabType.kanlist;

  late FocusNode _searchBarFn;
  late TextEditingController _searchTextController;
  bool _searchHasFocus = false;

  KanListFilters _currentAppliedFilter = KanListFilters.all;
  bool _currentAppliedOrder = true;
  FolderFilters _currentAppliedFolderFilter = FolderFilters.all;
  bool _currentAppliedFolderOrder = true;
  MarketFilters _currentAppliedMarketFilter = MarketFilters.all;
  bool _currentAppliedMarketOrder = true;

  String _query = "";
  bool _onTutorial = false;

  @override
  void initState() {
    _searchBarFn = FocusNode();
    _searchTextController = TextEditingController();
    _searchBarFn.addListener(_focusListener);
    _controller = PageController();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);

    final filterText = StorageManager.readData(StorageManager.filtersOnList) ??
        KanListTableFields.lastUpdatedField;
    _currentAppliedFilter = KanListFiltersUtils.getFilterFrom(filterText);
    _currentAppliedOrder =
        StorageManager.readData(StorageManager.orderOnList) ?? true;

    final filterFolderText =
        StorageManager.readData(StorageManager.filtersOnFolder) ??
            FolderTableFields.lastUpdatedField;
    _currentAppliedFolderFilter =
        FolderFiltersUtils.getFilterFrom(filterFolderText);
    _currentAppliedFolderOrder =
        StorageManager.readData(StorageManager.orderOnFolder) ?? true;

    final filterMarketText =
        StorageManager.readData(StorageManager.filtersOnMarket) ??
            MarketList.uploadedToMarketField;
    _currentAppliedMarketFilter =
        MarketFiltersUtils.getFilterFrom(filterMarketText);
    _currentAppliedMarketOrder =
        StorageManager.readData(StorageManager.orderOnMarket) ?? true;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      /// Read folder from SharedPreferences, current selected folder for the latest
      /// test. If any, show that BS and navigate to that tab. Else just
      /// show the BS with all tests
      String? folder = StorageManager.readData(StorageManager.folderWhenOnTest);
      bool hasFolder = folder != null && folder.isNotEmpty;
      if (hasFolder) _tabController.animateTo(1);
      if (widget.showTestBottomSheet == true) {
        await KPTestBottomSheet.show(
          context,
          folder: hasFolder ? folder : null,
        );
      }

      // ignore: use_build_context_synchronously
      await MessagingHandler.handler(context);
    });
    super.initState();
  }

  KanjiListEventLoading _addKanjiListLoadingEvent({bool reset = true}) =>
      KanjiListEventLoading(
          filter: _currentAppliedFilter,
          order: _currentAppliedOrder,
          reset: reset);

  KanjiListEventSearching _addKanjiListSearchingEvent(String query,
          {bool reset = true}) =>
      KanjiListEventSearching(query, reset: reset);

  FolderEventLoading _addFolderListLoadingEvent({bool reset = true}) =>
      FolderEventLoading(
          filter: _currentAppliedFolderFilter,
          order: _currentAppliedFolderOrder,
          reset: reset);

  FolderEventSearching _addFolderListSearchingEvent(String query,
          {bool reset = true}) =>
      FolderEventSearching(query, reset: reset);

  MarketEventLoading _addMarketLoadingEvent({bool reset = true}) =>
      MarketEventLoading(
          filter: _currentAppliedMarketFilter,
          order: _currentAppliedMarketOrder,
          reset: reset);

  MarketEventSearching _addMarketSearchingEvent(String query,
          {bool reset = true}) =>
      MarketEventSearching(query,
          reset: reset,
          order: _currentAppliedMarketOrder,
          filter: _currentAppliedMarketFilter);

  _focusListener() => _searchHasFocus = _searchBarFn.hasFocus;

  _onTabChanged() =>
      setState(() => _currentTab = TabType.values[_tabController.index]);

  _resetLists(BuildContext c1, BuildContext c2, BuildContext c3) {
    if (_currentPage == HomeType.kanlist) {
      if (_currentTab == TabType.kanlist) {
        c1.read<KanjiListBloc>().add(_addKanjiListLoadingEvent());
      } else {
        c2.read<FolderBloc>().add(_addFolderListLoadingEvent());
      }
    } else {
      c3.read<MarketBloc>().add(_addMarketLoadingEvent());
    }
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
    /// Do not retrieve lists from Firebase until the user taps on Market.
    return MultiBlocProvider(
      providers: [
        BlocProvider<KanjiListBloc>(
            create: (_) => KanjiListBloc()..add(_addKanjiListLoadingEvent())),
        BlocProvider<FolderBloc>(
            create: (_) => FolderBloc()..add(_addFolderListLoadingEvent())),
        BlocProvider(create: (_) => DictBloc()..add(DictEventIdle())),
        BlocProvider<MarketBloc>(
            create: (_) => MarketBloc()..add(MarketEventIdle())),
        BlocProvider(
          create: (_) => SettingsBloc()..add(SettingsIdle()),
        )
      ],
      child: BlocConsumer<KanjiListBloc, KanjiListState>(
        listener: (context, state) async {
          if (state is KanjiListStateLoaded) {
            if (StorageManager.readData(
                    StorageManager.haveSeenKanListCoachMark) ==
                false) {
              _onTutorial = true;
              await TutorialCoach([lists, folders, bottomActions],
                      CoachTutorialParts.kanList)
                  .showTutorial(context, onEnd: () => _onTutorial = false);
            }
          }
        },
        builder: (context, state) => BlocBuilder<FolderBloc, FolderState>(
          builder: (contextFolder, stateFolder) =>
              BlocBuilder<MarketBloc, MarketState>(
            builder: (contextMarket, stateMarket) => KPScaffold(
              onWillPop: () async {
                if (_onTutorial) return false;
                if (_searchHasFocus) {
                  _resetLists(context, context, context);
                  _searchBarFn.unfocus();
                  return false;
                } else {
                  return true;
                }
              },
              appBarTitle: _currentPage.appBarTitle,
              bottomNavigationWidget: HomeBottomNavigation(
                key: bottomActions,
                currentPage: _currentPage,
                onPageChanged: (type) {
                  if (_currentPage != type && type != HomeType.actions) {
                    setState(() => _currentPage = type);
                    _searchBarFn.unfocus();
                    _searchTextController.text = "";
                    _controller.jumpToPage(type.page);
                    if (_currentPage == HomeType.market) {
                      contextMarket
                          .read<MarketBloc>()
                          .add(_addMarketLoadingEvent());
                    }
                  }
                },
                onShowActions: (name) {
                  if (name == "__folder") {
                    contextFolder
                        .read<FolderBloc>()
                        .add(_addFolderListLoadingEvent());
                  } else {
                    context.read<KanjiListBloc>().add(KanjiListEventCreate(name,
                        filter: _currentAppliedFilter,
                        order: _currentAppliedOrder));
                  }
                },
              ),
              child: Column(
                children: [
                  const UpdateContainer(),
                  KPSearchBar(
                    controller: _searchTextController,
                    hint: _currentPage == HomeType.market
                        ? _currentPage.searchBarHint
                        : _currentTab.searchBarHint,
                    focus: _searchBarFn,
                    onQuery: (String query) {
                      /// Everytime the user queries, reset the query itself and
                      /// the pagination index
                      _query = query;
                      if (_currentPage == HomeType.kanlist) {
                        if (_currentTab == TabType.kanlist) {
                          context
                              .read<KanjiListBloc>()
                              .add(_addKanjiListSearchingEvent(query));
                        } else {
                          contextFolder
                              .read<FolderBloc>()
                              .add(_addFolderListSearchingEvent(query));
                        }
                      } else {
                        contextMarket
                            .read<MarketBloc>()
                            .add(_addMarketSearchingEvent(query));
                      }
                    },
                    onExitSearch: () {
                      /// Empty the query
                      _query = "";
                      _resetLists(context, contextFolder, contextMarket);
                    },
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        if (_currentPage == HomeType.kanlist)
                          TabBar(
                            key: folders,
                            controller: _tabController,
                            onTap: (tab) {
                              if (tab == 0) {
                                context
                                    .read<KanjiListBloc>()
                                    .add(_addKanjiListLoadingEvent());
                              } else {
                                contextFolder
                                    .read<FolderBloc>()
                                    .add(_addFolderListLoadingEvent());
                              }
                            },
                            tabs: const [
                              Tab(icon: Icon(Icons.table_rows_rounded)),
                              Tab(icon: Icon(Icons.folder_rounded)),
                            ],
                          ),
                        Expanded(
                          child: _body(
                            context,
                            contextFolder,
                            contextMarket,
                          ),
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

  Widget _tabView(BuildContext c, BuildContext cF) {
    return TabBarView(
      controller: _tabController,
      children: [
        KPKanjiLists(
          key: lists,
          removeFocus: () => _searchBarFn.unfocus(),
          onScrolledToBottom: () {
            /// If the query is empty, use the pagination for search bar
            if (_query.isNotEmpty) {
              c
                  .read<KanjiListBloc>()
                  .add(_addKanjiListSearchingEvent(_query, reset: false));
            }

            /// Else use the normal pagination
            else {
              c
                  .read<KanjiListBloc>()
                  .add(_addKanjiListLoadingEvent(reset: false));
            }
          },
        ),
        FolderList(
          removeFocus: () => _searchBarFn.unfocus(),
          onScrolledToBottom: () {
            /// If the query is empty, use the pagination for search bar
            if (_query.isNotEmpty) {
              cF
                  .read<FolderBloc>()
                  .add(_addFolderListSearchingEvent(_query, reset: false));
            }

            /// Else use the normal pagination
            else {
              cF
                  .read<FolderBloc>()
                  .add(_addFolderListLoadingEvent(reset: false));
            }
          },
        ),
      ],
    );
  }

  PageView _body(BuildContext c, BuildContext cF, BuildContext cM) {
    return PageView(
      controller: _controller,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _tabView(c, cF),
        const DictionaryPage(args: DictionaryArguments(searchInJisho: true)),
        MarketPlace(
          removeFocus: () => _searchBarFn.unfocus(),
          onScrolledToBottom: () {
            /// If the query is empty, use the pagination for search bar
            if (_query.isNotEmpty) {
              cM
                  .read<MarketBloc>()
                  .add(_addMarketSearchingEvent(_query, reset: false));
            }

            /// Else use the normal pagination
            else {
              cM.read<MarketBloc>().add(_addMarketLoadingEvent(reset: false));
            }
          },
        ),
        const Settings()
      ],
    );
  }
}
