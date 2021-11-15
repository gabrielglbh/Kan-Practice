import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
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
          topRight: Radius.circular(18), topLeft: Radius.circular(18))
      ),
      builder: (context) {
        return Container(
          height: 256,
          margin: EdgeInsets.all(16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 90, height: 5,
                  margin: EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), color: Colors.grey[300]),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text("developer_info_label".tr(), textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                )
              ),
              Expanded(child: _developer(context))
            ],
          ),
        );
      }
    );
  }

  Scrollbar _developer(BuildContext context) {
    return Scrollbar(
      child: ListView(
        padding: EdgeInsets.only(top: 8),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.handyman),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16, bottom: 16),
                child: Text("Gabriel García", style: TextStyle(fontSize: 14)),
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
                  padding: EdgeInsets.only(left: 16, top: 16, bottom: 16),
                  child: Text("developer_info_follow".tr(), style: TextStyle(fontSize: 14)),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.bug_report),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16, bottom: 16),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: "developer_info_report".tr(), style: Theme.of(context).textTheme.bodyText2),
                        TextSpan(
                          text: " devgglop@gmail.com",
                          style: TextStyle(color: Colors.orange[400],
                              decoration: TextDecoration.underline, fontSize: 14
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
      ),
    );
  }
}
