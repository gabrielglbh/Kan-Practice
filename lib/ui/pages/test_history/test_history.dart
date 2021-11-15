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
import 'package:easy_localization/easy_localization.dart';

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
        title: Text("test_history_showRemoveTestsDialog_title".tr()),
        content: Text("test_history_showRemoveTestsDialog_content".tr()),
        positiveButtonText: "test_history_showRemoveTestsDialog_positive".tr(),
        onPositive: () => _bloc..add(TestListEventRemoving()),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: appBarHeight,
        title: Text("test_history_title".tr()),
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
      return EmptyList(message: "test_history_load_failed".tr());
    else if (state is TestListStateLoading)
      return CustomProgressIndicator();
    else if (state is TestListStateLoaded) {
      if (state.list.isEmpty) return EmptyList(message: "test_history_empty".tr());
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
                Text("${"test_history_testTaken".tr()} ${GeneralUtils.parseDateMilliseconds(context, t.takenDate)}",
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
