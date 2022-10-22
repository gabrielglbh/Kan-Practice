import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/application/list/lists_bloc.dart';
import 'package:kanpractice/presentation/core/ui/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/ui/kp_empty_list.dart';
import 'package:kanpractice/presentation/core/ui/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class AddToMarketBottomSheet extends StatefulWidget {
  const AddToMarketBottomSheet({Key? key}) : super(key: key);

  static Future<String?> callAddToMarketBottomSheet(
      BuildContext context) async {
    String? listName;
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const AddToMarketBottomSheet()).then((value) {
      listName = value;
    });
    return listName;
  }

  @override
  State<AddToMarketBottomSheet> createState() => _AddToMarketBottomSheetState();
}

class _AddToMarketBottomSheetState extends State<AddToMarketBottomSheet> {
  final ListBloc _bloc = ListBloc();

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
        return Wrap(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const KPDragContainer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Margins.margin8, horizontal: Margins.margin32),
                child: Text("add_to_market_select_list".tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6),
              ),
              BlocProvider<ListBloc>(
                create: (_) => _bloc..add(const ListForTestEventLoading()),
                child: BlocBuilder<ListBloc, ListState>(
                  builder: (context, state) {
                    if (state is ListStateFailure) {
                      return KPEmptyList(
                          showTryButton: true,
                          onRefresh: () =>
                              _bloc..add(const ListForTestEventLoading()),
                          message: "kanji_lists_load_failed".tr());
                    } else if (state is ListStateLoading) {
                      return const KPProgressIndicator();
                    } else if (state is ListStateLoaded) {
                      return Container(
                          constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height / 3),
                          margin: const EdgeInsets.all(Margins.margin8),
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemCount: state.lists.length,
                            itemBuilder: (context, index) {
                              String listName = state.lists[index].name;
                              return ListTile(
                                onTap: () =>
                                    Navigator.of(context).pop(listName),
                                title: Text(listName),
                              );
                            },
                          ));
                    } else {
                      return Container();
                    }
                  },
                ),
              )
            ],
          ),
        ]);
      },
    );
  }
}
