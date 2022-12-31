import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/list_details/list_details_bloc.dart';
import 'package:kanpractice/application/list_details_grammar_points/list_details_grammar_points_bloc.dart';
import 'package:kanpractice/application/list_details_words/list_details_words_bloc.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/add_grammar_point_page/arguments.dart';
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
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/tutorial_coach.dart';
import 'package:kanpractice/presentation/list_details_page/grammar_list.dart';
import 'package:kanpractice/presentation/core/ui/kp_word_grammar_bottom_navigation.dart';
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
    getIt<ListDetailBloc>().add(ListDetailEventIdle(widget.list.name));
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

  _addWordLoadingEvent({bool reset = false}) {
    return getIt<ListDetailWordsBloc>()
        .add(ListDetailWordsEventLoading(_listName, reset: reset));
  }

  _addWordSearchingEvent(String query, {bool reset = false}) {
    return getIt<ListDetailWordsBloc>()
        .add(ListDetailWordsEventSearching(query, _listName, reset: reset));
  }

  _addGrammarPointLoadingEvent({bool reset = false}) {
    return getIt<ListDetailGrammarPointsBloc>()
        .add(ListDetailGrammarPointsEventLoading(_listName, reset: reset));
  }

  _addGrammarPointSearchingEvent(String query, {bool reset = false}) {
    return getIt<ListDetailGrammarPointsBloc>().add(
        ListDetailGrammarPointsEventSearching(query, _listName, reset: reset));
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
          _addWordLoadingEvent(reset: true);
          _searchBarFn.unfocus();
          return false;
        } else {
          return true;
        }
      },
      appBarTitle: BlocConsumer<ListDetailBloc, ListDetailState>(
        listener: ((context, state) {
          if (state is ListDetailStateLoaded) {
            final oldName = _listName;
            setState(() => _listName = state.name);
            if (_listName != oldName) {
              _addWordLoadingEvent(reset: true);
              _addGrammarPointLoadingEvent(reset: true);
            }
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
            return const SizedBox();
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
                if (_currentPage == ListDetailsType.words) {
                  await Navigator.of(context)
                      .pushNamed(KanPracticePages.addKanjiPage,
                          arguments: AddWordArgs(listName: _listName))
                      .then((code) => _addWordLoadingEvent(reset: true));
                } else {
                  await Navigator.of(context)
                      .pushNamed(KanPracticePages.addGrammarPage,
                          arguments: AddGrammarPointArgs(listName: _listName))
                      .then(
                          (code) => _addGrammarPointLoadingEvent(reset: true));
                }
              },
              icon: const Icon(Icons.add),
            )
          ],
        ),
      ],
      bottomNavigationWidget: KPWordGrammarBottomNavigation(
        key: navigation,
        currentPage: _currentPage,
        onPageChanged: (type) {
          setState(() => _currentPage = type);
          _searchBarFn.unfocus();
          _searchTextController.text = "";
          _pageController.animateToPage(
            type.page,
            duration: const Duration(milliseconds: KPAnimations.ms300),
            curve: Curves.easeInOut,
          );
        },
      ),
      child: Column(
        children: [
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
              if (_currentPage == ListDetailsType.words) {
                _addWordSearchingEvent(query, reset: true);
              } else {
                _addGrammarPointSearchingEvent(query, reset: true);
              }
            },
            onExitSearch: () {
              /// Empty the query
              _query = "";
              if (_currentPage == ListDetailsType.words) {
                _addWordLoadingEvent(reset: true);
              } else {
                _addGrammarPointLoadingEvent(reset: true);
              }
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
                  listName: _listName,
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
                GrammarListWidget(
                  list: widget.list,
                  listName: _listName,
                  query: _query,
                  searchBarFn: _searchBarFn,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
