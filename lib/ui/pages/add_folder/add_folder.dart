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
  final String? folder;
  const AddFolderPage({Key? key, this.folder}) : super(key: key);

  @override
  State<AddFolderPage> createState() => _AddFolderPageState();
}

class _AddFolderPageState extends State<AddFolderPage> {
  late TextEditingController _tc;
  late FocusNode _fn;
  List<KanjiList> _availableLists = [];
  List<String> _selectedLists = [];

  @override
  void initState() {
    _tc = TextEditingController();
    _fn = FocusNode();
    if (widget.folder != null) _tc.text = widget.folder!;
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
      create: (_) => AddFolderBloc()..add(AddFolderEventIdle(widget.folder)),
      child: KPScaffold(
        resizeToAvoidBottomInset: true,
        appBarTitle: widget.folder != null
            ? "add_folder_update_title".tr()
            : "add_folder_title".tr(),
        appBarActions: [
          BlocBuilder<AddFolderBloc, AddFolderState>(
            builder: (context, state) {
              if (state is AddFolderStateLoading ||
                  state is AddFolderStateSuccess) {
                return const SizedBox();
              } else {
                return IconButton(
                  onPressed: () {
                    if (widget.folder != null) {
                      context.read<AddFolderBloc>().add(
                          AddFolderEventOnListAddition(
                              widget.folder!, _selectedLists));
                    } else {
                      context.read<AddFolderBloc>().add(
                          AddFolderEventOnUpload(_tc.text, _selectedLists));
                    }
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
              setState(() {
                _availableLists = state.lists;
                _selectedLists.addAll(state.alreadyAdded);
              });
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
                    enabled: widget.folder == null,
                    onEditingComplete: () => _fn.unfocus(),
                  ),
                  state is AddFolderStateAvailableKanLists &&
                          state.lists.isNotEmpty
                      ? Expanded(
                          child: Column(
                            children: [
                              _headline("add_folder_lists_selection".tr()),
                              Expanded(
                                child: KPKanListGrid(
                                  items: _availableLists,
                                  isSelected: (name) =>
                                      _selectedLists.contains(name),
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
                          ),
                        )
                      : _headline("add_folder_lists_selection_empty".tr())
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

  Widget _headline(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Margins.margin16,
        horizontal: Margins.margin8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ],
      ),
    );
  }
}
