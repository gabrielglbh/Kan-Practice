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
import 'package:kanpractice/presentation/core/types/word_categories_filters.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/widgets/kp_empty_list.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/widgets/list_details_widgets/kp_word_item.dart';

class ArchiveWordListWidget extends StatefulWidget {
  final String query;
  final Function() onScrolledToBottom;
  final Function() removeFocus;
  const ArchiveWordListWidget({
    super.key,
    required this.query,
    required this.onScrolledToBottom,
    required this.removeFocus,
  });

  @override
  State<ArchiveWordListWidget> createState() => _ArchiveWordListWidgetState();
}

class _ArchiveWordListWidgetState extends State<ArchiveWordListWidget>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  WordCategoryFilter _currentAppliedFilter = WordCategoryFilter.all;
  bool _currentAppliedOrder = true;

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    _addLoadingEvent(reset: true);
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
    return context.read<ArchiveWordsBloc>().add(ArchiveWordsEventLoading(
        filter: _currentAppliedFilter,
        order: _currentAppliedOrder,
        reset: reset));
  }

  _resetScroll() {
    /// Scroll to the top
    if (_scrollController.hasClients) {
      _scrollController.animateTo(0,
          duration: const Duration(milliseconds: 400), curve: Curves.easeOut);
    }
  }

  _onFilterSelected(int index) {
    _resetScroll();
    widget.removeFocus();

    /// If the user taps on the same filter twice, just change back and forth the
    /// order value.
    /// Else, means the user has changed the filter, therefore default the order to DESC
    if (_currentAppliedFilter.index == index) {
      setState(() => _currentAppliedOrder = !_currentAppliedOrder);
    } else {
      setState(() => _currentAppliedOrder = true);
    }

    /// Change the current applied filter based on the index selected on the ChoiceChip
    /// and change the value on _filterValues map to reflect the change on the UI
    _currentAppliedFilter = WordCategoryFilter.values[index];

    /// Adds the loading event to the bloc builder to load the new specified list
    _addLoadingEvent(reset: true);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        _filterChips(),
        BlocBuilder<ArchiveWordsBloc, ArchiveWordsState>(
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
        ),
      ],
    );
  }

  SizedBox _filterChips() {
    Icon icon = Icon(
        _currentAppliedOrder
            ? Icons.arrow_downward_rounded
            : Icons.arrow_upward_rounded,
        color: KPColors.getAlterAccent(context));

    return SizedBox(
        height: KPSizes.defaultSizeFiltersList,
        child: ListView.builder(
            itemCount: WordCategoryFilter.values.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: KPMargins.margin2),
                child: ChoiceChip(
                  showCheckmark: false,
                  label: Text(WordCategoryFilter.values[index].category),
                  avatar: _currentAppliedFilter.index != index ? null : icon,
                  pressElevation: KPMargins.margin4,
                  padding:
                      const EdgeInsets.symmetric(horizontal: KPMargins.margin8),
                  onSelected: (bool selected) => _onFilterSelected(index),
                  selected: _currentAppliedFilter.index == index,
                ),
              );
            }));
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
