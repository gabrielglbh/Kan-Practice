import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/add_folder/add_folder_bloc.dart';
import 'package:kanpractice/application/snackbar/snackbar_bloc.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/widgets/kp_kanlist_grid.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/widgets/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/widgets/kp_text_form.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class AddFolderPage extends StatefulWidget {
  final String? folder;
  const AddFolderPage({super.key, this.folder});

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
      create: (_) =>
          getIt<AddFolderBloc>()..add(AddFolderEventIdle(widget.folder)),
      child: KPScaffold(
        resizeToAvoidBottomInset: true,
        appBarTitle: widget.folder != null
            ? "add_folder_update_title".tr()
            : "add_folder_title".tr(),
        appBarActions: [
          BlocBuilder<AddFolderBloc, AddFolderState>(
            builder: (context, state) {
              return state.maybeWhen(
                loading: () => const SizedBox(),
                loaded: () => const SizedBox(),
                orElse: () => IconButton(
                  onPressed: () {
                    if (widget.folder != null) {
                      context
                          .read<AddFolderBloc>()
                          .add(AddFolderEventOnListAddition(
                            widget.folder!,
                            _selectedLists,
                          ));
                    } else {
                      context.read<AddFolderBloc>().add(
                          AddFolderEventOnUpload(_tc.text, _selectedLists));
                    }
                  },
                  icon: const Icon(Icons.check),
                ),
              );
            },
          )
        ],
        child: BlocConsumer<AddFolderBloc, AddFolderState>(
          listener: (context, state) {
            state.mapOrNull(
              error: (error) {
                context
                    .read<SnackbarBloc>()
                    .add(SnackbarEventShow(error.message));
              },
              loaded: (_) {
                Navigator.of(context).pop();
              },
              loadedLists: (loaded) {
                setState(() {
                  _availableLists = loaded.lists;
                  _selectedLists.addAll(loaded.alreadyAdded);
                });
              },
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const KPProgressIndicator(),
              loaded: () => const SizedBox(),
              orElse: () => Column(
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
                  (state is AddFolderLoadedLists && state.lists.isNotEmpty) ||
                          state is AddFolderInitial ||
                          state is AddFolderError
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
              ),
            );
          },
        ),
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
