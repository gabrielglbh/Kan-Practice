import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/firebase/queries/back_ups.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/core/tutorial/tutorial_manager.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/core/utils/types/coach_tutorial_parts.dart';
import 'package:kanpractice/core/utils/types/visualization_mode.dart';
import 'package:kanpractice/ui/pages/dictionary/arguments.dart';
import 'package:kanpractice/ui/pages/kanji_lists/bloc/lists_bloc.dart';
import 'package:kanpractice/core/utils/types/filters.dart';
import 'package:kanpractice/ui/pages/kanji_lists/widgets/TestBottomSheet.dart';
import 'package:kanpractice/ui/widgets/CreateKanListDialog.dart';
import 'package:kanpractice/ui/widgets/CustomSearchBar.dart';
import 'package:kanpractice/ui/pages/kanji_lists/widgets/KanListTile.dart';
import 'package:kanpractice/ui/widgets/EmptyList.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/ProgressIndicator.dart';
import 'package:kanpractice/ui/widgets/fab_dial/dial.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';

class KanjiLists extends StatefulWidget {
  final bool? showTestBottomSheet;
  const KanjiLists({this.showTestBottomSheet = false});

  @override
  _KanjiListsState createState() => _KanjiListsState();
}

class _KanjiListsState extends State<KanjiLists> {
  final KanjiListBloc _bloc = KanjiListBloc();
  final ScrollController _scrollController = ScrollController();
  FocusNode? _searchBarFn;

  /// Tutorial Global Keys
  final GlobalKey lists = GlobalKey();
  final GlobalKey addLists = GlobalKey();
  final GlobalKey actions = GlobalKey();
  final GlobalKey market = GlobalKey();

  /// This variable keeps track of the actual filter applied. The value is
  /// saved into the shared preferences when a filter is applied.
  /// This value is then restored upon new session.
  String _currentAppliedFilter = KanListTableFields.lastUpdatedField;
  /// State map for the filters, independent of the bloc.
  Map<String, bool> _filterValues = {
    KanListTableFields.lastUpdatedField: true,
    KanListTableFields.totalWinRateWritingField: false,
    KanListTableFields.totalWinRateReadingField: false,
    KanListTableFields.totalWinRateRecognitionField: false,
    KanListTableFields.totalWinRateListeningField: false
  };

  /// This variable keeps track of the order applied on the current filter only:
  /// true --> DESC or false --> ASC. The value is saved into the shared preferences when a filter
  /// is applied. This value is then restored upon new session.
  bool _currentAppliedOrder = true;
  bool _searchHasFocus = false;
  bool _onTutorial = false;

  /// Loading offset for normal pagination
  int _loadingTimes = 0;
  /// Loading offset for search bar list pagination
  int _loadingTimesForSearch = 0;
  /// Saves the last state of the query
  String _query = "";

  String _newVersion = "";

  @override
  void initState() {
    _searchBarFn = FocusNode();
    _searchBarFn?.addListener(_focusListener);
    _scrollController.addListener(_scrollListener);
    _currentAppliedFilter = StorageManager.readData(StorageManager.filtersOnList)
        ?? KanListTableFields.lastUpdatedField;
    _currentAppliedOrder = StorageManager.readData(StorageManager.orderOnList)
        ?? true;
    _getVersionNotice();

    /// If showTestBottomSheet is true, show directly the test bottom sheet
    /// when launching the page. Only true when coming back from the TestResultPage.
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      if (widget.showTestBottomSheet != null && widget.showTestBottomSheet!)
        await _loadTests();
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchBarFn?.removeListener(_focusListener);
    _searchBarFn?.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _bloc.close();
    super.dispose();
  }

  Future<void> _getVersionNotice() async {
    String v = await BackUpRecords.instance.getVersion();
    PackageInfo pi = await PackageInfo.fromPlatform();
    if (v != pi.version && v != "") setState(() => _newVersion = v);
  }

  Future<void> _loadTests() async => await TestBottomSheet.show(context);

  _focusListener() => setState(() => _searchHasFocus = (_searchBarFn?.hasFocus ?? false));

  _scrollListener() {
    /// When reaching last pixel of the list
    if (_scrollController.offset == _scrollController.position.maxScrollExtent) {
      /// If the query is empty, use the pagination for search bar
      if (_query.isNotEmpty) {
        _loadingTimesForSearch += 1;
        _addSearchingEvent(_query, offset: _loadingTimesForSearch);
      }
      /// Else use the normal pagination
      else {
        _loadingTimes += 1;
        _addLoadingEvent(offset: _loadingTimes);
      }
    }
  }

