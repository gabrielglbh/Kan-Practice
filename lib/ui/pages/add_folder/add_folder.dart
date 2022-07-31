import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/ui/pages/add_folder/bloc/add_folder_bloc.dart';
import 'package:kanpractice/ui/widgets/kp_kanlist_grid.dart';
import 'package:kanpractice/ui/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/ui/widgets/kp_scaffold.dart';
import 'package:kanpractice/ui/widgets/kp_text_form.dart';

class AddFolderPage extends StatefulWidget {
  const AddFolderPage({Key? key}) : super(key: key);

  @override
  State<AddFolderPage> createState() => _AddFolderPageState();
}

class _AddFolderPageState extends State<AddFolderPage> {
  late TextEditingController _tc;
  late FocusNode _fn;
  List<KanjiList> _availableLists = [];
  final List<String> _selectedLists = [];

  @override
  void initState() {
    _tc = TextEditingController();
    _fn = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _tc.dispose();
    _fn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddFolderBloc()..add(AddFolderEventIdle()),
      child: KPScaffold(
        resizeToAvoidBottomInset: true,
        appBarTitle: "add_folder_title".tr(),
        appBarActions: [
          BlocBuilder<AddFolderBloc, AddFolderState>(
            builder: (context, state) {
              if (state is AddFolderStateLoading ||
                  state is AddFolderStateSuccess) {
                return const SizedBox();
              } else {
                return IconButton(
                  onPressed: () {
                    context
                        .read<AddFolderBloc>()
                        .add(AddFolderEventOnUpload(_tc.text, _selectedLists));
                  },
                  icon: const Icon(Icons.check),
                );
              }
            },
          )
        ],
        child: BlocConsumer<AddFolderBloc, AddFolderState>(
          listener: (context, state) {
            if (state is AddFolderStateFailure) {
              GeneralUtils.getSnackBar(context, state.message);
            }
            if (state is AddFolderStateSuccess) {
              Navigator.of(context).pop();
            }
            if (state is AddFolderStateAvailableKanLists) {
              setState(() => _availableLists = state.lists);
            }
          },
          builder: (context, state) {
            if (state is AddFolderStateInitial ||
                state is AddFolderStateFailure ||
                state is AddFolderStateAvailableKanLists) {
              return Column(
                children: [
                  KPTextForm(
                    header: "add_folder_name_label".tr(),
                    hint: "add_folder_name_hint".tr(),
                    controller: _tc,
                    focusNode: _fn,
                    maxLines: 1,
                    maxLength: 32,
                    action: TextInputAction.done,
                    onEditingComplete: () => _fn.unfocus(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: Margins.margin16,
                      horizontal: Margins.margin8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "add_folder_lists_selection".tr(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: KPKanListGrid(
                      items: _availableLists,
                      isSelected: (name) => _selectedLists.contains(name),
                      onTap: (name) {
                        setState(() {
                          if (_selectedLists.contains(name)) {
                            _selectedLists.remove(name);
                          } else {
                            _selectedLists.add(name);
                          }
                        });
                      },
                    ),
                  )
                ],
              );
            } else if (state is AddFolderStateLoading) {
              return const KPProgressIndicator();
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
