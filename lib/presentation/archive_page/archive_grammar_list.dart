import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/archive_grammar_points/archive_grammar_points_bloc.dart';
import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/types/grammar_modes.dart';
import 'package:kanpractice/presentation/core/ui/kp_empty_list.dart';
import 'package:kanpractice/presentation/core/ui/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/ui/list_details_widgets/kp_grammar_point_item.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';

class ArchiveGrammarListWidget extends StatefulWidget {
  final String query;
  final FocusNode? searchBarFn;
  const ArchiveGrammarListWidget({
    Key? key,
    required this.query,
    this.searchBarFn,
  }) : super(key: key);

  @override
  State<ArchiveGrammarListWidget> createState() =>
      _ArchiveGrammarListWidgetState();
}

class _ArchiveGrammarListWidgetState extends State<ArchiveGrammarListWidget>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  final _selectedMode = GrammarModes.definition;

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    getIt<ArchiveGrammarPointsBloc>().add(
      const ArchiveGrammarPointsEventLoading(reset: true),
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
    return getIt<ArchiveGrammarPointsBloc>()
        .add(ArchiveGrammarPointsEventLoading(reset: reset));
  }

  _addSearchingEvent(String query, {bool reset = false}) {
    return getIt<ArchiveGrammarPointsBloc>()
        .add(ArchiveGrammarPointsEventSearching(query, reset: reset));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<ArchiveGrammarPointsBloc, ArchiveGrammarPointsState>(
      listener: (context, state) async {
        if (state is ArchiveGrammarPointsStateFailure) {
          if (state.error.isNotEmpty) {
            Utils.getSnackBar(context, state.error);
          }
        }
      },
      builder: (context, state) {
        if (state is ArchiveGrammarPointsStateLoaded) {
          return _body(state);
        } else if (state is ArchiveGrammarPointsStateLoading ||
            state is ArchiveGrammarPointsStateSearching ||
            state is ArchiveGrammarPointsStateIdle) {
          return const KPProgressIndicator();
        } else if (state is ArchiveGrammarPointsStateFailure) {
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

  Column _body(ArchiveGrammarPointsStateLoaded state) {
    return Column(
      children: [
        Expanded(child: _grammarList(state)),
      ],
    );
  }

  Widget _grammarList(ArchiveGrammarPointsStateLoaded state) {
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
          selectedMode: _selectedMode,
          onShowModal: () => widget.searchBarFn?.unfocus(),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
