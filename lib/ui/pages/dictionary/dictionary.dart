import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as im;
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/ui/pages/dictionary/bloc/dict_bloc.dart';
import 'package:kanpractice/ui/pages/dictionary/widgets/KanjiSearchBar.dart';
import 'package:kanpractice/ui/pages/jisho/arguments.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/CustomAlertDialog.dart';
import 'package:kanpractice/ui/widgets/CustomButton.dart';
import 'package:kanpractice/ui/widgets/canvas/CustomCanvas.dart';
import 'package:easy_localization/easy_localization.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({Key? key}) : super(key: key);

  @override
  _DictionaryPageState createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  /// Current drawn line in the canvas
  List<Offset?> _line = [];
  DictBloc _bloc = DictBloc();

  TextEditingController? _searchBarTextController;

  @override
  void initState() {
    _searchBarTextController = TextEditingController();
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
        title: FittedBox(fit: BoxFit.fitWidth, child: Text("dict_title".tr())),
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
            KanjiSearchBar(
              hint: "dict_search_bar_hint".tr(),
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
            Visibility(
              visible: _searchBarTextController?.text != ""
                  || _searchBarTextController?.text.isNotEmpty == true,
              child: CustomButton(
                width: true,
                onTap: () {
                  String? text = _searchBarTextController?.text;
                  if (text != null && text.isNotEmpty)
                    Navigator.of(context).pushNamed(KanPracticePages.jishoPage,
                        arguments: JishoArguments(kanji: text, fromDictionary: true));
                  else
                    GeneralUtils.getSnackBar(context, "dict_search_empty".tr());
                },
                title2: 'dict_search_button_title'.tr(),
              ),
            ),
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
            BlocProvider<DictBloc>(
              create: (_) => _bloc..add(DictEventIdle()),
              child: BlocBuilder<DictBloc, DictState>(
                builder: (context, state) {
                  if (state is  DictStateFailure || state is DictStateLoading)
                    return Container(height: CustomSizes.defaultSizeFiltersList);
                  else if (state is DictStateLoaded)
                    return _predictions(state);
                  else
                    return Container();
                },
              ),
            ),
            CustomCanvas(
              line: _line,
              allowPrediction: true,
              handleImage: (im.Image image) {
                _bloc..add(DictEventLoading(image: image));
              },
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
