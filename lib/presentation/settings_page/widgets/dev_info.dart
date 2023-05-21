import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kanpractice/presentation/core/widgets/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';

class DevInfo extends StatelessWidget {
  const DevInfo({Key? key}) : super(key: key);

  static Future<void> callModalSheet(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        isDismissible: true,
        builder: (context) => const DevInfo());
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        enableDrag: false,
        onClosing: () => {},
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(KPRadius.radius16),
                topLeft: Radius.circular(KPRadius.radius16))),
        builder: (context) {
          return Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(KPMargins.margin8),
                child: Column(
                  children: [
                    const KPDragContainer(),
                    Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(bottom: KPMargins.margin8),
                          child: Text("developer_info_label".tr(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineSmall),
                        )),
                    _developer(context)
                  ],
                ),
              ),
            ],
          );
        });
  }

  Column _developer(BuildContext context) {
    return Column(
      children: [
        const ListTile(
          title: Text("Gabriel García"),
          leading: Icon(Icons.handyman),
        ),
        ListTile(
          title: Text("developer_info_follow".tr()),
          leading: const Icon(FontAwesomeIcons.github),
          onTap: () async =>
              await Utils.launch(context, "https://github.com/gabrielglbh"),
          trailing: const Icon(Icons.open_in_new, size: 18),
        ),
        ListTile(
          title: Text("developer_info_github_issue".tr()),
          leading: const Icon(Icons.bug_report_outlined),
          onTap: () async => await Utils.launch(context,
              "https://github.com/gabrielglbh/Kan-Practice/issues/new"),
          trailing: const Icon(Icons.open_in_new, size: 18),
        ),
        ListTile(
          title: Text("${"developer_info_report".tr()} devgglop@gmail.com"),
          leading: const Icon(Icons.bug_report_rounded),
          onTap: () async {
            final Uri emailLaunchUri = Uri(
                scheme: 'mailto',
                path: 'devgglop@gmail.com',
                queryParameters: {
                  'subject': "Found a bug on KanPractice!",
                });
            String url = emailLaunchUri.toString().replaceAll("+", "%20");
            await Utils.launch(context, url);
          },
          trailing: const Icon(Icons.mail_outline_rounded, size: 18),
        ),
      ],
    );
  }
}
