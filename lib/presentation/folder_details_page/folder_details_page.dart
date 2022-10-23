import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/folder_details/folder_details_bloc.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/presentation/core/types/wordlist_filters.dart';
import 'package:kanpractice/presentation/core/types/tab_types.dart';
import 'package:kanpractice/presentation/core/ui/kp_button.dart';
import 'package:kanpractice/presentation/core/ui/kp_kanji_lists/kanji_lists.dart';
import 'package:kanpractice/presentation/core/ui/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/ui/kp_search_bar.dart';
import 'package:kanpractice/presentation/core/ui/kp_test_bottom_sheet.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/folder_details_page/widgets/practice_on_folder.dart';

class FolderDetailsPage extends StatefulWidget {
  final String folder;
  const FolderDetailsPage({Key? key, required this.folder}) : super(key: key);

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
    return BlocProvider<FolderDetailsBloc>(
      create: (_) => getIt<FolderDetailsBloc>()..add(_addListLoadingEvent()),
      child: BlocBuilder<FolderDetailsBloc, FolderDetailsState>(
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
                  onPressed: () async {
                    await KPTestBottomSheet.show(context,
                        folder: widget.folder);
                  },
                  icon: const Icon(Icons.track_changes_rounded,
                      color: KPColors.secondaryColor),
                ),
                IconButton(
                  icon: const Icon(Icons.auto_awesome_motion_rounded),
                  onPressed: () async {
                    await Navigator.of(context).pushNamed(
                        KanPracticePages.folderAddPage,
                        arguments: widget.folder);
                    getIt<FolderDetailsBloc>().add(_addListLoadingEvent());
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
                      getIt<FolderDetailsBloc>()
                          .add(_addListSearchingEvent(query));
                    },
                    onExitSearch: () {
                      /// Empty the query
                      _query = "";
                      _resetList(context);
                    },
                  ),
                  Expanded(
                    child: KPWordLists(
                      folder: widget.folder,
                      withinFolder: true,
                      removeFocus: () => _searchBarFn.unfocus(),
                      onScrolledToBottom: () {
                        /// If the query is empty, use the pagination for search bar
                        if (_query.isNotEmpty) {
                          getIt<FolderDetailsBloc>().add(
                              _addListSearchingEvent(_query, reset: false));
                        }

                        /// Else use the normal pagination
                        else {
                          getIt<FolderDetailsBloc>()
                              .add(_addListLoadingEvent(reset: false));
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 85,
                    child: KPButton(
                      title1: "list_details_practice_button_label_ext".tr(),
                      title2: "list_details_practice_button_label".tr(),
                      onTap: () async {
                        await PracticeFolderBottomSheet.show(
                            context, widget.folder);
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
