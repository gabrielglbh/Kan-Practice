import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/firebase/models/market_list.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/core/tutorial/tutorial_manager.dart';
import 'package:kanpractice/core/types/coach_tutorial_parts.dart';
import 'package:kanpractice/core/types/home_types.dart';
import 'package:kanpractice/core/types/kanlist_filters.dart';
import 'package:kanpractice/core/types/market_filters.dart';
import 'package:kanpractice/ui/pages/dictionary/arguments.dart';
import 'package:kanpractice/ui/pages/home/widgets/actions_bottom_sheet.dart';
import 'package:kanpractice/ui/pages/home/widgets/update_container.dart';
import 'package:kanpractice/ui/pages/kanji_lists/bloc/lists_bloc.dart';
import 'package:kanpractice/ui/pages/kanji_lists/kanji_lists.dart';
import 'package:kanpractice/ui/pages/kanji_lists/widgets/test_bottom_sheet.dart';
import 'package:kanpractice/ui/pages/market/bloc/market_bloc.dart';
import 'package:kanpractice/ui/pages/market/market.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/widgets/kp_scaffold.dart';
import 'package:kanpractice/ui/widgets/kp_search_bar.dart';

class HomePage extends StatefulWidget {
  final bool? showTestBottomSheet;
  const HomePage({Key? key, this.showTestBottomSheet}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final lists = GlobalKey();
  final bottomActions = GlobalKey();
  final dictionary = GlobalKey();

  late PageController _controller;
  HomeType _currentPage = HomeType.kanlist;

  late FocusNode _searchBarFn;
  late TextEditingController _searchTextController;
  bool _searchHasFocus = false;

  KanListFilters _currentAppliedFilter = KanListFilters.all;
  bool _currentAppliedOrder = true;
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

    final filterText = StorageManager.readData(StorageManager.filtersOnList) ??
        KanListTableFields.lastUpdatedField;
    _currentAppliedFilter = KanListFiltersUtils.getFilterFrom(filterText);
    _currentAppliedOrder =
        StorageManager.readData(StorageManager.orderOnList) ?? true;

    final filterMarketText =
        StorageManager.readData(StorageManager.filtersOnMarket) ??
            MarketList.uploadedToMarketField;
    _currentAppliedMarketFilter =
        MarketFiltersUtils.getFilterFrom(filterMarketText);
    _currentAppliedMarketOrder =
        StorageManager.readData(StorageManager.orderOnMarket) ?? true;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.showTestBottomSheet == true) {
        await TestBottomSheet.show(context);
      }
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

