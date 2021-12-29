import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as im;
import 'package:kanpractice/ui/pages/dictionary/bloc/dict_bloc.dart';
import 'package:kanpractice/ui/theme/consts.dart';
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
          CustomSearchBar(
            hint: "Search or draw a kanji",
            focus: _searchBarFn,
            bottom: Margins.margin32,
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
                } else if (state is DictStateLoaded) {
                  return Container();
                } else
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
      )
    );
  }
}