  _addLoadingEvent({int offset = 0}) {
    /// If the loading occurs with an offset of 0, it means it is another
    /// fresh load, so we need to update the _loadingTimes offset to 0
    if (offset == 0) _loadingTimes = 0;
    return _bloc..add(KanjiListEventLoading(
        filter: _currentAppliedFilter, order: _currentAppliedOrder, offset: offset));
  }

  _addSearchingEvent(String query, {int offset = 0}) {
    /// If the loading occurs with an offset of 0, it means it is another
    /// fresh load, so we need to update the _loadingTimes offset to 0
    if (offset == 0) _loadingTimesForSearch = 0;
    return _bloc..add(KanjiListEventSearching(query, offset: offset));
  }

  _getCurrentIndexOfFilter() => _filterValues.keys.toList().indexOf(_currentAppliedFilter);

  _resetOffsets() {
    /// When creating or removing a list, reset any pagination offset to load up,
    /// from the start
    _loadingTimes = 0;
    _loadingTimesForSearch = 0;
    /// And scroll to the top
    _scrollController.animateTo(0, duration: Duration(milliseconds: 400), curve: Curves.easeOut);
  }

  _onFilterSelected(int index) {
    /// If the user taps on the same filter twice, just change back and forth the
    /// order value
    if (_getCurrentIndexOfFilter() == index)
      setState(() => _currentAppliedOrder = !_currentAppliedOrder);
    /// Else, means the user has changed the filter, therefore default the order to DESC
    else
      setState(() => _currentAppliedOrder = true);

    /// Change the current applied filter based on the index selected on the ChoiceChip
    /// and change the value on _filterValues map to reflect the change on the UI
    _currentAppliedFilter = KanListFilters.values[index].filter;
    setState(() {
      _filterValues.updateAll((key, value) => false);
      _filterValues.update(_currentAppliedFilter, (value) => true);
    });
    /// Adds the loading event to the bloc builder to load the new specified list
    _addLoadingEvent();
    /// Stores the new filter and order applied to shared preferences
    StorageManager.saveData(StorageManager.filtersOnList, _currentAppliedFilter);
    StorageManager.saveData(StorageManager.orderOnList, _currentAppliedOrder);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_onTutorial) return false;
        if (_searchHasFocus) {
          _addLoadingEvent();
          _searchBarFn?.unfocus();
          return false;
        } else return true;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: CustomSizes.appBarHeight,
          title: FittedBox(fit: BoxFit.fitWidth, child: Text("KanPractice")),
          actions: [
            IconButton(
              key: market,
              icon: Icon(Icons.shopping_bag_rounded),
              onPressed: () async {
                await Navigator.of(context).pushNamed(KanPracticePages.marketPlace).then((code) {
                  _addLoadingEvent(offset: _loadingTimes);
                });
              },
            ),
            IconButton(
              key: actions,
              icon: Icon(Icons.menu_book_rounded),
              onPressed: () {
                Navigator.of(context).pushNamed(
                    KanPracticePages.dictionaryPage, arguments: DictionaryArguments(searchInJisho: true));
              },
            ),
            IconButton(
              onPressed: () async {
                await Navigator.of(context).pushNamed(KanPracticePages.settingsPage).then((code) {
                  _addLoadingEvent(offset: _loadingTimes);
                });
              },
              icon: Icon(Icons.settings),
            )
          ],
        ),
        body: BlocProvider<KanjiListBloc>(
          create: (_) => _addLoadingEvent(),
          child: Column(
            children: [
              Visibility(
                visible: _newVersion.isNotEmpty,
                child: _updateContainer()
              ),
              CustomSearchBar(
                hint: "kanji_lists_searchBar_hint".tr(),
                focus: _searchBarFn,
                onQuery: (String query) {
                  /// Everytime the user queries, reset the query itself and
                  /// the pagination index
                  _query = query;
                  _addSearchingEvent(query);
                },
                onExitSearch: () {
                  /// Empty the query
                  _query = "";
                  _addLoadingEvent();
                },
              ),
              _filterChips(),
              _lists()
            ],
          )
        ),
        floatingActionButton: _searchHasFocus ? null : _fab(),
      ),
    );
  }

  Widget _fab() {
    return Dial(
      key: addLists,
      icon: AnimatedIcons.menu_close,
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.white : Colors.black,
      dialChildren: [
        DialChild(
          child: Icon(Icons.track_changes_rounded, color: Colors.white),
          onPressed: () async => await _loadTests()
        ),
        DialChild(
          child: Icon(Icons.add, color: Colors.white),
          onPressed: () => CreateKanListDialog.showCreateKanListDialog(context,
            onSubmit: (String name) {
              _bloc..add(KanjiListEventCreate(
                  name, filter: _currentAppliedFilter, order: _currentAppliedOrder));
              _resetOffsets();
            }),
        ),
      ]
    );
  }

  Container _filterChips() {
    Icon icon = Icon(_currentAppliedOrder
        ? Icons.arrow_downward_rounded
        : Icons.arrow_upward_rounded,
        color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black);

    return Container(
      height: CustomSizes.defaultSizeFiltersList,
      padding: EdgeInsets.all(Margins.margin8),
      child: ListView.builder(
        itemCount: KanListFilters.values.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: Margins.margin2),
            child: ChoiceChip(
              label: Text(KanListFilters.values[index].label),
              avatar: _getCurrentIndexOfFilter() != index ? null : icon,
              pressElevation: Margins.margin4,
              padding: EdgeInsets.symmetric(horizontal: Margins.margin8),
              onSelected: (bool selected) => _onFilterSelected(index),
              selected: _getCurrentIndexOfFilter() == index,
            ),
          );
        }
      )
    );
  }

  BlocListener _lists() {
    return BlocListener<KanjiListBloc, KanjiListState>(
      listener: (context, state) async {
        if (state is KanjiListStateLoaded) {
          if (StorageManager.readData(StorageManager.haveSeenKanListCoachMark) == false) {
            _onTutorial = true;
            await TutorialCoach([lists, addLists, actions, market], CoachTutorialParts.kanList)
                .showTutorial(context, onEnd: () => _onTutorial = false);
          }
        }
      },
      child: BlocBuilder<KanjiListBloc, KanjiListState>(
        key: lists,
        builder: (context, state) {
          if (state is KanjiListStateFailure)
            return EmptyList(
              showTryButton: true,
              onRefresh: () => _addLoadingEvent(),
              message: "kanji_lists_load_failed".tr()
            );
          else if (state is KanjiListStateLoading || state is KanjiListStateSearching)
            return Expanded(child: CustomProgressIndicator());
          else if (state is KanjiListStateLoaded)
            return state.lists.isEmpty
                ? Expanded(child:
              EmptyList(
                onRefresh: () => _addLoadingEvent(),
                showTryButton: true,
                message: "kanji_lists_empty".tr())
            )
                : Expanded(
              child: RefreshIndicator(
                onRefresh: () => _addLoadingEvent(),
                child: ListView.builder(
                  key: PageStorageKey<String>('kanListListsController'),
                  controller: _scrollController,
                  itemCount: state.lists.length,
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.only(bottom: CustomSizes.extraPaddingForFAB),
                  itemBuilder: (context, k) {
                    return Card(
                      margin: EdgeInsets.all(Margins.margin8),
                      child: KanListTile(
                        item: state.lists[k],
                        onTap: () => _searchBarFn?.unfocus(),
                        mode: VisualizationModeExt.mode(StorageManager.readData(
                            StorageManager.kanListGraphVisualization)
                              ?? VisualizationMode.radialChart),
                        onRemoval: () {
                          _bloc..add(KanjiListEventDelete(
                            state.lists[k],
                            filter: _currentAppliedFilter,
                            order: _currentAppliedOrder,
                          ));
                          _resetOffsets();
                        },
                        onPopWhenTapped: () => _addLoadingEvent()
                      ),
                    );
                  }
                ),
              ),
            );
          else return Container();
        },
      ),
    );
  }

  Widget _updateContainer() {
    return GestureDetector(
      onTap: () async => await GeneralUtils.showVersionNotes(context, version: _newVersion),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(CustomRadius.radius16),
          color: CustomColors.getSecondaryColor(context)
        ),
        padding: EdgeInsets.symmetric(vertical: Margins.margin8),
        margin: EdgeInsets.only(bottom: Margins.margin8, right: Margins.margin32, left: Margins.margin32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Margins.margin16),
              child: Text("kanji_lists_newUpdateAvailable_label".tr(), style: Theme.of(context)
                .textTheme.headline5?.copyWith(
                  fontWeight: FontWeight.bold, color: Colors.white
              )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Margins.margin16),
              child: Icon(Icons.system_update, color: Colors.white)
            )
          ],
        ),
      )
    );
  }
}
