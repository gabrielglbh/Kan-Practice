import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/core/firebase/queries/back_ups.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:package_info_plus/package_info_plus.dart';

class UpdateContainer extends StatefulWidget {
  const UpdateContainer({Key? key}) : super(key: key);

  @override
  State<UpdateContainer> createState() => _UpdateContainerState();
}

class _UpdateContainerState extends State<UpdateContainer> {
  String _newVersion = "";

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await _getVersionNotice();
    });
    super.initState();
  }

  Future<void> _getVersionNotice() async {
    String v = await BackUpRecords.instance.getVersion();
    PackageInfo pi = await PackageInfo.fromPlatform();
    if (v != pi.version && v != "") setState(() => _newVersion = v);
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _newVersion.isNotEmpty,
      child: GestureDetector(
        onTap: () async => await GeneralUtils.showVersionNotes(context, version: _newVersion),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(CustomRadius.radius16),
              color: CustomColors.getSecondaryColor(context)
          ),
          padding: const EdgeInsets.symmetric(vertical: Margins.margin8),
          margin: const EdgeInsets.only(bottom: Margins.margin8, right: Margins.margin8, left: Margins.margin8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Margins.margin16),
                child: Text("kanji_lists_newUpdateAvailable_label".tr(), style: Theme.of(context)
                    .textTheme.headline5?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.white
                )),
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: Margins.margin16),
                  child: Icon(Icons.system_update, color: Colors.white)
              )
            ],
          ),
        )
      ),
    );
  }
}
