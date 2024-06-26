import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/folder_details/folder_details_bloc.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/presentation/core/types/wordlist_filters.dart';
import 'package:kanpractice/presentation/core/types/tab_types.dart';
import 'package:kanpractice/presentation/core/widgets/kanlists/kp_kanlists.dart';
import 'package:kanpractice/presentation/core/widgets/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/widgets/kp_search_bar.dart';
import 'package:kanpractice/presentation/core/widgets/kp_test_bottom_sheet.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class FolderDetailsPage extends StatefulWidget {
  final String folder;
  const FolderDetailsPage({super.key, required this.folder});

  @override
  State<FolderDetailsPage> createState() => _FolderDetailsPageState();
}

class _FolderDetailsPageState extends State<FolderDetailsPage> {
  late FocusNode _searchBarFn;
  late TextEditingController _searchTextController;
  bool _searchHasFocus = false;

  String _query = "";

  @override
  void initState() {
    _searchBarFn = FocusNode();
    _searchTextController = TextEditingController();
    _searchBarFn.addListener(_focusListener);
    context.read<FolderDetailsBloc>().add(_addListLoadingEvent());
    super.initState();
  }

  FolderDetailsEventLoading _addListLoadingEvent({bool reset = true}) =>
      FolderDetailsEventLoading(
        folder: widget.folder,
        filter: WordListFilters.all,
        order: true,
        reset: reset,
      );

  FolderDetailsEventSearching _addListSearchingEvent(String query,
          {bool reset = true}) =>
      FolderDetailsEventSearching(query, widget.folder, reset: reset);

  _resetList(BuildContext context) {
    context.read<FolderDetailsBloc>().add(_addListLoadingEvent());
  }

  _focusListener() => _searchHasFocus = _searchBarFn.hasFocus;

  @override
  Widget build(BuildContext context) {
    return KPScaffold(
      onWillPop: () async {
        if (_searchHasFocus) {
          _resetList(context);
          _searchBarFn.unfocus();
          return false;
        } else {
          return true;
        }
      },
      appBarTitle: widget.folder,
      appBarActions: [
        IconButton(
          onPressed: () async {
            await KPTestBottomSheet.show(context, folder: widget.folder);
          },
          icon: Icon(Icons.track_changes_rounded,
              color: Theme.of(context).colorScheme.primary),
        ),
        IconButton(
          icon: const Icon(Icons.auto_awesome_motion_rounded),
          onPressed: () async {
            await Navigator.of(context).pushNamed(
                KanPracticePages.folderAddPage,
                arguments: widget.folder);
            if (!mounted) return;
            // ignore: use_build_context_synchronously
            context.read<FolderDetailsBloc>().add(_addListLoadingEvent());
          },
        ),
      ],
      child: Column(
        children: [
          KPSearchBar(
            controller: _searchTextController,
            hint: TabType.kanlist.searchBarHint,
            focus: _searchBarFn,
            right: KPMargins.margin12,
            onQuery: (String query) {
              /// Everytime the user queries, reset the query itself and
              /// the pagination index
              _query = query;
              context
                  .read<FolderDetailsBloc>()
                  .add(_addListSearchingEvent(query));
            },
            onExitSearch: () {
              /// Empty the query
              _query = "";
              _resetList(context);
            },
          ),
          Expanded(
            child: KPKanlists(
              folder: widget.folder,
              withinFolder: true,
              removeFocus: () => _searchBarFn.unfocus(),
              onScrolledToBottom: (addFolderListLoadingWithFilters) {
                /// If the query is empty, use the pagination for search bar
                if (_query.isNotEmpty) {
                  context
                      .read<FolderDetailsBloc>()
                      .add(_addListSearchingEvent(_query, reset: false));
                }

                /// Else use the normal pagination
                else {
                  addFolderListLoadingWithFilters();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
