import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/list_details/list_details_bloc.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/preferences/store_manager.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/core/tutorial/tutorial_manager.dart';
import 'package:kanpractice/core/types/test_modes.dart';
import 'package:kanpractice/core/types/coach_tutorial_parts.dart';
import 'package:kanpractice/core/types/study_modes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/add_word_page/arguments.dart';
import 'package:kanpractice/presentation/core/ui/blitz/kp_blitz_bottom_sheet.dart';
import 'package:kanpractice/presentation/core/ui/folder_list_bottom_sheet.dart';
import 'package:kanpractice/presentation/core/ui/kp_alert_dialog.dart';
import 'package:kanpractice/presentation/core/ui/kp_button.dart';
import 'package:kanpractice/presentation/core/ui/kp_empty_list.dart';
import 'package:kanpractice/presentation/core/ui/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/ui/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/ui/kp_search_bar.dart';
import 'package:kanpractice/presentation/core/ui/kp_text_form.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/list_details_page/widgets/kanji_item.dart';
import 'package:kanpractice/presentation/list_details_page/widgets/practice_on_list_bottom_sheet.dart';
import 'package:kanpractice/presentation/study_modes/utils/mode_arguments.dart';

class ListDetailsPage extends StatefulWidget {
  final KanjiList list;
  const ListDetailsPage({Key? key, required this.list}) : super(key: key);

  @override
  State<ListDetailsPage> createState() => _ListDetailsPageState();
}

