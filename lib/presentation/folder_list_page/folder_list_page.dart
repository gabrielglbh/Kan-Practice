import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/folder_list/folder_bloc.dart';
import 'package:kanpractice/application/services/database_consts.dart';
import 'package:kanpractice/application/services/preferences_service.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/presentation/core/types/folder_filters.dart';
import 'package:kanpractice/domain/folder/folder.dart';
import 'package:kanpractice/presentation/core/ui/kp_alert_dialog.dart';
import 'package:kanpractice/presentation/core/ui/kp_empty_list.dart';
import 'package:kanpractice/presentation/core/ui/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/ui/kp_test_bottom_sheet.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';

class FolderListPage extends StatefulWidget {
  final Function() removeFocus;
  final Function() onScrolledToBottom;
  const FolderListPage(
      {Key? key, required this.removeFocus, required this.onScrolledToBottom})
      : super(key: key);

  @override
  State<FolderListPage> createState() => _FolderListPageState();
}

class _FolderListPageState extends State<FolderListPage>
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
        getIt<PreferencesService>().readData(SharedKeys.filtersOnFolder) ??
            FolderTableFields.lastUpdatedField;
    _currentAppliedFilter = FolderFiltersUtils.getFilterFrom(filterText);

    _currentAppliedOrder =
        getIt<PreferencesService>().readData(SharedKeys.orderOnFolder) ?? true;
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
    return getIt<FolderBloc>()
      ..add(FolderEventLoading(
          filter: _currentAppliedFilter,
          order: _currentAppliedOrder,
          reset: reset));
  }

  _resetScroll() {
    /// Scroll to the top
    if (_scrollController.hasClients) {
      _scrollController.animateTo(0,
          duration: const Duration(milliseconds: 400), curve: Curves.easeOut);
    }
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
    getIt<PreferencesService>()
        .saveData(SharedKeys.filtersOnFolder, _currentAppliedFilter.filter);
    getIt<PreferencesService>()
        .saveData(SharedKeys.orderOnFolder, _currentAppliedOrder);
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
        color: KPColors.getAlterAccent(context));

    return SizedBox(
        height: KPSizes.defaultSizeFiltersList,
        child: ListView.builder(
            itemCount: FolderFilters.values.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: KPMargins.margin2),
                child: ChoiceChip(
                  label: Text(FolderFilters.values[index].label),
                  avatar: _currentAppliedFilter.index != index ? null : icon,
                  pressElevation: KPMargins.margin4,
                  padding:
                      const EdgeInsets.symmetric(horizontal: KPMargins.margin8),
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
                    onRefresh: () async => _addLoadingEvent(reset: true),
                    color: KPColors.secondaryColor,
                    child: ListView.separated(
                        key: const PageStorageKey<String>(
                            'folderListsController'),
                        controller: _scrollController,
                        itemCount: state.lists.length,
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        padding:
                            const EdgeInsets.only(bottom: KPMargins.margin24),
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, k) {
                          final folder = state.lists[k];
                          final date = Utils.parseDateMilliseconds(
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
              getIt<FolderBloc>().add(FolderEventDelete(
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
          await KPTestBottomSheet.show(context, folder: folder.folder);
        },
        icon: const Icon(Icons.track_changes_rounded,
            color: KPColors.secondaryColor),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
