import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/list_details_grammar_points/list_details_grammar_points_bloc.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/add_grammar_point_page/arguments.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/presentation/core/types/grammar_modes.dart';
import 'package:kanpractice/presentation/core/types/test_modes.dart';
import 'package:kanpractice/presentation/core/ui/kp_button.dart';
import 'package:kanpractice/presentation/core/ui/kp_empty_list.dart';
import 'package:kanpractice/presentation/core/ui/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/ui/list_details_widgets/kp_grammar_point_item.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/grammar_modes/utils/grammar_mode_arguments.dart';

class GrammarListWidget extends StatefulWidget {
  final WordList list;
  final String listName;
  final String query;
  final FocusNode? searchBarFn;
  const GrammarListWidget(
      {Key? key,
      required this.list,
      required this.query,
      this.searchBarFn,
      required this.listName})
      : super(key: key);

  @override
  State<GrammarListWidget> createState() => _GrammarListWidgetState();
}

class _GrammarListWidgetState extends State<GrammarListWidget>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  TabController? _tabController;
  GrammarModes _selectedMode = GrammarModes.definition;
  bool _aggrStats = false;

  @override
  void initState() {
    _tabController =
        TabController(length: GrammarModes.values.length, vsync: this);
    _tabController?.addListener(_tabControllerManagement);
    _scrollController.addListener(_scrollListener);
    _aggrStats = getIt<PreferencesService>()
        .readData(SharedKeys.kanListListVisualization);
    getIt<ListDetailGrammarPointsBloc>().add(
      ListDetailGrammarPointsEventLoading(widget.listName, reset: true),
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  _scrollListener() {
    /// When reaching last pixel of the list
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      /// If the query is empty, use the pagination for search bar
      if (widget.query.isNotEmpty) {
        _addSearchingEvent(widget.query);
      }

      /// Else use the normal pagination
      else {
        _addLoadingEvent();
      }
    }
  }

  _tabControllerManagement() {
    widget.searchBarFn?.unfocus();
    setState(() {
      _selectedMode = GrammarModes.values[_tabController?.index ?? 0];
    });
  }

  _onModeChange(GrammarModes newMode) {
    widget.searchBarFn?.unfocus();
    setState(() {
      _selectedMode = newMode;
    });
    _tabController?.animateTo(newMode.index,
        duration: const Duration(milliseconds: KPAnimations.ms300),
        curve: Curves.easeInOut);
  }

  _updateSelectedModePageView(double pv) {
    switch (_selectedMode) {
      case GrammarModes.definition:
        if (pv < 0) _onModeChange(GrammarModes.grammarPoints);
        break;
      case GrammarModes.grammarPoints:
        if (pv > 0) _onModeChange(GrammarModes.definition);
        break;
    }
  }

  _addLoadingEvent({bool reset = false}) {
    return getIt<ListDetailGrammarPointsBloc>().add(
        ListDetailGrammarPointsEventLoading(widget.listName, reset: reset));
  }

  _addSearchingEvent(String query, {bool reset = false}) {
    return getIt<ListDetailGrammarPointsBloc>().add(
        ListDetailGrammarPointsEventSearching(query, widget.listName,
            reset: reset));
  }

  Future<void> _goToPractice(
      ListDetailGrammarPointsStateLoadedPractice state) async {
    await Navigator.of(context)
        .pushNamed(state.mode.page,
            arguments: GrammarModeArguments(
                studyList: state.list,
                isTest: false,
                mode: state.mode,
                testMode: Tests.blitz,
                studyModeHeaderDisplayName: widget.listName))
        .then(
          (value) => _addLoadingEvent(reset: true),
        );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<ListDetailGrammarPointsBloc,
        ListDetailGrammarPointsState>(
      listener: (context, state) async {
        if (state is ListDetailGrammarPointsStateLoadedPractice) {
          await _goToPractice(state);
        } else if (state is ListDetailGrammarPointsStateFailure) {
          if (state.error.isNotEmpty) {
            Utils.getSnackBar(context, state.error);
          }
        }
      },
      builder: (context, state) {
        if (state is ListDetailGrammarPointsStateLoaded) {
          return _body(state);
        } else if (state is ListDetailGrammarPointsStateLoading ||
            state is ListDetailGrammarPointsStateSearching ||
            state is ListDetailGrammarPointsStateIdle ||
            state is ListDetailGrammarPointsStateLoadedPractice) {
          return const KPProgressIndicator();
        } else if (state is ListDetailGrammarPointsStateFailure) {
          return KPEmptyList(
              showTryButton: true,
              onRefresh: () => _addLoadingEvent(reset: true),
              message: "list_details_load_failed_grammar".tr());
        } else {
          return Container();
        }
      },
    );
  }

  Column _body(ListDetailGrammarPointsStateLoaded state) {
    return Column(
      children: [
        if (!_aggrStats)
          Padding(
            padding: const EdgeInsets.only(bottom: KPMargins.margin8),
            child: TabBar(
                controller: _tabController,
                tabs: List.generate(GrammarModes.values.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Icon(
                      GrammarModes.values[index].icon,
                      color: GrammarModes.values[index].color,
                    ),
                  );
                })),
          ),
        _aggrStats
            ? Expanded(child: _grammarList(state))
            : Expanded(
                child: GestureDetector(
                  onHorizontalDragEnd: (details) {
                    double? pv = details.primaryVelocity;
                    if (pv != null) _updateSelectedModePageView(pv);
                  },
                  child: _grammarList(state),
                ),
              ),
        KPButton(
            title1: "list_details_practice_button_label_ext".tr(),
            title2: "list_details_practice_button_label".tr(),
            onTap: () async {
              getIt<ListDetailGrammarPointsBloc>().add(
                  ListDetailGrammarPointsEventLoadUpPractice(
                      widget.listName, _selectedMode));
            }),
      ],
    );
  }

  Widget _grammarList(ListDetailGrammarPointsStateLoaded state) {
    if (state.list.isEmpty) {
      return KPEmptyList(
          showTryButton: true,
          onRefresh: () => _addLoadingEvent(reset: true),
          message: "list_details_empty_grammar".tr());
    }
    return ListView.separated(
      key: const PageStorageKey<String>('grammarPointListController'),
      itemCount: state.list.length,
      controller: _scrollController,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, k) {
        GrammarPoint? gp = state.list[k];
        return KPGrammarPointItem(
          index: k,
          grammarPoint: gp,
          listName: widget.listName,
          selectedMode: _selectedMode,
          onShowModal: () => widget.searchBarFn?.unfocus(),
          onTap: () async {
            await Navigator.of(context)
                .pushNamed(KanPracticePages.addGrammarPage,
                    arguments: AddGrammarPointArgs(
                        listName: widget.listName, grammarPoint: gp))
                .then((code) {
              if (code == 0) _addLoadingEvent(reset: true);
            });
          },
          onRemoval: () => _addLoadingEvent(reset: true),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