class _ListDetailsPageState extends State<ListDetailsPage>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  /// Tutorial Global Keys
  final GlobalKey vocabulary = GlobalKey();
  final GlobalKey actions = GlobalKey();
  final GlobalKey changeName = GlobalKey();

  FocusNode? _searchBarFn;
  TabController? _tabController;
  StudyModes _selectedMode = StudyModes.writing;
  bool _aggrStats = false;

  /// Saves the last state of the query
  String _query = "";

  /// Saves the last name of the current visited list
  String _listName = "";

  bool _searchHasFocus = false;
  bool _onTutorial = false;

  @override
  void initState() {
    _searchBarFn = FocusNode();
    _tabController =
        TabController(length: StudyModes.values.length, vsync: this);
    _tabController?.addListener(_tabControllerManagement);
    _searchBarFn?.addListener(_focusListener);
    _scrollController.addListener(_scrollListener);
    _listName = widget.list.name;
    _aggrStats =
        StorageManager.readData(StorageManager.kanListListVisualization);
    super.initState();
  }

  @override
  void dispose() {
    _searchBarFn?.removeListener(_focusListener);
    _searchBarFn?.dispose();
    _tabController?.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  _scrollListener() {
    /// When reaching last pixel of the list
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      /// If the query is empty, use the pagination for search bar
      if (_query.isNotEmpty) {
        _addSearchingEvent(_query);
      }

      /// Else use the normal pagination
      else {
        _addLoadingEvent();
      }
    }
  }

  _tabControllerManagement() {
    _searchBarFn?.unfocus();
    setState(() {
      _selectedMode = StudyModes.values[_tabController?.index ?? 0];
    });
  }

  _focusListener() =>
      setState(() => _searchHasFocus = (_searchBarFn?.hasFocus ?? false));

  _onModeChange(StudyModes newMode) {
    _searchBarFn?.unfocus();
    setState(() {
      _selectedMode = newMode;
    });
    _tabController?.animateTo(newMode.index,
        duration: const Duration(milliseconds: KPAnimations.ms300),
        curve: Curves.easeInOut);
  }

  _updateSelectedModePageView(double pv) {
    switch (_selectedMode) {
      case StudyModes.writing:
        if (pv < 0) _onModeChange(StudyModes.reading);
        break;
      case StudyModes.reading:
        if (pv < 0) {
          _onModeChange(StudyModes.recognition);
        } else if (pv > 0) {
          _onModeChange(StudyModes.writing);
        }
        break;
      case StudyModes.recognition:
        if (pv < 0) {
          _onModeChange(StudyModes.listening);
        } else if (pv > 0) {
          _onModeChange(StudyModes.reading);
        }
        break;
      case StudyModes.listening:
        if (pv < 0) {
          _onModeChange(StudyModes.speaking);
        } else if (pv > 0) {
          _onModeChange(StudyModes.recognition);
        }
        break;
      case StudyModes.speaking:
        if (pv > 0) _onModeChange(StudyModes.listening);
        break;
    }
  }

  _addLoadingEvent({bool reset = false}) {
    return context
        .read<ListDetailBloc>()
        .add(ListDetailEventLoading(_listName, reset: reset));
  }

  _addSearchingEvent(String query, {bool reset = false}) {
    return context
        .read<ListDetailBloc>()
        .add(ListDetailEventSearching(query, _listName, reset: reset));
  }

  _updateName(BuildContext bloc, String name) {
    if (name.isNotEmpty) {
      bloc.read<ListDetailBloc>().add(ListDetailUpdateName(name, _listName));
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
                  _updateName(bloc, nameController.text);
                },
              ),
              positiveButtonText:
                  "list_details_updateKanListName_positive".tr(),
              onPositive: () => _updateName(bloc, nameController.text));
        });
  }

  Future<void> _goToPractice(ListDetailStateLoadedPractice state) async {
    await Navigator.of(context)
        .pushNamed(state.mode.page,
            arguments: ModeArguments(
                studyList: state.list,
                isTest: false,
                mode: state.mode,
                testMode: Tests.blitz,
                studyModeHeaderDisplayName: widget.list.name))
        .then(
          (value) => _addLoadingEvent(reset: true),
        );
  }

  @override
  Widget build(BuildContext context) {
    /// BlocProvider is defined at route level in order for the whole context of the
    /// class to be accessible to the provider
    return KPScaffold(
      onWillPop: () async {
        if (_onTutorial) return false;
        if (_searchHasFocus) {
          _addLoadingEvent(reset: true);
          _searchBarFn?.unfocus();
          return false;
        } else {
          return true;
        }
      },
      appBarTitle: BlocBuilder<ListDetailBloc, ListDetailState>(
        builder: (context, state) {
          if (state is ListDetailStateLoaded) {
            _listName = state.name;
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
                FolderListBottomSheet.show(context, widget.list.name);
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
      child: Column(
        children: [
          KPSearchBar(
            hint: "list_details_searchBar_hint".tr(),
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
            child: BlocConsumer<ListDetailBloc, ListDetailState>(
              key: vocabulary,
              listener: (context, state) async {
                if (state is ListDetailStateLoadedPractice) {
                  await _goToPractice(state);
                } else if (state is ListDetailStateFailure) {
                  if (state.error.isNotEmpty) {
                    Utils.getSnackBar(context, state.error);
                  }
                } else if (state is ListDetailStateLoaded) {
                  if (StorageManager.readData(
                          StorageManager.haveSeenKanListDetailCoachMark) ==
                      false) {
                    _onTutorial = true;
                    await TutorialCoach([vocabulary, actions, changeName],
                            CoachTutorialParts.details)
                        .showTutorial(context,
                            onEnd: () => _onTutorial = false);
                  }
                }
              },
              builder: (context, state) {
                if (state is ListDetailStateLoaded) {
                  _listName = state.name;
                  return _body(context, state);
                } else if (state is ListDetailStateLoading ||
                    state is ListDetailStateSearching ||
                    state is ListDetailStateLoadedPractice) {
                  return const KPProgressIndicator();
                } else if (state is ListDetailStateFailure) {
                  return KPEmptyList(
                      showTryButton: true,
                      onRefresh: () => _addLoadingEvent(reset: true),
                      message: "list_details_load_failed".tr());
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Column _body(BuildContext bloc, ListDetailStateLoaded state) {
    return Column(
      children: [
        if (!_aggrStats)
          Padding(
            padding: const EdgeInsets.only(bottom: KPMargins.margin8),
            child: TabBar(
                controller: _tabController,
                tabs: List.generate(StudyModes.values.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Icon(
                      StudyModes.values[index].icon,
                      color: StudyModes.values[index].color,
                    ),
                  );
                })),
          ),
        _aggrStats
            ? Expanded(child: _kanjiList(state))
            : Expanded(
                child: GestureDetector(
                /// Dismiss keyboard if possible whenever a vertical or horizontal
                /// drag down occurs on screen
                onVerticalDragStart: (details) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                onHorizontalDragStart: (details) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                onHorizontalDragEnd: (details) {
                  double? pv = details.primaryVelocity;
                  if (pv != null) _updateSelectedModePageView(pv);
                },
                child: _kanjiList(state),
              )),
        KPButton(
            title1: "list_details_practice_button_label_ext".tr(),
            title2: "list_details_practice_button_label".tr(),
            onTap: () async {
              if (_aggrStats) {
                return await PracticeListBottomSheet.show(
                        context, widget.list.name, state.list)
                    .then(
                  (value) => _addLoadingEvent(reset: true),
                );
              }
              bloc
                  .read<ListDetailBloc>()
                  .add(ListDetailEventLoadUpPractice(_listName, _selectedMode));
            }),
      ],
    );
  }

  Widget _kanjiList(ListDetailStateLoaded state) {
    if (state.list.isEmpty) {
      return KPEmptyList(
          showTryButton: true,
          onRefresh: () => _addLoadingEvent(reset: true),
          message: "list_details_empty".tr());
    }
    return GridView.builder(
      key: const PageStorageKey<String>('kanjiListController'),
      itemCount: state.list.length,
      controller: _scrollController,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5, childAspectRatio: 2),
      itemBuilder: (context, k) {
        Kanji? kanji = state.list[k];
        return KanjiItem(
          aggregateStats: _aggrStats,
          index: k,
          kanji: kanji,
          list: widget.list,
          listName: _listName,
          selectedMode: _selectedMode,
          onShowModal: () => _searchBarFn?.unfocus(),
          onTap: () async {
            await Navigator.of(context)
                .pushNamed(KanPracticePages.addKanjiPage,
                    arguments: AddWordArgs(listName: _listName, kanji: kanji))
                .then((code) {
              if (code == 0) _addLoadingEvent(reset: true);
            });
          },
          onRemoval: () => _addLoadingEvent(reset: true),
        );
      },
    );
  }
}
