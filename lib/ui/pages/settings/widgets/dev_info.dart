import 'package:flutter/material.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/kp_drag_container.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class DevInfo extends StatelessWidget {
  const DevInfo({Key? key}) : super(key: key);

  static Future<void> callModalSheet(BuildContext context) async {
    await showModalBottomSheet(context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      builder: (context) => const DevInfo()
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () => {},
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
          topRight: Radius.circular(CustomRadius.radius16),
          topLeft: Radius.circular(CustomRadius.radius16)
      )),
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
                      padding: const EdgeInsets.only(bottom: Margins.margin8),
                      child: Text("developer_info_label".tr(), textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5),
                    )
                  ),
                  _developer(context)
                ],
              ),
            ),
          ],
        );
      }
    );
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
          leading: const Icon(Icons.developer_mode_rounded),
          onTap: () async => await launch("https://github.com/gabrielglbh"),
          trailing: const Icon(Icons.link),
        ),
        ListTile(
          title: Text("developer_info_github_issue".tr()),
          leading: const Icon(Icons.bug_report_outlined),
          onTap: () async => await launch("https://github.com/gabrielglbh/Kan-Practice/issues/new"),
          trailing: const Icon(Icons.link),
        ),
        ListTile(
          title: Text("${"developer_info_report".tr()} devgglop@gmail.com"),
          leading: const Icon(Icons.bug_report_rounded),
          onTap: () async {
            final Uri _emailLaunchUri = Uri(
              scheme: 'mailto',
              path: 'devgglop@gmail.com',
              queryParameters: {
                'subject': "Found a bug on KanPractice!",
              }
            );
            String url = _emailLaunchUri.toString().replaceAll("+", "%20");
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              GeneralUtils.getSnackBar(context, "launch_url_failed".tr());
            }
          },
          trailing: const Icon(Icons.mail_outline_rounded),
        ),
      ],
    );
  }
}
