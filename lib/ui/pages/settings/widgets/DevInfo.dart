import 'package:flutter/gestures.dart';
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
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.handyman),
            Padding(
              padding: EdgeInsets.only(left: Margins.margin16, top: Margins.margin16, bottom: Margins.margin16),
              child: Text("Gabriel García", style: TextStyle(fontSize: FontSizes.fontSize14)),
            )
          ],
        ),
        InkWell(
          onTap: () {launch("https://github.com/gabrielglbh");},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.developer_mode_rounded),
              Padding(
                padding: EdgeInsets.only(left: Margins.margin16, top: Margins.margin16, bottom: Margins.margin16),
                child: Text("developer_info_follow".tr(), style: TextStyle(fontSize: FontSizes.fontSize14)),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.bug_report),
            Padding(
              padding: EdgeInsets.only(left: Margins.margin16, top: Margins.margin16, bottom: Margins.margin16),
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: "developer_info_report".tr(), style: Theme.of(context).textTheme.bodyText2),
                      TextSpan(
                        text: " devgglop@gmail.com",
                        style: TextStyle(color: CustomColors.secondarySubtleColor,
                            decoration: TextDecoration.underline, fontSize: FontSizes.fontSize14
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
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
                      ),
                    ]
                  ),
                ),
              )
            )
          ],
        ),
      ],
    );
  }
}
