import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/core/types/study_modes_filters.dart';
import 'package:kanpractice/core/types/test_modes_filters.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/ui/pages/statistics/tab/test_history/test_history.dart';
import 'package:kanpractice/ui/widgets/kp_button.dart';
import 'package:kanpractice/ui/widgets/kp_scaffold.dart';

class TestHistoryFilters extends StatefulWidget {
  final TestHistoryArgs data;
  const TestHistoryFilters({super.key, required this.data});

  @override
  State<TestHistoryFilters> createState() => _TestHistoryFiltersState();
}

class _TestHistoryFiltersState extends State<TestHistoryFilters> {
  late DateTime _firstDate, _lastDate;
  TestFilters _testsFilter = TestFilters.all;
  StudyModeFilters _modesFilter = StudyModeFilters.all;

  String _parseDate(DateTime i, DateTime l) {
    final format = DateFormat('dd MMM yyyy');
    final initial = format.format(i);
    final last = format.format(l);
    return "$initial - $last";
  }

  @override
  void initState() {
    _firstDate = widget.data.firstDate;
    _lastDate = widget.data.lastDate;
    _testsFilter = widget.data.testFilters;
    _modesFilter = widget.data.modeFilters;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const icon = Icon(Icons.expand_more_rounded);
    return KPScaffold(
      appBarTitle: "history_tests_filter".tr(),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: Margins.margin24,
          left: Margins.margin12,
          right: Margins.margin12,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: Text("filter_select_dates_label".tr(),
                        style: Theme.of(context).textTheme.headline6),
                    contentPadding: const EdgeInsets.all(0),
                    trailing: Text(
                      _parseDate(_firstDate, _lastDate),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    onTap: () async {
                      DateTimeRange? range =
                          await GeneralUtils.showRangeTimeDialog(
                              context, _firstDate, _lastDate);
                      setState(() {
                        _firstDate = range?.start ?? _firstDate;
                        _lastDate = range?.end
                                .add(const Duration(hours: 23, minutes: 59)) ??
                            _lastDate;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: Margins.margin8,
                      bottom: Margins.margin8,
                      right: Margins.margin8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: Margins.margin16),
                            child: Text("filter_select_test_type_label".tr(),
                                style: Theme.of(context).textTheme.headline6),
                          ),
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            icon: icon,
                            value: _testsFilter.nameAbbr,
                            items: TestFilters.values
                                .map((filter) => DropdownMenuItem(
                                    value: filter.nameAbbr,
                                    child: Row(
                                      children: [
                                        Icon(filter.icon),
                                        const SizedBox(width: 8),
                                        Text(filter.nameAbbr),
                                      ],
                                    )))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _testsFilter = TestFilters.values.firstWhere(
                                    (e) => e.nameAbbr == value,
                                    orElse: () => TestFilters.all);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: Margins.margin8,
                      bottom: Margins.margin8,
                      right: Margins.margin8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: Margins.margin16),
                            child: Text("filter_select_study_mode_label".tr(),
                                style: Theme.of(context).textTheme.headline6),
                          ),
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            icon: icon,
                            value: _modesFilter.mode,
                            items: StudyModeFilters.values
                                .map((mode) => DropdownMenuItem(
                                    value: mode.mode,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: Margins.margin16,
                                          height: Margins.margin16,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: mode.color,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(mode.mode),
                                      ],
                                    )))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _modesFilter = StudyModeFilters.values
                                    .firstWhere((e) => e.mode == value,
                                        orElse: () => StudyModeFilters.all);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            KPButton(
              title2: 'filter_apply'.tr(),
              onTap: () {
                Navigator.of(context).pop(TestHistoryArgs(
                  _firstDate,
                  _lastDate,
                  _testsFilter,
                  _modesFilter,
                ));
              },
            )
          ],
        ),
      ),
    );
  }
}
