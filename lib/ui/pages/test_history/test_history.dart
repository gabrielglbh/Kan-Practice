import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/database/models/test_result.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/core/utils/study_modes/mode_arguments.dart';
import 'package:kanpractice/ui/pages/test_history/bloc/test_bloc.dart';
import 'package:kanpractice/ui/theme/theme_consts.dart';
import 'package:kanpractice/ui/widgets/CustomAlertDialog.dart';
import 'package:kanpractice/ui/widgets/EmptyList.dart';
import 'package:kanpractice/ui/widgets/ProgressIndicator.dart';
import 'package:kanpractice/ui/widgets/WinRateChart.dart';

class TestHistory extends StatefulWidget {
  const TestHistory({Key? key}) : super(key: key);

  @override
  _TestHistoryState createState() => _TestHistoryState();
}

class _TestHistoryState extends State<TestHistory> {
  final TestListBloc _bloc = TestListBloc();

  _showRemoveTestsDialog() {
    showDialog(
      context: context,
      builder: (context) => CustomDialog(
        title: Text("Removing All Tests"),
        content: Text("All tests saved on this device will be removed. "
            "This action cannot be undone. Do you want to proceed?"),
        positiveButtonText: "Remove",
        onPositive: () => _bloc..add(TestListEventRemoving()),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: appBarHeight,
        title: Text("Test History"),
        actions: [
          IconButton(
            icon: Icon(Icons.clear_all_rounded),
            onPressed: () => _showRemoveTestsDialog(),
          )
        ],
      ),
      body: BlocProvider<TestListBloc>(
        create: (_) => _bloc..add(TestListEventLoading()),
        child: BlocBuilder<TestListBloc, TestListState>(
          builder: (context, state) => _body(state)
        )
      ),
    );
  }

  _body(TestListState state) {
    if (state is TestListStateFailure)
      return EmptyList(message: "Failed to retrieve tests");
    else if (state is TestListStateLoading)
      return CustomProgressIndicator();
    else if (state is TestListStateLoaded) {
      if (state.list.isEmpty) return EmptyList(message: "No available tests.");
      return _testList(state);
    }
    else return Container();
  }

  _testList(TestListStateLoaded state) {
    return ListView.builder(
      key: PageStorageKey<String>('testListController'),
      itemCount: state.list.length,
      itemBuilder: (context, k) {
        Test t = state.list[k];
        Color chartColor = secondaryColor;

        if (t.studyMode == StudyModes.writing.mode) chartColor = StudyModes.writing.color;
        else if (t.studyMode == StudyModes.reading.mode) chartColor = StudyModes.reading.color;
        else if (t.studyMode == StudyModes.recognition.mode) chartColor = StudyModes.recognition.color;

        return Card(
          margin: EdgeInsets.all(8),
          elevation: 8,
          child: ListTile(
            contentPadding: EdgeInsets.all(8),
            onTap: () {},
            title: Text(t.kanjiLists, overflow: TextOverflow.ellipsis),
            subtitle: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${t.studyMode} • "),
                Text("Test taken ${GeneralUtils.parseDateMilliseconds(t.takenDate)}",
                  style: TextStyle(fontStyle: FontStyle.italic))
              ],
            ),
            trailing: WinRateChart(title: "", winRate: t.testScore,
                rateSize: 10, chartColor: chartColor),
          ),
        );
      }
    );
  }
}
