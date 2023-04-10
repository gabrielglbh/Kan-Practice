import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/archive_grammar_points/archive_grammar_points_bloc.dart';
import 'package:kanpractice/domain/grammar_point/grammar_point.dart';
import 'package:kanpractice/presentation/add_grammar_point_page/arguments.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/presentation/core/types/grammar_modes.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/widgets/kp_empty_list.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/widgets/list_details_widgets/kp_grammar_point_item.dart';

class ArchiveGrammarListWidget extends StatefulWidget {
  final String query;
  final Function() onScrolledToBottom;
  final Function() removeFocus;
  const ArchiveGrammarListWidget({
    Key? key,
    required this.query,
    required this.onScrolledToBottom,
    required this.removeFocus,
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
    context.read<ArchiveGrammarPointsBloc>().add(
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
      widget.onScrolledToBottom();
    }
  }

  _addLoadingEvent({bool reset = false}) {
    return context
        .read<ArchiveGrammarPointsBloc>()
        .add(ArchiveGrammarPointsEventLoading(reset: reset));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<ArchiveGrammarPointsBloc, ArchiveGrammarPointsState>(
      builder: (context, state) {
        return state.maybeWhen(
          loaded: (grammarPoints) =>
              Expanded(child: _grammarList(grammarPoints)),
          error: () => KPEmptyList(
              showTryButton: true,
              onRefresh: () => _addLoadingEvent(reset: true),
              message: "list_details_load_failed_grammar".tr()),
          orElse: () => const KPProgressIndicator(),
        );
      },
    );
  }

  Widget _grammarList(List<GrammarPoint> grammarPoints) {
    if (grammarPoints.isEmpty) {
      return KPEmptyList(
          showTryButton: true,
          onRefresh: () => _addLoadingEvent(reset: true),
          message: "list_details_empty_grammar".tr());
    }
    return RefreshIndicator(
      onRefresh: () async => _addLoadingEvent(reset: true),
      color: KPColors.secondaryColor,
      child: ListView.separated(
        key: const PageStorageKey<String>('grammarPointListController'),
        itemCount: grammarPoints.length,
        controller: _scrollController,
        padding: const EdgeInsets.only(bottom: KPMargins.margin32),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, k) {
          GrammarPoint? gp = grammarPoints[k];
          return KPGrammarPointItem(
            index: k,
            grammarPoint: gp,
            aggregateStats: true,
            selectedMode: _selectedMode,
            onShowModal: () => widget.removeFocus(),
            onTap: () async {
              await Navigator.of(context)
                  .pushNamed(KanPracticePages.addGrammarPage,
                      arguments: AddGrammarPointArgs(
                          listName: gp.listName, grammarPoint: gp))
                  .then((code) {
                if (code == 0) _addLoadingEvent(reset: true);
              });
            },
            onRemoval: () => _addLoadingEvent(reset: true),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
