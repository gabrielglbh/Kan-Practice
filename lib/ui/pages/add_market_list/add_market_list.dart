import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/utils/general_utils.dart';
import 'package:kanpractice/ui/pages/add_market_list/bloc/add_to_market_bloc.dart';
import 'package:kanpractice/ui/pages/add_market_list/widgets/add_to_market_bottom_sheet.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/ui/widgets/kp_scaffold.dart';
import 'package:kanpractice/ui/widgets/kp_text_form.dart';

class AddMarketListPage extends StatefulWidget {
  const AddMarketListPage({Key? key}) : super(key: key);

  @override
  State<AddMarketListPage> createState() => _AddMarketListPageState();
}

class _AddMarketListPageState extends State<AddMarketListPage> {
  final _bloc = AddToMarketBloc();
  late TextEditingController _tc;
  late FocusNode _fn;
  late TextEditingController _tcUser;
  late FocusNode _fnUser;
  String _listSelection = "add_to_market_select_list".tr();

  @override
  void initState() {
    _tc = TextEditingController();
    _fn = FocusNode();
    _tcUser = TextEditingController();
    _fnUser = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _tc.dispose();
    _fn.dispose();
    _tcUser.dispose();
    _fnUser.dispose();
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _bloc..add(AddToMarketEventIdle()),
      child: KPScaffold(
        appBarTitle: "add_to_market_title".tr(),
        appBarActions: [
          BlocBuilder<AddToMarketBloc, AddToMarketState>(
            builder: (context, state) {
              if (state is AddToMarketStateLoading || state is AddToMarketStateSuccess) {
                return Container();
              } else {
                return IconButton(
                  onPressed: () {
                    _bloc.add(AddToMarketEventOnUpload(_listSelection, _tc.text, _tcUser.text));
                  },
                  icon: const Icon(Icons.check)
                );
              }
            },
          )
        ],
        child: SingleChildScrollView(
          child: BlocListener<AddToMarketBloc, AddToMarketState>(
            listener: (context, state) {
              if (state is AddToMarketStateFailure) {
                GeneralUtils.getSnackBar(context, state.message);
              }
              if (state is AddToMarketStateGetUser) {
                _tcUser.text = state.name;
              }
            },
            child: BlocBuilder<AddToMarketBloc, AddToMarketState>(
              builder: (context, state) {
                if (state is AddToMarketStateInitial ||
                    state is AddToMarketStateFailure ||
                    state is AddToMarketStateGetUser) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: Margins.margin16),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: Margins.margin8),
                              child: Icon(Icons.info_outline_rounded),
                            ),
                            Expanded(child: Text("add_to_market_needs_registration".tr(),
                                style: Theme.of(context).textTheme.bodyText1))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: Margins.margin16),
                        child: Card(
                          child: ListTile(
                            title: Text(_listSelection),
                            onTap: () async {
                              String? list = await AddToMarketBottomSheet.callAddToMarketBottomSheet(context);
                              if (list != null && list.isNotEmpty) setState(() => _listSelection = list);
                            },
                          ),
                        ),
                      ),
                      KPTextForm(
                          header: "add_to_market_username_label".tr(),
                          hint: "add_to_market_username_hint".tr(),
                          controller: _tcUser,
                          focusNode: _fnUser,
                          maxLines: 1,
                          maxLength: 32,
                          onEditingComplete: () => _fn.requestFocus()
                      ),
                      KPTextForm(
                          header: "add_to_market_description_label".tr(),
                          hint: "add_to_market_description_hint".tr(),
                          controller: _tc,
                          focusNode: _fn,
                          action: TextInputAction.done,
                          maxLines: 5,
                          maxLength: 140,
                          onEditingComplete: () => _fn.unfocus()
                      )
                    ],
                  );
                } else if (state is AddToMarketStateLoading) {
                  return const Expanded(child: KPProgressIndicator());
                } else {
                  return Center(
                      child: Column(
                        children: [
                          Icon(Icons.check_circle_rounded, color: CustomColors.getSecondaryColor(context),
                              size: CustomSizes.maxHeightValidationCircle),
                          Padding(
                            padding: const EdgeInsets.all(Margins.margin16),
                            child: Text("add_to_market_successfully_created".tr(), textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText1),
                          ),
                          SizedBox(
                            height: CustomSizes.appBarHeight,
                            child: Padding(
                              padding: const EdgeInsets.all(Margins.margin16),
                              child: ElevatedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text("add_to_market_go_back_to_market_button_label".tr(),
                                    style: Theme.of(context).textTheme.bodyText1),
                              ),
                            ),
                          ),
                        ],
                      )
                  );
                }
              },
            ),
          ),
        )
      ),
    );
  }
}
