import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/jisho/models/jisho_data.dart';
import 'package:kanpractice/core/types/kanlist_filters.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/core/types/kanji_categories.dart';
import 'package:kanpractice/ui/pages/kanji_lists/bloc/lists_bloc.dart';
import 'package:kanpractice/ui/widgets/kp_create_kanlist_dialog.dart';
import 'package:kanpractice/ui/widgets/kp_drag_container.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/widgets/kp_empty_list.dart';
import 'package:kanpractice/ui/widgets/kp_kanji_category_list.dart';
import 'package:kanpractice/ui/widgets/kp_progress_indicator.dart';
import 'package:easy_localization/easy_localization.dart';

class AddToKanListBottomSheet extends StatefulWidget {
  final String? kanji;
  final KanjiData data;
  const AddToKanListBottomSheet({
    Key? key,
    required this.kanji,
    required this.data
  }) : super(key: key);

  /// Creates and calls the [BottomSheet] with the content for a regular test
  static Future<String?> callAddToKanListBottomSheet(BuildContext context,
      String? kanji, KanjiData data) async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddToKanListBottomSheet(kanji: kanji, data: data)
    );
  }

  @override
  _AddToKanListBottomSheetState createState() => _AddToKanListBottomSheetState();
}

class _AddToKanListBottomSheetState extends State<AddToKanListBottomSheet> {
  final KanjiListBloc _bloc = KanjiListBloc();
  KanjiCategory _category = KanjiCategory.noun;
  String _error = "";

  Future<void> _addWordToKanList(BuildContext context, KanjiCategory category, String listName) async {
    String? wordMeaning = widget.data.resultPhrase[0].senses[0].englishDefinitions[0];
    String? wordReading = widget.data.resultPhrase[0].japanese[0].reading ?? "";
    String? singleKanjiMeaning = widget.data.resultData?.meaning.split(", ")[0];
    String? singleKanjiReading = widget.data.resultData?.onyomi[0];

    String meaning = singleKanjiMeaning ?? wordMeaning;
    String reading = singleKanjiReading ?? wordReading;

    final code = await KanjiQueries.instance.createKanji(Kanji(
      kanji: widget.kanji ?? "",
      meaning: "${meaning[0].toUpperCase()}${meaning.substring(1).toLowerCase()}",
      pronunciation: reading,
      category: category.index,
      listName: listName,
      dateAdded: GeneralUtils.getCurrentMilliseconds(),
      dateLastShown: GeneralUtils.getCurrentMilliseconds()
    ));
    if (code == 0) {
      Navigator.of(context).pop();
      GeneralUtils.getSnackBar(context, "add_kanji_createKanji_successful".tr());
    }
    else if (code == -1) {
      setState(() => _error = "add_kanji_createKanji_failed_insertion".tr());
    } else {
      setState(() => _error = "add_kanji_createKanji_failed".tr());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
        return Wrap(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const KPDragContainer(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: Margins.margin8, horizontal: Margins.margin32),
                  child: Text("dict_jisho_add_kanji_bottom_sheet_title".tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6),
                ),
                Visibility(
                  visible: _error.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: Margins.margin8, horizontal: Margins.margin32),
                    child: Text(_error, textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.button?.copyWith(color: CustomColors.secondaryColor)
                    ),
                  ),
                ),
                BlocProvider<KanjiListBloc>(
                  create: (_) => _bloc..add(const KanjiListForTestEventLoading()),
                  child: BlocBuilder<KanjiListBloc, KanjiListState>(
                    builder: (context, state) {
                      if (state is KanjiListStateFailure) {
                        return KPEmptyList(
                          showTryButton: true,
                          onRefresh: () => _bloc..add(const KanjiListForTestEventLoading()),
                          message: "study_bottom_sheet_load_failed".tr()
                        );
                      } else if (state is KanjiListStateLoading) {
                        return const KPProgressIndicator();
                      } else if (state is KanjiListStateLoaded) {
                        return Container(
                          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height /  2),
                          margin: const EdgeInsets.all(Margins.margin8),
                          child: _listSelection(state)
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                )
              ],
            ),
          ]
        );
      },
    );
  }

  Widget _listSelection(KanjiListStateLoaded state) {
    return Column(
      children: [
        Expanded(
          child: KPKanjiCategoryList(
            hasScrollablePhysics: true,
            selected: (index) => _category.index == index,
            onSelected: (index) {
              setState(() => _category = KanjiCategory.values[index]);
            },
          ),
        ),
        ListTile(
          onTap: () => KPCreateKanListDialog.show(context, onSubmit: (String name) {
            _bloc.add(KanjiListEventCreate(name,
                filter: KanListFilters.all,
                order: false, useLazyLoading: false
            ));
          }),
          title: Text("dict_jisho_create_kanji_list".tr()),
          leading: const Icon(Icons.add),
        ),
        const Divider(),
        Expanded(
          flex: 2,
          child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: state.lists.length,
            itemBuilder: (context, index) {
              String listName = state.lists[index].name;
              return ListTile(
                onTap: () async => await _addWordToKanList(context, _category, listName),
                title: Text(listName),
              );
            },
          ),
        )
      ],
    );
  }
}