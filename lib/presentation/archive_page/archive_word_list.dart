import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/archive_words/archive_words_bloc.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/add_word_page/arguments.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/presentation/core/types/study_modes.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/widgets/kp_empty_list.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/widgets/list_details_widgets/kp_word_item.dart';

class ArchiveWordListWidget extends StatefulWidget {
  final String query;
  final Function() onScrolledToBottom;
  final Function() removeFocus;
  const ArchiveWordListWidget({
    Key? key,
    required this.query,
    required this.onScrolledToBottom,
    required this.removeFocus,
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
    context.read<ArchiveWordsBloc>().add(
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
      widget.onScrolledToBottom();
    }
  }

  _addLoadingEvent({bool reset = false}) {
    return context
        .read<ArchiveWordsBloc>()
        .add(ArchiveWordsEventLoading(reset: reset));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<ArchiveWordsBloc, ArchiveWordsState>(
      builder: (context, state) {
        return state.maybeWhen(
          loaded: (words) => Expanded(child: _wordList(words)),
          error: () => KPEmptyList(
              showTryButton: true,
              onRefresh: () => _addLoadingEvent(reset: true),
              message: "list_details_load_failed".tr()),
          orElse: () => const KPProgressIndicator(),
        );
      },
    );
  }

  Widget _wordList(List<Word> words) {
    if (words.isEmpty) {
      return KPEmptyList(
          showTryButton: true,
          onRefresh: () => _addLoadingEvent(reset: true),
          message: "list_details_empty".tr());
    }

    KPWordItem wordElem(int index, bool isBadge) {
      Word? word = words[index];
      return KPWordItem(
        aggregateStats: true,
        index: index,
        word: word,
        selectedMode: StudyModes.writing,
        onShowModal: () => widget.removeFocus(),
        isBadge: isBadge,
        onTap: () async {
          await Navigator.of(context)
              .pushNamed(KanPracticePages.addWordPage,
                  arguments: AddWordArgs(listName: word.listName, word: word))
              .then((code) {
            if (code == 0) _addLoadingEvent(reset: true);
          });
        },
        onRemoval: () => _addLoadingEvent(reset: true),
      );
    }

    return RefreshIndicator(
      onRefresh: () async => _addLoadingEvent(reset: true),
      color: KPColors.secondaryColor,
      child: getIt<PreferencesService>().readData(SharedKeys.showBadgeWords)
          ? GridView.builder(
              key: const PageStorageKey<String>('wordListController'),
              itemCount: words.length,
              controller: _scrollController,
              padding: const EdgeInsets.only(bottom: KPMargins.margin32),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5, childAspectRatio: 2),
              itemBuilder: (context, k) => wordElem(k, true),
            )
          : ListView.separated(
              key: const PageStorageKey<String>('wordListController'),
              itemCount: words.length,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              controller: _scrollController,
              padding: const EdgeInsets.only(bottom: KPMargins.margin32),
              separatorBuilder: (_, __) =>
                  const Divider(height: KPMargins.margin4),
              itemBuilder: (context, k) => wordElem(k, false),
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
