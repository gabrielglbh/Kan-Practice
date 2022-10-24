import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/add_market_list/add_to_market_bloc.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/types/market_list_type.dart';
import 'package:kanpractice/presentation/add_market_list_page/widgets/add_to_market_bottom_sheet.dart';
import 'package:kanpractice/presentation/core/ui/folder_list_bottom_sheet.dart';
import 'package:kanpractice/presentation/core/ui/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/ui/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/ui/kp_text_form.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';

class AddMarketListPage extends StatefulWidget {
  const AddMarketListPage({Key? key}) : super(key: key);

  @override
  State<AddMarketListPage> createState() => _AddMarketListPageState();
}

class _AddMarketListPageState extends State<AddMarketListPage> {
  late TextEditingController _tc;
  late FocusNode _fn;
  late TextEditingController _tcUser;
  late FocusNode _fnUser;
  late TextEditingController _tcList;
  late FocusNode _fnList;
  MarketListType _selectedType = MarketListType.list;
  String _listSelection = "add_to_market_select_list".tr();

  @override
  void initState() {
    _tc = TextEditingController();
    _fn = FocusNode();
    _tcUser = TextEditingController();
    _fnUser = FocusNode();
    _tcList = TextEditingController();
    _fnList = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _tc.dispose();
    _fn.dispose();
    _tcUser.dispose();
    _fnUser.dispose();
    _tcList.dispose();
    _fnList.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<AddToMarketBloc>()..add(AddToMarketEventIdle()),
        child: KPScaffold(
          resizeToAvoidBottomInset: true,
          appBarTitle: "add_to_market_title".tr(),
          appBarActions: [
            BlocBuilder<AddToMarketBloc, AddToMarketState>(
              builder: (context, state) {
                if (state is AddToMarketStateLoading ||
                    state is AddToMarketStateSuccess) {
                  return const SizedBox();
                } else {
                  return IconButton(
                      onPressed: () {
                        getIt<AddToMarketBloc>().add(AddToMarketEventOnUpload(
                          _selectedType,
                          _listSelection,
                          _tc.text,
                          _tcUser.text,
                          _tcList.text,
                        ));
                      },
                      icon: const Icon(Icons.check));
                }
              },
            )
          ],
          child: SingleChildScrollView(
            child: BlocConsumer<AddToMarketBloc, AddToMarketState>(
              listener: (context, state) {
                if (state is AddToMarketStateFailure) {
                  Utils.getSnackBar(context, state.message);
                }
                if (state is AddToMarketStateGetUser) {
                  _tcUser.text = state.name;
                }
              },
              builder: (context, state) {
                if (state is AddToMarketStateInitial ||
                    state is AddToMarketStateFailure ||
                    state is AddToMarketStateGetUser) {
                  return Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(bottom: KPMargins.margin16),
                        child: Row(
                          children: [
                            const Padding(
                              padding:
                                  EdgeInsets.only(right: KPMargins.margin8),
                              child: Icon(Icons.info_outline_rounded),
                            ),
                            Expanded(
                                child: Text(
                                    "add_to_market_needs_registration".tr(),
                                    style:
                                        Theme.of(context).textTheme.bodyText1))
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _radio(MarketListType.list),
                          _radio(MarketListType.folder)
                        ],
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(bottom: KPMargins.margin16),
                        child: Card(
                          child: ListTile(
                            title: Text(_listSelection),
                            onTap: () async {
                              if (_selectedType == MarketListType.list) {
                                String? list = await AddToMarketBottomSheet
                                    .callAddToMarketBottomSheet(context);
                                if (list != null && list.isNotEmpty) {
                                  setState(() => _listSelection = list);
                                  _tcList.text = _listSelection;
                                }
                              } else {
                                String? folder =
                                    await FolderListBottomSheet.show(
                                        context, null);
                                if (folder != null && folder.isNotEmpty) {
                                  setState(() => _listSelection = folder);
                                  _tcList.text = _listSelection;
                                }
                              }
                            },
                          ),
                        ),
                      ),
                      KPTextForm(
                          header: "add_to_market_list_name_label".tr(),
                          hint: "add_to_market_list_name_hint".tr(),
                          controller: _tcList,
                          focusNode: _fnList,
                          maxLines: 1,
                          maxLength: 32,
                          onEditingComplete: () => _fnUser.requestFocus()),
                      KPTextForm(
                          header: "add_to_market_username_label".tr(),
                          hint: "add_to_market_username_hint".tr(),
                          controller: _tcUser,
                          focusNode: _fnUser,
                          maxLines: 1,
                          maxLength: 32,
                          onEditingComplete: () => _fn.requestFocus()),
                      KPTextForm(
                          header: "add_to_market_description_label".tr(),
                          hint: "add_to_market_description_hint".tr(),
                          controller: _tc,
                          focusNode: _fn,
                          action: TextInputAction.done,
                          maxLines: 5,
                          maxLength: 140,
                          onEditingComplete: () => _fn.unfocus())
                    ],
                  );
                } else if (state is AddToMarketStateLoading) {
                  return const KPProgressIndicator();
                } else {
                  return Center(
                      child: Column(
                    children: [
                      Icon(Icons.check_circle_rounded,
                          color: KPColors.getSecondaryColor(context),
                          size: KPSizes.maxHeightValidationCircle),
                      Padding(
                        padding: const EdgeInsets.all(KPMargins.margin16),
                        child: Text("add_to_market_successfully_created".tr(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText1),
                      )
                    ],
                  ));
                }
              },
            ),
          ),
        ));
  }

  Widget _radio(MarketListType type) {
    return Flexible(
      child: ListTile(
        title: Text(type.name),
        onTap: () {
          setState(() => _selectedType = type);
        },
        leading: Radio<MarketListType>(
          value: type,
          groupValue: _selectedType,
          onChanged: (value) {
            setState(() => _selectedType = value!);
          },
        ),
      ),
    );
  }
}