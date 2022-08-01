import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/core/types/kanlist_filters.dart';
import 'package:kanpractice/core/types/tab_types.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/pages/kanji_list_on_folder/bloc/kl_folder_bloc.dart';
import 'package:kanpractice/ui/widgets/kp_kanji_lists/kanji_lists.dart';
import 'package:kanpractice/ui/widgets/kp_scaffold.dart';
import 'package:kanpractice/ui/widgets/kp_search_bar.dart';

class KanListOnFolderPage extends StatefulWidget {
  final String folder;
  const KanListOnFolderPage({Key? key, required this.folder}) : super(key: key);

  @override
  State<KanListOnFolderPage> createState() => _KanListOnFolderPageState();
}

class _KanListOnFolderPageState extends State<KanListOnFolderPage> {
  late FocusNode _searchBarFn;
  late TextEditingController _searchTextController;
  bool _searchHasFocus = false;

  String _query = "";

  @override
  void initState() {
    _searchBarFn = FocusNode();
    _searchTextController = TextEditingController();
    _searchBarFn.addListener(_focusListener);
    super.initState();
  }

  KLFolderEventLoading _addListLoadingEvent({bool reset = true}) =>
      KLFolderEventLoading(
        folder: widget.folder,
        filter: KanListFilters.all,
        order: true,
        reset: reset,
      );

  KLFolderEventSearching _addListSearchingEvent(String query,
          {bool reset = true}) =>
      KLFolderEventSearching(query, widget.folder, reset: reset);

  _resetList(BuildContext context) {
    context.read<KLFolderBloc>().add(_addListLoadingEvent());
  }

  _focusListener() => _searchHasFocus = _searchBarFn.hasFocus;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<KLFolderBloc>(
      create: (_) => KLFolderBloc()..add(_addListLoadingEvent()),
      child: BlocBuilder<KLFolderBloc, KLFolderState>(
        builder: (context, state) {
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
                  onPressed: () {
                    // TODO: New bottom sheet for selecting the folders
                  },
                  icon: const Icon(Icons.flash_on_rounded),
                ),
                IconButton(
                  icon: const Icon(Icons.auto_awesome_motion_rounded),
                  onPressed: () async {
                    final bloc = context.read<KLFolderBloc>();
                    await Navigator.of(context).pushNamed(
                        KanPracticePages.folderAddPage,
                        arguments: widget.folder);
                    bloc.add(_addListLoadingEvent());
                  },
                )
              ],
              child: Column(
                children: [
                  KPSearchBar(
                    controller: _searchTextController,
                    hint: TabType.kanlist.searchBarHint,
                    focus: _searchBarFn,
                    right: Margins.margin12,
                    onQuery: (String query) {
                      /// Everytime the user queries, reset the query itself and
                      /// the pagination index
                      _query = query;
                      context
                          .read<KLFolderBloc>()
                          .add(_addListSearchingEvent(query));
                    },
                    onExitSearch: () {
                      /// Empty the query
                      _query = "";
                      _resetList(context);
                    },
                  ),
                  Expanded(
                    child: KPKanjiLists(
                      folder: widget.folder,
                      withinFolder: true,
                      removeFocus: () => _searchBarFn.unfocus(),
                      onScrolledToBottom: () {
                        /// If the query is empty, use the pagination for search bar
                        if (_query.isNotEmpty) {
                          context.read<KLFolderBloc>().add(
                              _addListSearchingEvent(_query, reset: false));
                        }

                        /// Else use the normal pagination
                        else {
                          context
                              .read<KLFolderBloc>()
                              .add(_addListLoadingEvent(reset: false));
                        }
                      },
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}
