import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as im;
import 'package:kanpractice/application/dictionary/dict_bloc.dart';
import 'package:kanpractice/core/routing/pages.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/core/ui/canvas/kp_custom_canvas.dart';
import 'package:kanpractice/presentation/core/ui/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/ui/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/dictionary_details_page/arguments.dart';
import 'package:kanpractice/presentation/dictionary_page/arguments.dart';
import 'package:kanpractice/presentation/dictionary_page/widgets/kanji_search_bar.dart';

import '../core/util/general_utils.dart';

class DictionaryPage extends StatefulWidget {
  final DictionaryArguments args;
  const DictionaryPage({Key? key, required this.args}) : super(key: key);

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
    context.read<DictBloc>().add(DictEventStart());
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
    if (widget.args.searchInJisho) return _body();
    return KPScaffold(
      setGestureDetector: false,
      appBarTitle: widget.args.searchInJisho
          ? "dict_title".tr()
          : 'dict_add_kanji_title'.tr(),
      child: _body(),
    );
  }

  Widget _body() {
    final canSearchEitherWay = canSearch ||
        _searchBarTextController.text != "" ||
        _searchBarTextController.text.isNotEmpty;

    return BlocBuilder<DictBloc, DictState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(child: _searchBar()),
                _searchWidget(canSearchEitherWay)
              ],
            ),
            if (state is DictStateLoading)
              const Center(
                  child: Padding(
                padding: EdgeInsets.all(Margins.margin16),
                child: KPProgressIndicator(),
              ))
            else if (state is DictStateFailure)
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(Margins.margin16),
                child: Text("dict_model_not_loaded".tr(),
                    style: Theme.of(context).textTheme.bodyText2),
              ))
            else if (state is DictStateLoaded)
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Margins.margin8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "< ${"dict_predictions_most_likely".tr()}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${"dict_predictions_less_likely".tr()} >",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        )
                      ],
                    ),
                  ),
                  _predictions(state),
                  KPCustomCanvas(
                    line: _line,
                    allowPrediction: true,
                    handleImage: (im.Image image) {
                      context
                          .read<DictBloc>()
                          .add(DictEventLoading(image: image));
                    },
                  ),
                ],
              )
          ],
        );
      },
    );
  }

  KanjiSearchBar _searchBar() {
    return KanjiSearchBar(
      top: 0,
      hint: widget.args.searchInJisho
          ? "dict_search_bar_hint".tr()
          : "add_kanji_textForm_kanji_ext".tr(),
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

  Widget _searchWidget(bool canSearchEitherWay) {
    return GestureDetector(
      child: AnimatedContainer(
        width: canSearchEitherWay ? CustomSizes.defaultSizeSearchBarIcons : 0,
        height: CustomSizes.defaultSizeSearchBarIcons,
        duration: const Duration(milliseconds: 400),
        margin: EdgeInsets.symmetric(
            horizontal: canSearchEitherWay ? Margins.margin8 : 0),
        decoration: const BoxDecoration(
            shape: BoxShape.circle, color: CustomColors.secondaryColor),
        child: Icon(
          widget.args.searchInJisho ? Icons.search : Icons.done,
          color: Colors.white,
          size: canSearchEitherWay ? 24 : 0,
        ),
      ),
      onTap: () {
        String? text = _searchBarTextController.text;
        if (text.isNotEmpty) {
          /// If the user is searching for words, redirect them to Jisho
          /// If the user is adding words, pop and send the predicted word back
          if (widget.args.searchInJisho) {
            Navigator.of(context).pushNamed(KanPracticePages.jishoPage,
                arguments: DictionaryDetailsArguments(
                    kanji: text, fromDictionary: true));
          } else {
            Navigator.of(context).pop(text);
          }
        } else {
          GeneralUtils.getSnackBar(context, "dict_search_empty".tr());
        }
      },
    );
  }

  SizedBox _predictions(DictStateLoaded state) {
    return SizedBox(
      height: CustomSizes.defaultSizeFiltersList,
      child: ListView.builder(
        itemCount: state.predictions.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final String kanji = state.predictions[index].label.substring(0, 1);
          final double score = state.predictions[index].score;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Margins.margin2),
            child: ActionChip(
                label: Text(
                  kanji,
                  style: TextStyle(
                      fontSize: FontSizes.fontSize18,
                      color: GeneralUtils.getTextColorBasedOnScore(score)),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: Margins.margin8),
                backgroundColor: GeneralUtils.getColorBasedOnScore(score),
                pressElevation: Margins.margin2,
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  _searchBarTextController.text += kanji;
                  setState(() => _line = []);
                }),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
