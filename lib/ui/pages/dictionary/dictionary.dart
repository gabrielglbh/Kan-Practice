import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as im;
import 'package:kanpractice/core/routing/pages.dart';
import 'package:kanpractice/ui/pages/dictionary/bloc/dict_bloc.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/CustomButton.dart';
import 'package:kanpractice/ui/widgets/CustomSearchBar.dart';
import 'package:kanpractice/ui/widgets/canvas/CustomCanvas.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({Key? key}) : super(key: key);

  @override
  _DictionaryPageState createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  /// Current drawn line in the canvas
  List<Offset?> _line = [];
  DictBloc _bloc = DictBloc();

  FocusNode? _searchBarFn;

  @override
  void initState() {
    _searchBarFn = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _searchBarFn?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: CustomSizes.appBarHeight,
        title: FittedBox(fit: BoxFit.fitWidth, child: Text("Kanji Dictionary")),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // TODO: Abstract text controller to the caller
          CustomSearchBar(
            hint: "Search or draw a kanji",
            focus: _searchBarFn,
            onQuery: (String query) {

            },
            onExitSearch: () {},
          ),
          BlocProvider<DictBloc>(
            create: (_) => _bloc..add(DictEventIdle()),
            child: BlocBuilder<DictBloc, DictState>(
              builder: (context, state) {
                if (state is  DictStateFailure) {
                  return Container();
                } else if (state is DictStateLoading) {
                  return Container();
                } else if (state is DictStateLoaded)
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
          CustomButton(
            width: MediaQuery.of(context).size.width / 3,
            onTap: () {
              // Navigator.of(context).pushNamed(
              //    KanPracticePages.jishoPage, arguments: kanji)
            },
            title2: 'Search',
          )
        ],
      )
    );
  }

  Container _predictions(DictStateLoaded state) {
    return Container(
      height: CustomSizes.defaultSizeFiltersList,
      padding: EdgeInsets.only(bottom: Margins.margin8,
          left: Margins.margin8, right: Margins.margin8),
      child: ListView.builder(
        itemCount: state.predictions.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final String kanji = state.predictions[index].substring(0, 1);
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: Margins.margin2),
            child: ActionChip(
              label: Text(kanji, style: TextStyle(fontSize: FontSizes.fontSize18)),
              padding: EdgeInsets.symmetric(horizontal: Margins.margin8),
              onPressed: () {
                // TODO: On tap, add the kanji to the textController of the searchBar
              },
            ),
          );
        }
      )
    );
  }
}
