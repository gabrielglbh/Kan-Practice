import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/word_history/word_history_bloc.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/word_history/word_history.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/widgets/kp_alert_dialog.dart';
import 'package:kanpractice/presentation/core/widgets/kp_empty_list.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/widgets/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/dictionary_details_page/arguments.dart';

class WordHistoryPage extends StatefulWidget {
  const WordHistoryPage({Key? key}) : super(key: key);

  @override
  State<WordHistoryPage> createState() => _WordHistoryPageState();
}

class _WordHistoryPageState extends State<WordHistoryPage> {
  final ScrollController _scrollController = ScrollController();
  int _loadingTimes = 0;

  _showRemoveHistorysDialog() {
    showDialog(
        context: context,
        builder: (context) => KPDialog(
              title: Text("word_history_showRemoveHistorysDialog_title".tr()),
              content: Text(
                  "word_history_showRemoveHistorysDialog_content".tr(),
                  style: Theme.of(context).textTheme.bodyLarge),
              positiveButtonText:
                  "word_history_showRemoveHistorysDialog_positive".tr(),
              onPositive: () => context
                  .read<WordHistoryBloc>()
                  .add(WordHistoryEventRemoving()),
            ));
  }

  _addLoadingEvent({int offset = 0}) => context
      .read<WordHistoryBloc>()
      .add(WordHistoryEventLoading(offset: offset));

  _scrollListener() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      _loadingTimes += 1;
      _addLoadingEvent(offset: _loadingTimes);
    }
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<WordHistoryBloc>()..add(const WordHistoryEventLoading()),
      child: KPScaffold(
        appBarTitle: "word_history_title".tr(),
        appBarActions: [
          IconButton(
            icon: const Icon(Icons.clear_all_rounded),
            onPressed: () => _showRemoveHistorysDialog(),
          ),
        ],
        child: BlocBuilder<WordHistoryBloc, WordHistoryState>(
          builder: (context, state) {
            return state.maybeWhen(
              error: () => KPEmptyList(
                  showTryButton: true,
                  onRefresh: () => _addLoadingEvent(),
                  message: "word_history_load_failed".tr()),
              loading: () => const KPProgressIndicator(),
              loaded: (list) {
                if (list.isEmpty) {
                  return KPEmptyList(
                      onRefresh: () => _addLoadingEvent(),
                      message: "word_history_empty".tr());
                }
                return ListView.separated(
                    key: const PageStorageKey<String>('wordHistoryController'),
                    controller: _scrollController,
                    separatorBuilder: (_, __) =>
                        const Divider(height: KPMargins.margin4),
                    itemCount: list.length,
                    itemBuilder: (context, k) {
                      WordHistory wordHistory = list[k];
                      final date = Utils.parseDateMilliseconds(
                          context, wordHistory.searchedOn);
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              KanPracticePages.jishoPage,
                              arguments: DictionaryDetailsArguments(
                                  word: wordHistory.word,
                                  fromDictionary: true));
                        },
                        title: Text(wordHistory.word,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(fontWeight: FontWeight.normal),
                            overflow: TextOverflow.ellipsis),
                        trailing: Text("${"searched_label".tr()} $date",
                            style: Theme.of(context).textTheme.bodySmall),
                      );
                    });
              },
              orElse: () => const SizedBox(),
            );
          },
        ),
      ),
    );
  }
}
