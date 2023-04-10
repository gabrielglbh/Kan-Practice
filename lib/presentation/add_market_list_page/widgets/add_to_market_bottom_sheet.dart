import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/application/lists/lists_bloc.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/widgets/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/widgets/kp_empty_list.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
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
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
        context.read<ListsBloc>().add(const ListForTestEventLoading());
        return Wrap(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const KPDragContainer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: KPMargins.margin8,
                    horizontal: KPMargins.margin32),
                child: Text("add_to_market_select_list".tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              BlocBuilder<ListsBloc, ListsState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    error: () {
                      return KPEmptyList(
                        showTryButton: true,
                        onRefresh: () => getIt<ListsBloc>()
                          ..add(const ListForTestEventLoading()),
                        message: "word_lists_load_failed".tr(),
                      );
                    },
                    loading: () => const KPProgressIndicator(),
                    loaded: (lists) => Container(
                        constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height / 3),
                        margin: const EdgeInsets.all(KPMargins.margin8),
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              const Divider(height: KPMargins.margin4),
                          itemCount: lists.length,
                          itemBuilder: (context, index) {
                            String listName = lists[index].name;
                            return ListTile(
                              onTap: () => Navigator.of(context).pop(listName),
                              title: Text(listName),
                            );
                          },
                        )),
                    orElse: () => const SizedBox(),
                  );
                },
              )
            ],
          ),
        ]);
      },
    );
  }
}
