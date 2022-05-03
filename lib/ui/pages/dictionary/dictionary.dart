import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as im;
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/ui/pages/dictionary/arguments.dart';
import 'package:kanpractice/ui/pages/dictionary/bloc/dict_bloc.dart';
import 'package:kanpractice/ui/pages/dictionary/widgets/kanji_search_bar.dart';
import 'package:kanpractice/ui/pages/jisho/arguments.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/widgets/kp_alert_dialog.dart';
import 'package:kanpractice/ui/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/ui/widgets/canvas/kp_custom_canvas.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/ui/widgets/kp_scaffold.dart';

class DictionaryPage extends StatefulWidget {
  final DictionaryArguments args;
  const DictionaryPage({
    Key? key,
    required this.args
  }) : super(key: key);

  @override
  _DictionaryPageState createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  /// Current drawn line in the canvas
  List<Offset?> _line = [];

  TextEditingController? _searchBarTextController;

  @override
  void initState() {
    _searchBarTextController = TextEditingController();
    String? word = widget.args.word;
    if (word != null) _searchBarTextController?.text = word;
    super.initState();
  }

  @override
  void dispose() {
    _searchBarTextController?.dispose();
    super.dispose();
  }

  _showDisclaimerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return KPDialog(
          title: const Center(child: Icon(Icons.warning_amber_rounded)),
          content: Text("dict_predictions_disclaimer".tr(), style: Theme.of(context).textTheme.bodyText1),
          positiveButtonText: "Ok",
          negativeButton: false,
          onPositive: () {}
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return KPScaffold(
      appBarTitle: widget.args.searchInJisho ? "dict_title".tr() : 'dict_add_kanji_title'.tr(),
      appBarActions: [
        IconButton(
          onPressed: () => _showDisclaimerDialog(),
          icon: const Icon(Icons.info_outline_rounded)
        )
      ],
      centerTitle: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: KanjiSearchBar(
                    top: 0,
                    hint: widget.args.searchInJisho
                        ? "dict_search_bar_hint".tr() : "add_kanji_textForm_kanji_ext".tr(),
                    controller: _searchBarTextController,
                    onClear: () => setState(() => _searchBarTextController?.clear()),
                    onRemoveLast: () {
                      String? text = _searchBarTextController?.text;
                      if (text != null && text.isNotEmpty) {
                        setState(() {
                          _searchBarTextController?.text = text.substring(0, text.length - 1);
                        });
                      }
                    }
                  ),
                ),
                GestureDetector(
                  child: AnimatedContainer(
                    width: _searchBarTextController?.text != ""
                        || _searchBarTextController?.text.isNotEmpty == true
                        ? CustomSizes.defaultSizeSearchBarIcons : 0,
                    height: CustomSizes.defaultSizeSearchBarIcons,
                    duration: const Duration(milliseconds: 400),
                    margin: EdgeInsets.symmetric(horizontal:
                        _searchBarTextController?.text != "" ||
                        _searchBarTextController?.text.isNotEmpty == true
                            ? Margins.margin8 : 0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: CustomColors.secondaryColor
                    ),
                    child: Icon(
                      widget.args.searchInJisho ? Icons.search : Icons.done,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    String? text = _searchBarTextController?.text;
                    if (text != null && text.isNotEmpty) {
                      /// If the user is searching for words, redirect them to Jisho
                      /// If the user is adding words, pop and send the predicted word back
                      if (widget.args.searchInJisho) {
                        Navigator.of(context).pushNamed(KanPracticePages.jishoPage,
                            arguments: JishoArguments(kanji: text, fromDictionary: true));
                      } else {
                        Navigator.of(context).pop(text);
                      }
                    } else {
                      GeneralUtils.getSnackBar(context, "dict_search_empty".tr());
                    }
                  },
                ),
              ],
            ),
            BlocProvider<DictBloc>(
              create: (_) => DictBloc()..add(DictEventIdle()),
              child: BlocBuilder<DictBloc, DictState>(
                builder: (context, state) {
                  if (state is DictStateLoading) {
                    return const Center(child: Padding(
                      padding: EdgeInsets.all(Margins.margin16),
                      child: KPProgressIndicator(),
                    ));
                  } else if (state is DictStateFailure) {
                    return Center(child: Padding(
                      padding: const EdgeInsets.all(Margins.margin16),
                      child: Text("dict_model_not_loaded".tr(), style: Theme.of(context).textTheme.bodyText2),
                    ));
                  } else if (state is DictStateLoaded) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text("< ${"dict_predictions_most_likely".tr()}",
                                maxLines: 1, overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyText2
                            )),
                            Expanded(child: Text("${"dict_predictions_less_likely".tr()} >",
                              maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.end,
                                style: Theme.of(context).textTheme.bodyText2
                            ))
                          ],
                        ),
                        _predictions(state),
                        KPCustomCanvas(
                          line: _line,
                          allowPrediction: true,
                          handleImage: (im.Image image) {
                            context.read<DictBloc>().add(DictEventLoading(image: image));
                          },
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      )
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
              label: Text(kanji, style: TextStyle(fontSize: FontSizes.fontSize18,
                color: GeneralUtils.getTextColorBasedOnScore(score))),
              padding: const EdgeInsets.symmetric(horizontal: Margins.margin8),
              backgroundColor: GeneralUtils.getColorBasedOnScore(score),
              pressElevation: Margins.margin2,
              onPressed: () {
                _searchBarTextController?.text += kanji;
                setState(() => _line = []);
              }
            ),
          );
        }
      )
    );
  }
}
