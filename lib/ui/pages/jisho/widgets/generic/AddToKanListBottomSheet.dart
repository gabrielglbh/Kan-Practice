import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/core/jisho/models/jisho_data.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/ui/pages/kanji_lists/bloc/lists_bloc.dart';
import 'package:kanpractice/ui/widgets/CreateKanListDialog.dart';
import 'package:kanpractice/ui/widgets/DragContainer.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/EmptyList.dart';
import 'package:kanpractice/ui/widgets/ProgressIndicator.dart';
import 'package:easy_localization/easy_localization.dart';

class AddToKanListBottomSheet extends StatefulWidget {
  final String? kanji;
  final KanjiData data;
  const AddToKanListBottomSheet({required this.kanji, required this.data});

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
  String _error = "";

  Future<void> _addWordToKanList(BuildContext context, String listName) async {
    String? wordMeaning = widget.data.resultPhrase[0].senses[0].englishDefinitions[0];
    String? wordReading = widget.data.resultPhrase[0].japanese[0].reading ?? "";
    String? singleKanjiMeaning = widget.data.resultData?.meaning.split(", ")[0];
    String? singleKanjiReading = widget.data.resultData?.onyomi[0];

    String meaning = singleKanjiMeaning == null ? wordMeaning : singleKanjiMeaning;
    String reading = singleKanjiReading == null ? wordReading : singleKanjiReading;

    // TODO: Somehow add the category here
    final code = await KanjiQueries.instance.createKanji(Kanji(
      kanji: widget.kanji ?? "",
      meaning: "${meaning[0].toUpperCase()}${meaning.substring(1).toLowerCase()}",
      pronunciation: reading,
      listName: listName,
      dateAdded: GeneralUtils.getCurrentMilliseconds(),
      dateLastShown: GeneralUtils.getCurrentMilliseconds()
    ));
    if (code == 0) {
      Navigator.of(context).pop();
      GeneralUtils.getSnackBar(context, "add_kanji_createKanji_successful".tr());
    }
    else if (code == -1) setState(() => _error = "add_kanji_createKanji_failed_insertion".tr());
    else setState(() => _error = "add_kanji_createKanji_failed".tr());
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
                DragContainer(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Margins.margin8, horizontal: Margins.margin32),
                  child: Text("dict_jisho_add_kanji_bottom_sheet_title".tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: FontSizes.fontSize18)),
                ),
                Visibility(
                  visible: _error.isNotEmpty,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: Margins.margin8, horizontal: Margins.margin32),
                    child: Text(_error, textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold,
                          color: CustomColors.secondaryColor, fontSize: FontSizes.fontSize16)
                    ),
                  ),
                ),
                BlocProvider<KanjiListBloc>(
                  create: (_) => _bloc..add(KanjiListForTestEventLoading()),
                  child: BlocBuilder<KanjiListBloc, KanjiListState>(
                    builder: (context, state) {
                      if (state is KanjiListStateFailure)
                        return EmptyList(
                          showTryButton: true,
                          onRefresh: () => _bloc..add(KanjiListForTestEventLoading()),
                          message: "study_bottom_sheet_load_failed".tr()
                        );
                      else if (state is KanjiListStateLoading)
                        return CustomProgressIndicator();
                      else if (state is KanjiListStateLoaded) {
                        return Container(
                          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 2.5),
                          margin: EdgeInsets.all(Margins.margin8),
                          child: _listSelection(state)
                        );
                      } else return Container();
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
        ListTile(
          onTap: () => CreateKanListDialog.showCreateKanListDialog(context, onSubmit: (String name) {
            _bloc..add(KanjiListEventCreate(name,
                filter: KanListTableFields.lastUpdatedField,
                order: false, useLazyLoading: false
            ));
          }),
          title: Text("dict_jisho_create_kanji_list".tr()),
          leading: Icon(Icons.add),
        ),
        Divider(),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemCount: state.lists.length,
            itemBuilder: (context, index) {
              String listName = state.lists[index].name;
              return ListTile(
                onTap: () async => await _addWordToKanList(context, listName),
                title: Text(listName),
              );
            },
          ),
        )
      ],
    );
  }
}