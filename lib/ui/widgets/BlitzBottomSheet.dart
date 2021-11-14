import 'package:flutter/material.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/ui/widgets/StudyMode.dart';
import 'package:kanpractice/ui/theme/theme_consts.dart';

class BlitzBottomSheet extends StatelessWidget {
  /// String defining if the user wants to perform a Blitz Test on a practice
  /// lesson specifically. If null, all kanji available will be taken into consideration.
  final String? practiceList;
  const BlitzBottomSheet({this.practiceList});

  /// Creates and calls the [BottomSheet] with the content for a blitz test
  static Future<String?> callBlitzModeBottomSheet(BuildContext context, {String? practiceList}) async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlitzBottomSheet(practiceList: practiceList)
    );
  }

  Future<List<Kanji>> _loadBlitzTest() async {
    String? listName = practiceList;
    /// Get all the list of all kanji and perform a 20 kanji random sublist
    if (listName == null) {
      List<Kanji> list = await KanjiQueries.instance.getAllKanji();
      list.shuffle();
      return list.sublist(0, list.length < numberOfKanjiInTest
          ? list.length : numberOfKanjiInTest);
    }
    /// If the listName is not empty, it means that the user wants to have
    /// a Blitz Test on a certain KanList defined in "listName"
    else {
      List<Kanji> list = await KanjiQueries.instance.getAllKanjiFromList(listName);
      list.shuffle();
      return list.sublist(0, list.length < numberOfKanjiInTest
          ? list.length : numberOfKanjiInTest);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
        return Container(
          height: bottomSheetHeight,
          margin: EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _dragContainer(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                child: Text("Make a blitz test", textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                child: Text("30 random kanji will be selected. Let's take the blitz test!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              Expanded(
                child: FutureBuilder<List<Kanji>>(
                  future: _loadBlitzTest(),
                  builder: (context, snapshot) {
                    return TestStudyMode(
                      listsNames: practiceList == null ? 'Blitz' : 'Blitz on $practiceList',
                      list: (snapshot.data ?? []),
                    );
                  },
                )
              )
            ],
          ),
        );
      },
    );
  }

  Align _dragContainer() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 90, height: 5,
        margin: EdgeInsets.only(bottom: 8, top: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.grey
        ),
      ),
    );
  }
}