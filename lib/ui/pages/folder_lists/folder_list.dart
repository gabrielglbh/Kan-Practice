import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/models/folder.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/core/types/folder_filters.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/ui/pages/folder_lists/bloc/folder_bloc.dart';
import 'package:kanpractice/ui/widgets/kp_alert_dialog.dart';
import 'package:kanpractice/ui/widgets/kp_empty_list.dart';
import 'package:kanpractice/ui/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/ui/widgets/kp_test_bottom_sheet.dart';

class FolderList extends StatefulWidget {
  final Function() removeFocus;
  final Function() onScrolledToBottom;
  const FolderList(
      {Key? key, required this.removeFocus, required this.onScrolledToBottom})
      : super(key: key);

  @override
  State<FolderList> createState() => _FolderListState();
}

class _FolderListState extends State<FolderList>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  /// This variable keeps track of the actual filter applied. The value is
  /// saved into the shared preferences when a filter is applied.
  /// This value is then restored upon new session.
  FolderFilters _currentAppliedFilter = FolderFilters.all;

  /// This variable keeps track of the order applied on the current filter only:
  /// true --> DESC or false --> ASC. The value is saved into the shared preferences when a filter
  /// is applied. This value is then restored upon new session.
  bool _currentAppliedOrder = true;

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);

    final filterText =
        StorageManager.readData(StorageManager.filtersOnFolder) ??
            FolderTableFields.lastUpdatedField;
    _currentAppliedFilter = FolderFiltersUtils.getFilterFrom(filterText);

    _currentAppliedOrder =
        StorageManager.readData(StorageManager.orderOnFolder) ?? true;
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  _scrollListener() {
    /// When reaching last pixel of the list
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      widget.onScrolledToBottom();
    }
  }

  _addLoadingEvent({bool reset = false}) {
    return context.read<FolderBloc>()
      ..add(FolderEventLoading(
          filter: _currentAppliedFilter,
          order: _currentAppliedOrder,
          reset: reset));
  }

  _resetScroll() {
    /// Scroll to the top
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 400), curve: Curves.easeOut);
  }

  _onFilterSelected(int index) {
    _resetScroll();
    widget.removeFocus();

    /// If the user taps on the same filter twice, just change back and forth the
    /// order value.
    /// Else, means the user has changed the filter, therefore default the order to DESC
    if (_currentAppliedFilter.index == index) {
      setState(() => _currentAppliedOrder = !_currentAppliedOrder);
    } else {
      setState(() => _currentAppliedOrder = true);
    }

    /// Change the current applied filter based on the index selected on the ChoiceChip
    /// and change the value on _filterValues map to reflect the change on the UI
    _currentAppliedFilter = FolderFilters.values[index];

    /// Adds the loading event to the bloc builder to load the new specified list
    _addLoadingEvent(reset: true);

    /// Stores the new filter and order applied to shared preferences
    StorageManager.saveData(
        StorageManager.filtersOnFolder, _currentAppliedFilter.filter);
    StorageManager.saveData(StorageManager.orderOnFolder, _currentAppliedOrder);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [_filterChips(), _lists()],
    );
  }

  SizedBox _filterChips() {
    Icon icon = Icon(
        _currentAppliedOrder
            ? Icons.arrow_downward_rounded
            : Icons.arrow_upward_rounded,
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black);

    return SizedBox(
        height: CustomSizes.defaultSizeFiltersList,
        child: ListView.builder(
            itemCount: FolderFilters.values.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: Margins.margin2),
                child: ChoiceChip(
                  label: Text(FolderFilters.values[index].label),
                  avatar: _currentAppliedFilter.index != index ? null : icon,
                  pressElevation: Margins.margin4,
                  padding:
                      const EdgeInsets.symmetric(horizontal: Margins.margin8),
                  onSelected: (bool selected) => _onFilterSelected(index),
                  selected: _currentAppliedFilter.index == index,
                ),
              );
            }));
  }

  BlocBuilder _lists() {
    return BlocBuilder<FolderBloc, FolderState>(
      builder: (bloc, state) {
        if (state is FolderStateFailure) {
          return KPEmptyList(
              showTryButton: true,
              onRefresh: () => _addLoadingEvent(reset: true),
              message: "folder_list_load_failed".tr());
        } else if (state is FolderStateLoading ||
            state is FolderStateSearching) {
          return const Expanded(child: KPProgressIndicator());
        } else if (state is FolderStateLoaded) {
          return state.lists.isEmpty
              ? Expanded(
                  child: KPEmptyList(
                      onRefresh: () => _addLoadingEvent(reset: true),
                      showTryButton: true,
                      message: "folder_list_empty".tr()))
              : Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => _addLoadingEvent(reset: true),
                    color: CustomColors.secondaryColor,
                    child: ListView.separated(
                        key: const PageStorageKey<String>(
                            'folderListsController'),
                        controller: _scrollController,
                        itemCount: state.lists.length,
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        padding:
                            const EdgeInsets.only(bottom: Margins.margin24),
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, k) {
                          final folder = state.lists[k];
                          final date = GeneralUtils.parseDateMilliseconds(
                              context, folder.lastUpdated);
                          return _tile(bloc, folder, date);
                        }),
                  ),
                );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _tile(BuildContext bloc, Folder folder, String date) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(
          KanPracticePages.kanjiListOnFolderPage,
          arguments: folder.folder,
        );
        widget.removeFocus();
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) => KPDialog(
            title:
                Text("kan_list_tile_createDialogForDeletingFolder_title".tr()),
            content: Text(
                "kan_list_tile_createDialogForDeletingFolder_content".tr()),
            positiveButtonText:
                "kan_list_tile_createDialogForDeletingFolder_positive".tr(),
            onPositive: () {
              bloc.read<FolderBloc>().add(FolderEventDelete(
                    folder,
                    filter: _currentAppliedFilter,
                    order: _currentAppliedOrder,
                  ));
              _resetScroll();
            },
          ),
        );
      },
      title: Text(folder.folder,
          style: Theme.of(context)
              .textTheme
              .headline5
              ?.copyWith(fontWeight: FontWeight.normal),
          overflow: TextOverflow.ellipsis),
      subtitle: Text("${"created_label".tr()} $date"),
      trailing: IconButton(
        onPressed: () async {
          await KPTestBottomSheet.show(context, withinFolder: true);
        },
        icon: const Icon(Icons.track_changes_rounded,
            color: CustomColors.secondaryColor),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
