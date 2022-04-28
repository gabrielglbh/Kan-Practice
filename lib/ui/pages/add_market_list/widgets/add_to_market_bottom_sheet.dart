import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/ui/pages/kanji_lists/bloc/lists_bloc.dart';
import 'package:kanpractice/ui/widgets/kp_drag_container.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/kp_empty_list.dart';
import 'package:kanpractice/ui/widgets/kp_progress_indicator.dart';
import 'package:easy_localization/easy_localization.dart';

class AddToMarketBottomSheet extends StatefulWidget {
  const AddToMarketBottomSheet({Key? key }) : super(key: key);

  static Future<String?> callAddToMarketBottomSheet(BuildContext context) async {
    String? listName;
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const AddToMarketBottomSheet()
    ).then((value) {
      listName = value;
    });
    return listName;
  }

  @override
  _AddToMarketBottomSheetState createState() => _AddToMarketBottomSheetState();
}

class _AddToMarketBottomSheetState extends State<AddToMarketBottomSheet> {
  final KanjiListBloc _bloc = KanjiListBloc();

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
                  child: Text("add_to_market_select_list".tr(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: FontSizes.fontSize18)),
                ),
                BlocProvider<KanjiListBloc>(
                  create: (_) => _bloc..add(const KanjiListForTestEventLoading()),
                  child: BlocBuilder<KanjiListBloc, KanjiListState>(
                    builder: (context, state) {
                      if (state is KanjiListStateFailure) {
                        return KPEmptyList(
                            showTryButton: true,
                            onRefresh: () => _bloc..add(const KanjiListForTestEventLoading()),
                            message: "kanji_lists_load_failed".tr()
                        );
                      } else if (state is KanjiListStateLoading) {
                        return const KPProgressIndicator();
                      } else if (state is KanjiListStateLoaded) {
                        return Container(
                          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 3),
                          margin: const EdgeInsets.all(Margins.margin8),
                          child: ListView.separated(
                            separatorBuilder: (context, index) => const Divider(),
                            itemCount: state.lists.length,
                            itemBuilder: (context, index) {
                              String listName = state.lists[index].name;
                              return ListTile(
                                onTap: () => Navigator.of(context).pop(listName),
                                title: Text(listName),
                              );
                            },
                          )
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
}