  _resetLists(BuildContext c1, BuildContext c2) {
    if (_currentPage == HomeType.kanlist) {
      BlocProvider.of<KanjiListBloc>(c1).add(_addKanjiListLoadingEvent());
    } else {
      BlocProvider.of<MarketBloc>(c2).add(_addMarketLoadingEvent());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchTextController.dispose();
    _searchBarFn.removeListener(_focusListener);
    _searchBarFn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// In order to make proper calls to BlocProvider.of(context).add(...) within
    /// deep widgets, we will need to wrap them up in BlocBuilders to get the
    /// proper context to make the call.
    ///
    /// We can also nest various BlocBuilders to achieve listening to various
    /// BlocProviders and perform various calls to distinct providers.
    return MultiBlocProvider(
      providers: [
        BlocProvider<KanjiListBloc>(
            create: (_) => KanjiListBloc()..add(_addKanjiListLoadingEvent())),

        /// Do not retrieve lists from Firebase until the user taps on Market.
        BlocProvider<MarketBloc>(
            create: (_) => MarketBloc()..add(MarketEventIdle())),
      ],
      child: BlocConsumer<KanjiListBloc, KanjiListState>(
        listener: (context, state) async {
          if (state is KanjiListStateLoaded) {
            if (StorageManager.readData(
                    StorageManager.haveSeenKanListCoachMark) ==
                false) {
              _onTutorial = true;
              await TutorialCoach([lists, bottomActions, dictionary],
                      CoachTutorialParts.kanList)
                  .showTutorial(context, onEnd: () => _onTutorial = false);
            }
          }
        },
        builder: (context1, state1) => KPScaffold(
          onWillPop: () async {
            if (_onTutorial) return false;
            if (_searchHasFocus) {
              _resetLists(context, context);
              _searchBarFn.unfocus();
              return false;
            } else {
              return true;
            }
          },
          appBarTitle: _currentPage.appBarTitle,
          appBarActions: [
            IconButton(
              key: dictionary,
              icon: const Icon(Icons.menu_book_rounded),
              onPressed: () {
                Navigator.of(context).pushNamed(KanPracticePages.dictionaryPage,
                    arguments: const DictionaryArguments(searchInJisho: true));
              },
            ),
            IconButton(
              onPressed: () async {
                await Navigator.of(context)
                    .pushNamed(KanPracticePages.settingsPage)
                    .then((code) {
                  if (_currentPage == HomeType.kanlist) {
                    context1
                        .read<KanjiListBloc>()
                        .add(_addKanjiListLoadingEvent());
                  }
                });
              },
              icon: const Icon(Icons.settings),
            )
          ],
          bottomNavigationWidget: _bottomNavigationBar(),
          child: Column(
            children: [
              const UpdateContainer(),
              BlocBuilder<MarketBloc, MarketState>(
                builder: (context2, state2) => KPSearchBar(
                  controller: _searchTextController,
                  hint: _currentPage.searchBarHint,
                  focus: _searchBarFn,
                  onQuery: (String query) {
                    /// Everytime the user queries, reset the query itself and
                    /// the pagination index
                    _query = query;
                    if (_currentPage == HomeType.kanlist) {
                      context1
                          .read<KanjiListBloc>()
                          .add(_addKanjiListSearchingEvent(query));
                    } else {
                      context2
                          .read<MarketBloc>()
                          .add(_addMarketSearchingEvent(query));
                    }
                  },
                  onExitSearch: () {
                    /// Empty the query
                    _query = "";
                    _resetLists(context1, context2);
                  },
                ),
              ),
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      if (_currentPage == HomeType.kanlist)
                        const TabBar(tabs: [
                          Tab(icon: Icon(Icons.table_rows_rounded)),
                          Tab(icon: Icon(Icons.folder_rounded)),
                        ]),
                      Expanded(child: _body()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabView() {
    return TabBarView(
      children: [
        BlocBuilder<KanjiListBloc, KanjiListState>(
          builder: (context, state) => KanjiLists(
            key: lists,
            removeFocus: () => _searchBarFn.unfocus(),
            onScrolledToBottom: () {
              /// If the query is empty, use the pagination for search bar
              if (_query.isNotEmpty) {
                context
                    .read<KanjiListBloc>()
                    .add(_addKanjiListSearchingEvent(_query, reset: false));
              }

              /// Else use the normal pagination
              else {
                context
                    .read<KanjiListBloc>()
                    .add(_addKanjiListLoadingEvent(reset: false));
              }
            },
          ),
        ),
        Container(width: 250, height: 250, color: Colors.amber)
      ],
    );
  }

  PageView _body() {
    return PageView(
      controller: _controller,
      onPageChanged: (page) {
        if (HomeType.values[page] != _currentPage) {
          setState(() => _currentPage = HomeType.values[page]);
        }
      },
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _tabView(),
        BlocBuilder<MarketBloc, MarketState>(
          builder: (context, state) => MarketPlace(
            removeFocus: () => _searchBarFn.unfocus(),
            onScrolledToBottom: () {
              /// If the query is empty, use the pagination for search bar
              if (_query.isNotEmpty) {
                context
                    .read<MarketBloc>()
                    .add(_addMarketSearchingEvent(_query, reset: false));
              }

              /// Else use the normal pagination
              else {
                context
                    .read<MarketBloc>()
                    .add(_addMarketLoadingEvent(reset: false));
              }
            },
          ),
        )
      ],
    );
  }

  Widget _bottomNavigationBar() {
    return Stack(
        clipBehavior: Clip.none,
        alignment: const FractionalOffset(.5, 1.0),
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey
                        : Colors.black,
                    blurRadius: 10)
              ],
            ),
            child: BlocBuilder<MarketBloc, MarketState>(
              builder: (context, state) => BottomNavigationBar(
                key: bottomActions,
                currentIndex: _currentPage.index,
                onTap: (page) {
                  /// Avoid extra loading when tapping the same item
                  if (_currentPage.index != page) {
                    _searchBarFn.unfocus();
                    _searchTextController.text = "";
                    _controller.jumpToPage(page);
                    if (_currentPage == HomeType.market) {
                      context.read<MarketBloc>().add(_addMarketLoadingEvent());
                    }
                  }
                },
                items: [
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.table_rows_rounded),
                      label: "bottom_nav_kanlists".tr()),
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.shopping_bag_rounded),
                      label: "bottom_nav_market".tr()),
                ],
              ),
            ),
          ),
          _actionsButton(),
        ]);
  }

  Widget _actionsButton() {
    return BlocBuilder<KanjiListBloc, KanjiListState>(
      builder: (context, state) => GestureDetector(
        onTap: () async {
          final kanListName =
              await ActionsBottomSheet.show(context, _currentPage);
          if (kanListName != null) {
            context.read<KanjiListBloc>().add(KanjiListEventCreate(kanListName,
                filter: _currentAppliedFilter, order: _currentAppliedOrder));
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: Margins.margin8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                  padding: const EdgeInsets.only(bottom: Margins.margin4),
                  child: Icon(Icons.add,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.grey.shade700
                          : Colors.grey.shade400)),
              Text("bottom_nav_actions".tr(),
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.grey.shade700
                          : Colors.grey.shade400))
            ],
          ),
        ),
      ),
    );
  }
}
