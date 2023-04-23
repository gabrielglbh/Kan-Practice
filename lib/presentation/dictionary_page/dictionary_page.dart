import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as im;
import 'package:kanpractice/application/dictionary/dictionary_bloc.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/core/widgets/canvas/kp_custom_canvas.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/widgets/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/dictionary_details_page/arguments.dart';
import 'package:kanpractice/presentation/dictionary_page/arguments.dart';
import 'package:kanpractice/presentation/dictionary_page/widgets/word_search_bar.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

import '../core/util/utils.dart';

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
    return BlocProvider(
      create: (context) => getIt<DictionaryBloc>()..add(DictionaryEventStart()),
      child: widget.args.searchInJisho
          ? _body()
          : KPScaffold(
              setGestureDetector: false,
              appBarTitle: widget.args.searchInJisho
                  ? "dict_title".tr()
                  : 'dict_add_word_title'.tr(),
              child: _body(),
            ),
    );
  }

  Widget _body() {
    final canSearchEitherWay = canSearch ||
        _searchBarTextController.text != "" ||
        _searchBarTextController.text.isNotEmpty;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _searchBar()),
            _searchWidget(canSearchEitherWay)
          ],
        ),
        BlocBuilder<DictionaryBloc, DictionaryState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(KPMargins.margin16),
                  child: KPProgressIndicator(),
                ),
              ),
              loaded: (predictions) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: KPMargins.margin8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "< ${"dict_predictions_most_likely".tr()}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${"dict_predictions_less_likely".tr()} >",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        )
                      ],
                    ),
                  ),
                  _predictions(predictions),
                  KPCustomCanvas(
                    line: _line,
                    allowPrediction: true,
                    handleImage: (im.Image image) {
                      context
                          .read<DictionaryBloc>()
                          .add(DictionaryEventLoading(image: image));
                    },
                  ),
                ],
              ),
              error: () => Center(
                  child: Padding(
                padding: const EdgeInsets.all(KPMargins.margin16),
                child: Text("dict_model_not_loaded".tr(),
                    style: Theme.of(context).textTheme.bodyMedium),
              )),
              orElse: () => const SizedBox(),
            );
          },
        ),
      ],
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

  Widget _searchWidget(bool canSearchEitherWay) {
    return GestureDetector(
      child: AnimatedContainer(
        width: canSearchEitherWay ? KPSizes.defaultSizeSearchBarIcons : 0,
        height: KPSizes.defaultSizeSearchBarIcons,
        duration: const Duration(milliseconds: 400),
        margin: EdgeInsets.symmetric(
          horizontal: canSearchEitherWay ? KPMargins.margin8 : 0,
          vertical: KPMargins.margin4,
        ),
        decoration: const BoxDecoration(
            shape: BoxShape.circle, color: KPColors.secondaryColor),
        child: Icon(
          widget.args.searchInJisho ? Icons.search : Icons.done,
          color: KPColors.primaryLight,
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
                    word: text, fromDictionary: true));
          } else {
            Navigator.of(context).pop(text);
          }
        } else {
          Utils.getSnackBar(context, "dict_search_empty".tr());
        }
      },
    );
  }

  SizedBox _predictions(List<Category> predictions) {
    return SizedBox(
      height: KPSizes.defaultSizeFiltersList,
      child: ListView.builder(
        itemCount: predictions.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final String word = predictions[index].label.substring(0, 1);
          final double score = predictions[index].score;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: KPMargins.margin2),
            child: ActionChip(
                label: Text(
                  word,
                  style: TextStyle(
                      fontSize: KPFontSizes.fontSize18,
                      color: Utils.getTextColorBasedOnScore(score)),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: KPMargins.margin8),
                backgroundColor: Utils.getColorBasedOnScore(score),
                pressElevation: KPMargins.margin2,
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  _searchBarTextController.text += word;
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
