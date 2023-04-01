import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/archive_words/archive_words_bloc.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/injection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/widgets/kp_empty_list.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/widgets/list_details_widgets/kp_word_item.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';

class ArchiveWordListWidget extends StatefulWidget {
  final String query;
  final FocusNode? searchBarFn;
  const ArchiveWordListWidget({
    Key? key,
    required this.query,
    this.searchBarFn,
  }) : super(key: key);

  @override
  State<ArchiveWordListWidget> createState() => _ArchiveWordListWidgetState();
}

class _ArchiveWordListWidgetState extends State<ArchiveWordListWidget>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    getIt<ArchiveWordsBloc>().add(
      const ArchiveWordsEventLoading(reset: true),
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
    return getIt<ArchiveWordsBloc>()
        .add(ArchiveWordsEventLoading(reset: reset));
  }

  _addSearchingEvent(String query, {bool reset = false}) {
    return getIt<ArchiveWordsBloc>()
        .add(ArchiveWordsEventSearching(query, reset: reset));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<ArchiveWordsBloc, ArchiveWordsState>(
      listener: (context, state) async {
        if (state is ArchiveWordsStateFailure) {
          if (state.error.isNotEmpty) {
            Utils.getSnackBar(context, state.error);
          }
        }
      },
      builder: (context, state) {
        if (state is ArchiveWordsStateLoaded) {
          return _body(state);
        } else if (state is ArchiveWordsStateLoading ||
            state is ArchiveWordsStateSearching ||
            state is ArchiveWordsStateIdle) {
          return const KPProgressIndicator();
        } else if (state is ArchiveWordsStateFailure) {
          return KPEmptyList(
              showTryButton: true,
              onRefresh: () => _addLoadingEvent(reset: true),
              message: "list_details_load_failed".tr());
        } else {
          return Container();
        }
      },
    );
  }

  Column _body(ArchiveWordsStateLoaded state) {
    return Column(
      children: [Expanded(child: _wordList(state))],
    );
  }

  Widget _wordList(ArchiveWordsStateLoaded state) {
    if (state.list.isEmpty) {
      return KPEmptyList(
          showTryButton: true,
          onRefresh: () => _addLoadingEvent(reset: true),
          message: "list_details_empty".tr());
    }

    KPWordItem wordElem(int index, bool isBadge) {
      Word? word = state.list[index];
      return KPWordItem(
        aggregateStats: true,
        index: index,
        word: word,
        selectedMode: StudyModes.writing,
        onShowModal: () => widget.searchBarFn?.unfocus(),
        isBadge: isBadge,
      );
    }

    return getIt<PreferencesService>().readData(SharedKeys.showBadgeWords)
        ? GridView.builder(
            key: const PageStorageKey<String>('wordListController'),
            itemCount: state.list.length,
            controller: _scrollController,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5, childAspectRatio: 2),
            itemBuilder: (context, k) => wordElem(k, true),
          )
        : ListView.builder(
            key: const PageStorageKey<String>('wordListController'),
            itemCount: state.list.length,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            controller: _scrollController,
            itemBuilder: (context, k) => wordElem(k, false),
          );
  }

  @override
  bool get wantKeepAlive => true;
}
