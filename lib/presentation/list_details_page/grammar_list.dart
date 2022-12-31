import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/list_details_grammar_points/list_details_grammar_points_bloc.dart';
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
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/grammar_modes/utils/grammar_mode_arguments.dart';
import 'package:kanpractice/presentation/list_details_page/widgets/grammar_point_item.dart';

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

  final _selectedMode = GrammarModes.definition;

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    getIt<ListDetailGrammarPointsBloc>().add(
      ListDetailGrammarPointsEventLoading(widget.listName, reset: true),
    );
    super.initState();
  }

  @override
  void dispose() {
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
        Expanded(child: _grammarList(state)),
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
        return GrammarPointItem(
          index: k,
          grammarPoint: gp,
          list: widget.list,
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
