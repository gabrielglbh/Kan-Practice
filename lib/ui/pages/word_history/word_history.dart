import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/database/models/word_history.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/ui/pages/jisho/arguments.dart';
import 'package:kanpractice/ui/pages/word_history/bloc/word_history_bloc.dart';
import 'package:kanpractice/ui/widgets/kp_alert_dialog.dart';
import 'package:kanpractice/ui/widgets/kp_empty_list.dart';
import 'package:kanpractice/ui/widgets/kp_progress_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/ui/widgets/kp_scaffold.dart';

class WordHistoryPage extends StatefulWidget {
  const WordHistoryPage({Key? key}) : super(key: key);

  @override
  State<WordHistoryPage> createState() => _WordHistoryPageState();
}

class _WordHistoryPageState extends State<WordHistoryPage> {
  final ScrollController _scrollController = ScrollController();
  int _loadingTimes = 0;

  _showRemoveHistorysDialog(BuildContext bloc) {
    showDialog(
        context: bloc,
        builder: (context) => KPDialog(
              title: Text("word_history_showRemoveHistorysDialog_title".tr()),
              content: Text(
                  "word_history_showRemoveHistorysDialog_content".tr(),
                  style: Theme.of(context).textTheme.bodyText1),
              positiveButtonText:
                  "word_history_showRemoveHistorysDialog_positive".tr(),
              onPositive: () =>
                  bloc.read<WordHistoryBloc>().add(WordHistoryEventRemoving()),
            ));
  }

  _addLoadingEvent({int offset = 0}) =>
      BlocProvider.of<WordHistoryBloc>(context)
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
    /// BlocProvider is defined at route level in order for the whole context of the
    /// class to be accessible to the provider
    return KPScaffold(
      appBarTitle: "word_history_title".tr(),
      appBarActions: [
        BlocBuilder<WordHistoryBloc, WordHistoryState>(
          builder: (context, state) => IconButton(
            icon: const Icon(Icons.clear_all_rounded),
            onPressed: () => _showRemoveHistorysDialog(context),
          ),
        )
      ],
      child: BlocBuilder<WordHistoryBloc, WordHistoryState>(
          builder: (context, state) => _body(state)),
    );
  }

  _body(WordHistoryState state) {
    if (state is WordHistoryStateFailure) {
      return KPEmptyList(
          showTryButton: true,
          onRefresh: () => _addLoadingEvent(),
          message: "word_history_load_failed".tr());
    } else if (state is WordHistoryStateLoading) {
      return const KPProgressIndicator();
    } else if (state is WordHistoryStateLoaded) {
      if (state.list.isEmpty) {
        return KPEmptyList(
            onRefresh: () => _addLoadingEvent(),
            message: "word_history_empty".tr());
      }
      return _testList(state);
    } else {
      return Container();
    }
  }

  _testList(WordHistoryStateLoaded state) {
    return ListView.separated(
        key: const PageStorageKey<String>('wordHistoryController'),
        controller: _scrollController,
        separatorBuilder: (_, __) => const Divider(),
        itemCount: state.list.length,
        itemBuilder: (context, k) {
          WordHistory wordHistory = state.list[k];
          return ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(KanPracticePages.jishoPage,
                  arguments: JishoArguments(
                      kanji: wordHistory.word, fromDictionary: true));
            },
            title: Text(wordHistory.word,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.copyWith(fontWeight: FontWeight.normal),
                overflow: TextOverflow.ellipsis),
            subtitle: Text(GeneralUtils.parseDateMilliseconds(
                context, wordHistory.searchedOn)),
          );
        });
  }
}
