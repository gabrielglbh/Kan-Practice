import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/add_folder/add_folder_bloc.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/widgets/kp_kanlist_grid.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/widgets/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/widgets/kp_text_form.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';

class AddFolderPage extends StatefulWidget {
  final String? folder;
  const AddFolderPage({Key? key, this.folder}) : super(key: key);

  @override
  State<AddFolderPage> createState() => _AddFolderPageState();
}

class _AddFolderPageState extends State<AddFolderPage> {
  late TextEditingController _tc;
  late FocusNode _fn;
  List<WordList> _availableLists = [];
  final Map<String, bool> _selectedLists = {};

  @override
  void initState() {
    _tc = TextEditingController();
    _fn = FocusNode();
    if (widget.folder != null) _tc.text = widget.folder!;
    getIt<AddFolderBloc>().add(AddFolderEventIdle(widget.folder));
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
    return KPScaffold(
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
                    getIt<AddFolderBloc>().add(AddFolderEventOnListAddition(
                      widget.folder!,
                      _selectedLists,
                    ));
                  } else {
                    getIt<AddFolderBloc>()
                        .add(AddFolderEventOnUpload(_tc.text, _selectedLists));
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
            Utils.getSnackBar(context, state.message);
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
                (state is AddFolderStateAvailableKanLists &&
                            state.lists.isNotEmpty) ||
                        state is AddFolderStateInitial ||
                        state is AddFolderStateFailure
                    ? Expanded(
                        child: Column(
                          children: [
                            _headline("add_folder_lists_selection".tr()),
                            Expanded(
                              child: KPKanListGrid(
                                items: _availableLists,
                                isSelected: (name) =>
                                    _selectedLists[name] == true,
                                onTap: (name) {
                                  setState(() {
                                    if (_selectedLists[name] == true) {
                                      _selectedLists[name] = false;
                                    } else {
                                      _selectedLists[name] = true;
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
    );
  }

  Widget _headline(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: KPMargins.margin16,
        horizontal: KPMargins.margin8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ],
      ),
    );
  }
}
