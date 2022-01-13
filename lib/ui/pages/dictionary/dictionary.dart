import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as im;
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/ui/pages/dictionary/arguments.dart';
import 'package:kanpractice/ui/pages/dictionary/bloc/dict_bloc.dart';
import 'package:kanpractice/ui/pages/dictionary/widgets/KanjiSearchBar.dart';
import 'package:kanpractice/ui/pages/jisho/arguments.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/CustomAlertDialog.dart';
import 'package:kanpractice/ui/widgets/ProgressIndicator.dart';
import 'package:kanpractice/ui/widgets/canvas/CustomCanvas.dart';
import 'package:easy_localization/easy_localization.dart';

class DictionaryPage extends StatefulWidget {
  final DictionaryArguments args;
  const DictionaryPage({required this.args});

  @override
  _DictionaryPageState createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  final DictBloc _bloc = DictBloc();

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
    _bloc.close();
    super.dispose();
  }

  _showDisclaimerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          title: Center(child: Icon(Icons.warning_amber_rounded)),
          content: Text("dict_predictions_disclaimer".tr()),
          positiveButtonText: "Ok",
          negativeButton: false,
          onPositive: () {}
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: CustomSizes.appBarHeight,
        title: FittedBox(fit: BoxFit.fitWidth, child: Text(
          widget.args.searchInJisho ? "dict_title".tr() : 'dict_add_kanji_title'.tr()
        )),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _showDisclaimerDialog(),
            icon: Icon(Icons.info_outline_rounded)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: KanjiSearchBar(
                    hint: widget.args.searchInJisho
                        ? "dict_search_bar_hint".tr() : "add_kanji_textForm_kanji_ext".tr(),
                    controller: _searchBarTextController,
                    onClear: () => setState(() => _searchBarTextController?.clear()),
                    onRemoveLast: () {
                      String? text = _searchBarTextController?.text;
                      if (text != null && text.length >= 1)
                        setState(() {
                          _searchBarTextController?.text = text.substring(0, text.length - 1);
                        });
                    }
                  ),
                ),
                GestureDetector(
                  child: AnimatedContainer(
                    width: _searchBarTextController?.text != ""
                        || _searchBarTextController?.text.isNotEmpty == true
                        ? CustomSizes.defaultSizeSearchBarIcons : 0,
                    height: CustomSizes.defaultSizeSearchBarIcons,
                    duration: Duration(milliseconds: 400),
                    margin: EdgeInsets.symmetric(horizontal:
                        _searchBarTextController?.text != "" ||
                        _searchBarTextController?.text.isNotEmpty == true
                            ? Margins.margin8 : 0),
                    decoration: BoxDecoration(
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
                    } else
                      GeneralUtils.getSnackBar(context, "dict_search_empty".tr());
                  },
                ),
              ],
            ),
            BlocProvider<DictBloc>(
              create: (_) => _bloc..add(DictEventIdle()),
              child: BlocBuilder<DictBloc, DictState>(
                builder: (context, state) {
                  if (state is DictStateLoading)
                    return Center(child: Padding(
                      padding: EdgeInsets.all(Margins.margin16),
                      child: CustomProgressIndicator(),
                    ));
                  else if (state is DictStateFailure)
                    return Center(child: Padding(
                      padding: EdgeInsets.all(Margins.margin16),
                      child: Text("dict_model_not_loaded".tr()),
                    ));
                  else if (state is DictStateLoaded)
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: Margins.margin16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Text("< ${"dict_predictions_most_likely".tr()}",
                                  maxLines: 1, overflow: TextOverflow.ellipsis
                              )),
                              Expanded(child: Text("${"dict_predictions_less_likely".tr()} >",
                                maxLines: 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.end,
                              ))
                            ],
                          ),
                        ),
                        _predictions(state),
                        CustomCanvas(
                          line: _line,
                          allowPrediction: true,
                          handleImage: (im.Image image) {
                            _bloc..add(DictEventLoading(image: image));
                          },
                        ),
                      ],
                    );
                  else
                    return Container();
                },
              ),
            ),
          ],
        ),
      )
    );
  }

  Container _predictions(DictStateLoaded state) {
    return Container(
      height: CustomSizes.defaultSizeFiltersList,
      padding: EdgeInsets.only(left: Margins.margin8, right: Margins.margin8),
      child: ListView.builder(
        itemCount: state.predictions.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final String kanji = state.predictions[index].label.substring(0, 1);
          final double score = state.predictions[index].score;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: Margins.margin2),
            child: ActionChip(
              label: Text(kanji, style: TextStyle(fontSize: FontSizes.fontSize18,
                color: GeneralUtils.getTextColorBasedOnScore(score))),
              padding: EdgeInsets.symmetric(horizontal: Margins.margin8),
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
