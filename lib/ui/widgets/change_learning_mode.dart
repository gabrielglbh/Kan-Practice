import 'package:flutter/material.dart';
import 'package:kanpractice/core/types/learning_mode.dart';
import 'package:kanpractice/ui/consts.dart';
import 'package:kanpractice/ui/widgets/kp_drag_container.dart';
import 'package:easy_localization/easy_localization.dart';

class ChangeLearningMode extends StatefulWidget {
  final LearningMode mode;
  const ChangeLearningMode({Key? key, required this.mode}) : super(key: key);

  static Future<LearningMode?> show(
      BuildContext context, LearningMode m) async {
    LearningMode? mode = m;
    await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            isDismissible: true,
            builder: (context) => ChangeLearningMode(mode: m))
        .then((value) => mode = value);
    return mode;
  }

  @override
  State<ChangeLearningMode> createState() => _ChangeLearningModeState();
}

class _ChangeLearningModeState extends State<ChangeLearningMode> {
  late LearningMode _mode;

  @override
  void initState() {
    _mode = widget.mode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        enableDrag: false,
        onClosing: () => {},
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(CustomRadius.radius16),
                topLeft: Radius.circular(CustomRadius.radius16))),
        builder: (context) {
          return Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(Margins.margin8),
                child: Column(
                  children: [
                    const KPDragContainer(),
                    Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(bottom: Margins.margin8),
                          child: Text("change_learning_mode_title".tr(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline5),
                        )),
                    _selection(context)
                  ],
                ),
              ),
            ],
          );
        });
  }

  _onTileSelected(LearningMode? val) {
    setState(() => _mode = val ?? LearningMode.spatial);
    Navigator.of(context).pop(_mode);
  }

  Widget _selection(BuildContext context) {
    return Column(
      children: [
        RadioListTile<LearningMode>(
            title: ListTile(
              title: Text(LearningMode.random.name),
              subtitle: Text(LearningMode.random.desc),
              contentPadding: EdgeInsets.zero,
              trailing: Icon(LearningMode.random.icon),
            ),
            value: LearningMode.random,
            groupValue: _mode,
            activeColor: CustomColors.secondaryColor,
            onChanged: _onTileSelected),
        RadioListTile<LearningMode>(
            title: ListTile(
              title: Text(LearningMode.spatial.name),
              subtitle: Text(LearningMode.spatial.desc),
              contentPadding: EdgeInsets.zero,
              trailing: Icon(LearningMode.spatial.icon),
            ),
            value: LearningMode.spatial,
            groupValue: _mode,
            activeColor: CustomColors.secondaryColor,
            onChanged: _onTileSelected),
        RadioListTile<LearningMode>(
            title: ListTile(
              title: Text(LearningMode.fifo.name),
              subtitle: Text(LearningMode.fifo.desc),
              contentPadding: EdgeInsets.zero,
              trailing: Icon(LearningMode.fifo.icon),
            ),
            value: LearningMode.fifo,
            groupValue: _mode,
            activeColor: CustomColors.secondaryColor,
            onChanged: _onTileSelected),
      ],
    );
  }
}
