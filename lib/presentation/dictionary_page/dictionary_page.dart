import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/snackbar/snackbar_bloc.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/core/types/dictionary_types.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/core/widgets/canvas/kp_custom_canvas.dart';
import 'package:kanpractice/presentation/core/widgets/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/dictionary_page/arguments.dart';
import 'package:kanpractice/presentation/dictionary_page/widgets/word_search_bar.dart';

class DictionaryPage extends StatefulWidget {
  final DictionaryArguments args;
  const DictionaryPage({super.key, required this.args});

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage>
    with AutomaticKeepAliveClientMixin {
  /// Current drawn line in the canvas
  List<Offset?> _line = [];

  late TextEditingController _searchBarTextController;

  bool canSearch = false;

  @override
  void initState() {
    _searchBarTextController = TextEditingController();
    String? word = widget.args.word;
    if (word != null) _searchBarTextController.text = word;
    super.initState();
  }

  @override
  void dispose() {
    _searchBarTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.args.searchInJisho
        ? _body()
        : KPScaffold(
            setGestureDetector: false,
            appBarTitle: widget.args.searchInJisho
                ? "dict_title".tr()
                : 'dict_add_word_title'.tr(),
            child: _body(),
          );
  }

  Widget _body() {
    final canSearchEitherWay = canSearch ||
        _searchBarTextController.text != "" ||
        _searchBarTextController.text.isNotEmpty;

    return KPScaffold(
      appBarTitle: DictionaryType.convolution.title,
      setGestureDetector: false,
      appBarActions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(KanPracticePages.historyWordPage);
          },
          icon: const Icon(Icons.history_rounded),
        ),
      ],
      child: Column(
        children: [
          const SizedBox(height: KPMargins.margin8),
          _searchBar(),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              KPCustomCanvas(
                line: _line,
                allowPrediction: true,
                handleImage: (_, __) {},
              ),
              if (canSearchEitherWay) _searchWidget(),
            ],
          ),
        ],
      ),
    );
  }

  WordSearchBar _searchBar() {
    return WordSearchBar(
      top: 0,
      hint: widget.args.searchInJisho
          ? "dict_search_bar_hint".tr()
          : "add_word_textForm_word_ext".tr(),
      controller: _searchBarTextController,
      enabled: widget.args.searchInJisho,
      onChange: (value) {
        setState(() {
          if (value.isNotEmpty) {
            canSearch = true;
          } else {
            canSearch = false;
          }
        });
      },
      onClear: () {
        setState(() {
          _searchBarTextController.clear();
          canSearch = false;
        });
      },
      onRemoveLast: () {
        String? text = _searchBarTextController.text;
        if (text.isNotEmpty) {
          setState(() {
            _searchBarTextController.text = text.substring(0, text.length - 1);
            if (_searchBarTextController.text.trim().isEmpty) {
              canSearch = false;
            }
          });
        }
      },
    );
  }

  Widget _searchWidget() {
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width / 3,
        height: KPSizes.defaultSizeSearchBarIcons,
        margin: const EdgeInsets.all(KPMargins.margin8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(KPRadius.radius16),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.args.searchInJisho ? Icons.search : Icons.done,
              color: Theme.of(context).colorScheme.onPrimary,
              size: 24,
            ),
            const SizedBox(width: KPMargins.margin8),
            Flexible(
              child: Text("ocr_search_in_jisho_part1".tr(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary)),
            ),
          ],
        ),
      ),
      onTap: () async {
        String? text = _searchBarTextController.text;
        if (text.isNotEmpty) {
          /// If the user is searching for words, redirect them to Jisho
          /// If the user is adding words, pop and send the predicted word back
          if (widget.args.searchInJisho) {
            await Utils.launch(context, Utils.getJishoUri(text));
          } else {
            Navigator.of(context).pop(text);
          }
        } else {
          context
              .read<SnackbarBloc>()
              .add(SnackbarEventShow("dict_search_empty".tr()));
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
