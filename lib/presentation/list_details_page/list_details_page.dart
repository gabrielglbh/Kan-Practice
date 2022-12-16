import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/list_details/list_details_bloc.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/domain/list/list.dart';
import 'package:kanpractice/presentation/add_word_page/arguments.dart';
import 'package:kanpractice/presentation/core/types/coach_tutorial_parts.dart';
import 'package:kanpractice/presentation/core/types/list_details_types.dart';
import 'package:kanpractice/presentation/core/ui/blitz/kp_blitz_bottom_sheet.dart';
import 'package:kanpractice/presentation/core/ui/folder_list_bottom_sheet.dart';
import 'package:kanpractice/presentation/core/ui/kp_alert_dialog.dart';
import 'package:kanpractice/presentation/core/ui/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/ui/kp_search_bar.dart';
import 'package:kanpractice/presentation/core/ui/kp_text_form.dart';
import 'package:kanpractice/presentation/core/util/tutorial_coach.dart';
import 'package:kanpractice/presentation/list_details_page/grammar_list.dart';
import 'package:kanpractice/presentation/list_details_page/widgets/list_details_bottom_navigation.dart';
import 'package:kanpractice/presentation/list_details_page/word_list.dart';

class ListDetailsPage extends StatefulWidget {
  final WordList list;
  const ListDetailsPage({Key? key, required this.list}) : super(key: key);

  @override
  State<ListDetailsPage> createState() => _ListDetailsPageState();
}

class _ListDetailsPageState extends State<ListDetailsPage>
    with SingleTickerProviderStateMixin {
  /// Tutorial Global Keys
  final GlobalKey vocabulary = GlobalKey();
  final GlobalKey actions = GlobalKey();
  final GlobalKey changeName = GlobalKey();
  final GlobalKey navigation = GlobalKey();

  final _searchBarFn = FocusNode();
  final _pageController = PageController();
  final _searchTextController = TextEditingController();

  /// Saves the last state of the query
  String _query = "";

  /// Saves the last name of the current visited list
  String _listName = "";

  bool _searchHasFocus = false;
  bool _onTutorial = false;
  ListDetailsType _currentPage = ListDetailsType.words;

  @override
  void initState() {
    _searchBarFn.addListener(_focusListener);
    _listName = widget.list.name;
    super.initState();
  }

  @override
  void dispose() {
    _searchBarFn.removeListener(_focusListener);
    _searchBarFn.dispose();
    _pageController.dispose();
    super.dispose();
  }

  _focusListener() => setState(() => _searchHasFocus = _searchBarFn.hasFocus);

  _addLoadingEvent({bool reset = false}) {
    return getIt<ListDetailBloc>()
        .add(ListDetailEventLoading(_listName, reset: reset));
  }

  _addSearchingEvent(String query, {bool reset = false}) {
    return getIt<ListDetailBloc>()
        .add(ListDetailEventSearching(query, _listName, reset: reset));
  }

  _updateName(String name) {
    if (name.isNotEmpty) {
      getIt<ListDetailBloc>().add(ListDetailUpdateName(name, _listName));
    }
  }

  _updateKanListName(BuildContext bloc) {
    TextEditingController nameController = TextEditingController();
    FocusNode nameControllerFn = FocusNode();
    showDialog(
        context: bloc,
        builder: (context) {
          return KPDialog(
              title: Text("list_details_updateKanListName_title".tr()),
              content: KPTextForm(
                hint: _listName,
                maxLength: 32,
                header: 'list_details_updateKanListName_header'.tr(),
                controller: nameController,
                focusNode: nameControllerFn,
                autofocus: true,
                onEditingComplete: () {
                  Navigator.of(context).pop();
                  _updateName(nameController.text);
                },
              ),
              positiveButtonText:
                  "list_details_updateKanListName_positive".tr(),
              onPositive: () => _updateName(nameController.text));
        });
  }

  @override
  Widget build(BuildContext context) {
    return KPScaffold(
      onWillPop: () async {
        if (_onTutorial) return false;
        if (_searchHasFocus) {
          _addLoadingEvent(reset: true);
          _searchBarFn.unfocus();
          return false;
        } else {
          return true;
        }
      },
      appBarTitle: BlocConsumer<ListDetailBloc, ListDetailState>(
        listener: ((context, state) {
          if (state is ListDetailStateLoaded) {
            _listName = state.name;
          }
        }),
        builder: (context, state) {
          if (state is ListDetailStateLoaded) {
            return FittedBox(
                fit: BoxFit.fitWidth,
                child: GestureDetector(
                  onTap: () async => await _updateKanListName(context),
                  child: Text(state.name,
                      key: changeName,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).appBarTheme.titleTextStyle),
                ));
          } else {
            return Container();
          }
        },
      ),
      appBarActions: [
        Row(
          key: actions,
          children: [
            IconButton(
              onPressed: () async => await KPBlitzBottomSheet.show(context,
                  practiceList: _listName),
              icon: const Icon(Icons.flash_on_rounded),
            ),
            IconButton(
              onPressed: () {
                FolderListBottomSheet.show(context, _listName);
              },
              icon: const Icon(Icons.create_new_folder_rounded),
            ),
            IconButton(
              onPressed: () async {
                await Navigator.of(context)
                    .pushNamed(KanPracticePages.addKanjiPage,
                        arguments: AddWordArgs(listName: _listName))
                    .then((code) => _addLoadingEvent(reset: true));
              },
              icon: const Icon(Icons.add),
            )
          ],
        ),
      ],
      bottomNavigationWidget: ListDetailsBottomNavigation(
        key: navigation,
        currentPage: _currentPage,
        onPageChanged: (type) {
          setState(() => _currentPage = type);
          _searchBarFn.unfocus();
          _searchTextController.text = "";
          _pageController.jumpToPage(type.page);
        },
      ),
      child: Column(
        children: [
          // TODO: Grammar queries
          KPSearchBar(
            controller: _searchTextController,
            hint: _currentPage == ListDetailsType.words
                ? "list_details_searchBar_hint".tr()
                : "list_details_searchBar_hint_grammar".tr(),
            focus: _searchBarFn,
            onQuery: (String query) {
              /// Everytime the user queries, reset the query itself and
              /// the pagination index
              _query = query;
              _addSearchingEvent(query, reset: true);
            },
            onExitSearch: () {
              /// Empty the query
              _query = "";
              _addLoadingEvent(reset: true);
            },
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                WordListWidget(
                  key: vocabulary,
                  list: widget.list,
                  query: _query,
                  searchBarFn: _searchBarFn,
                  onStartTutorial: () async {
                    _onTutorial = true;
                    await TutorialCoach(
                            [vocabulary, navigation, actions, changeName],
                            CoachTutorialParts.details)
                        .showTutorial(context,
                            onEnd: () => _onTutorial = false);
                  },
                ),
                const GrammarListWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
