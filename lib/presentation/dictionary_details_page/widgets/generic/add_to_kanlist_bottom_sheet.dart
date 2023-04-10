import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/add_word/add_word_bloc.dart';
import 'package:kanpractice/application/list/lists_bloc.dart';
import 'package:kanpractice/domain/dictionary_details/word_data.dart';
import 'package:kanpractice/presentation/core/types/wordlist_filters.dart';
import 'package:kanpractice/presentation/core/types/word_categories.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/word/word.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/widgets/kp_create_kanlist_dialog.dart';
import 'package:kanpractice/presentation/core/widgets/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/widgets/kp_empty_list.dart';
import 'package:kanpractice/presentation/core/widgets/kp_word_category_list.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';

class AddToKanListBottomSheet extends StatefulWidget {
  final String? word;
  final WordData data;
  const AddToKanListBottomSheet(
      {Key? key, required this.word, required this.data})
      : super(key: key);

  /// Creates and calls the [BottomSheet] with the content for a regular test
  static Future<String?> show(
      BuildContext context, String? word, WordData data) async {
    return await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => AddToKanListBottomSheet(word: word, data: data));
  }

  @override
  State<AddToKanListBottomSheet> createState() =>
      _AddToKanListBottomSheetState();
}

class _AddToKanListBottomSheetState extends State<AddToKanListBottomSheet> {
  WordCategory _category = WordCategory.noun;
  String _error = "";

  Future<void> _addWordToKanList(
      BuildContext context, WordCategory category, String listName) async {
    String? wordMeaning =
        widget.data.resultPhrase[0].senses[0].englishDefinitions[0];
    String? wordReading = widget.data.resultPhrase[0].japanese[0].reading ?? "";
    String? singleWordMeaning = widget.data.resultData?.meaning.split(", ")[0];
    String? singleWordReading = widget.data.resultData?.onyomi[0];

    String meaning = singleWordMeaning ?? wordMeaning;
    String reading = singleWordReading ?? wordReading;

    getIt<AddWordBloc>().add(
      AddWordEventCreate(
        word: Word(
          word: widget.word ?? "",
          meaning:
              "${meaning[0].toUpperCase()}${meaning.substring(1).toLowerCase()}",
          pronunciation: reading,
          category: category.index,
          listName: listName,
          dateAdded: Utils.getCurrentMilliseconds(),
          dateLastShown: Utils.getCurrentMilliseconds(),
        ),
        exitMode: false,
      ),
    );
  }

  @override
  void initState() {
    getIt<ListsBloc>().add(const ListForTestEventLoading());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
        return BlocListener<AddWordBloc, AddWordState>(
          listener: (context, state) {
            if (state is AddWordStateDoneCreating) {
              Navigator.of(context).pop();
              Utils.getSnackBar(context, "add_word_createWord_successful".tr());
            } else if (state is AddWordStateFailure) {
              setState(() => _error = state.message);
            }
          },
          child: Wrap(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const KPDragContainer(),
                Row(
                  children: [
                    const SizedBox(width: KPMargins.margin48),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: KPMargins.margin8,
                            horizontal: KPMargins.margin32),
                        child: Text(
                            "dict_jisho_add_word_bottom_sheet_title".tr(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        KPCreateKanListDialog.show(context,
                            onSubmit: (String name) {
                          getIt<ListsBloc>().add(ListEventCreate(name,
                              filter: WordListFilters.all,
                              order: false,
                              useLazyLoading: false));
                        });
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                Visibility(
                  visible: _error.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: KPMargins.margin8,
                        horizontal: KPMargins.margin32),
                    child: Text(_error,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: KPColors.secondaryColor)),
                  ),
                ),
                BlocBuilder<ListsBloc, ListsState>(
                  builder: (context, state) {
                    if (state is ListStateFailure) {
                      return KPEmptyList(
                          showTryButton: true,
                          onRefresh: () => getIt<ListsBloc>()
                            ..add(const ListForTestEventLoading()),
                          message: "study_bottom_sheet_load_failed".tr());
                    } else if (state is ListStateLoading) {
                      return const KPProgressIndicator();
                    } else if (state is ListStateLoaded) {
                      return Container(
                          constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height / 2),
                          margin: const EdgeInsets.all(KPMargins.margin8),
                          child: _listSelection(state));
                    } else {
                      return Container();
                    }
                  },
                )
              ],
            ),
          ]),
        );
      },
    );
  }

  Widget _listSelection(ListStateLoaded state) {
    return Column(
      children: [
        Expanded(
          child: KPWordCategoryList(
            hasScrollablePhysics: true,
            selected: (index) => _category.index == index,
            onSelected: (index) {
              setState(() => _category = WordCategory.values[index]);
            },
          ),
        ),
        const Divider(),
        Expanded(
          flex: 2,
          child: ListView.separated(
            separatorBuilder: (context, index) =>
                const Divider(height: KPMargins.margin4),
            itemCount: state.lists.length,
            itemBuilder: (context, index) {
              String listName = state.lists[index].name;
              return ListTile(
                onTap: () async =>
                    await _addWordToKanList(context, _category, listName),
                title: Text(listName),
              );
            },
          ),
        )
      ],
    );
  }
}
