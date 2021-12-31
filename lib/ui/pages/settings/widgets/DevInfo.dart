import 'package:flutter/material.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/DragContainer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class DevInfo extends StatelessWidget {
  const DevInfo();

  static Future<void> callModalSheet(BuildContext context) async {
    await showModalBottomSheet(context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      builder: (context) => DevInfo()
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () => {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
          topRight: Radius.circular(CustomRadius.radius16), topLeft: Radius.circular(CustomRadius.radius16))
      ),
      builder: (context) {
        return Wrap(
          children: [
            Padding(
              padding: EdgeInsets.all(Margins.margin8),
              child: Column(
                children: [
                  DragContainer(),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: Margins.margin8),
                      child: Text("developer_info_label".tr(), textAlign: TextAlign.center,
                        style: TextStyle(fontSize: FontSizes.fontSize24, fontWeight: FontWeight.bold)),
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
        ListTile(
          title: Text("Gabriel García"),
          leading: Icon(Icons.handyman),
        ),
        ListTile(
          title: Text("developer_info_follow".tr()),
          leading: Icon(Icons.developer_mode_rounded),
          onTap: () async => await launch("https://github.com/gabrielglbh"),
          trailing: Icon(Icons.link),
        ),
        ListTile(
          title: Text("developer_info_github_issue".tr()),
          leading: Icon(Icons.bug_report_outlined),
          onTap: () async => await launch("https://github.com/gabrielglbh/Kan-Practice/issues/new"),
          trailing: Icon(Icons.link),
        ),
        ListTile(
          title: Text("${"developer_info_report".tr()} devgglop@gmail.com"),
          leading: Icon(Icons.bug_report_rounded),
          onTap: () async {
            final Uri _emailLaunchUri = Uri(
              scheme: 'mailto',
              path: 'devgglop@gmail.com',
              queryParameters: {
                'subject': "Found a bug on KanPractice!",
              }
            );
            String url = _emailLaunchUri.toString().replaceAll("+", "%20");
            if (await canLaunch(url)) await launch(url);
            else GeneralUtils.getSnackBar(context, "launch_url_failed".tr());
          },
          trailing: Icon(Icons.mail_outline_rounded),
        ),
      ],
    );
  }
}
