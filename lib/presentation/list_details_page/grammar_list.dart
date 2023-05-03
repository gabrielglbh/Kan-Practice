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
import 'package:kanpractice/presentation/core/widgets/kp_button.dart';
import 'package:kanpractice/presentation/core/widgets/kp_empty_list.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/widgets/list_details_widgets/kp_grammar_point_item.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/grammar_modes/utils/grammar_mode_arguments.dart';
import 'package:kanpractice/presentation/list_details_page/widgets/practice_grammar_bottom_sheet.dart';

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
    context.read<ListDetailsGrammarPointsBloc>().add(
          ListDetailsGrammarPointsEventLoading(widget.listName, reset: true),
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
    return context.read<ListDetailsGrammarPointsBloc>().add(
        ListDetailsGrammarPointsEventLoading(widget.listName, reset: reset));
  }

  _addSearchingEvent(String query, {bool reset = false}) {
    return context.read<ListDetailsGrammarPointsBloc>().add(
        ListDetailsGrammarPointsEventSearching(query, widget.listName,
            reset: reset));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<ListDetailsGrammarPointsBloc,
        ListDetailsGrammarPointsState>(
      listener: (context, state) async {
        state.mapOrNull(
          practiceLoaded: (s) async {
            await Navigator.of(context)
                .pushNamed(s.mode.page,
                    arguments: GrammarModeArguments(
                        studyList: s.list,
                        isTest: false,
                        mode: s.mode,
                        testMode: Tests.blitz,
                        studyModeHeaderDisplayName: widget.listName))
                .then(
                  (value) => _addLoadingEvent(reset: true),
                );
          },
          error: (error) {
            if (error.message.isNotEmpty) {
              Utils.getSnackBar(context, error.message);
            }
          },
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          loaded: (grammar, _) => Column(
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
                  ? Expanded(child: _grammarList(grammar))
                  : Expanded(
                      child: GestureDetector(
                        onHorizontalDragEnd: (details) {
                          double? pv = details.primaryVelocity;
                          if (pv != null) _updateSelectedModePageView(pv);
                        },
                        child: _grammarList(grammar),
                      ),
                    ),
              if (grammar.isNotEmpty)
                KPButton(
                    title1: "list_details_practice_button_label_ext".tr(),
                    title2: "list_details_practice_button_label".tr(),
                    onTap: () async {
                      if (_aggrStats) {
                        return await PracticeGrammarBottomSheet.show(
                                context, widget.listName, grammar)
                            .then(
                          (value) => _addLoadingEvent(reset: true),
                        );
                      }
                      context.read<ListDetailsGrammarPointsBloc>().add(
                          ListDetailsGrammarPointsEventLoadUpPractice(
                              widget.listName, _selectedMode));
                    }),
            ],
          ),
          error: (_) => KPEmptyList(
              showTryButton: true,
              onRefresh: () => _addLoadingEvent(reset: true),
              message: "list_details_load_failed_grammar".tr()),
          orElse: () => const KPProgressIndicator(),
        );
      },
    );
  }

  Widget _grammarList(List<GrammarPoint> grammar) {
    if (grammar.isEmpty) {
      return KPEmptyList(
          showTryButton: true,
          onRefresh: () => _addLoadingEvent(reset: true),
          message: "list_details_empty_grammar".tr());
    }
    return ListView.separated(
      key: const PageStorageKey<String>('grammarPointListController'),
      itemCount: grammar.length,
      controller: _scrollController,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, k) {
        GrammarPoint? gp = grammar[k];
        return KPGrammarPointItem(
          index: k,
          grammarPoint: gp,
          aggregateStats: _aggrStats,
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
