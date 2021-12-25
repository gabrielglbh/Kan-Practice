import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/DragContainer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class CopyrightInfo extends StatelessWidget {
  const CopyrightInfo();

  static Future<void> callModalSheet(BuildContext context) async {
    await showModalBottomSheet(context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        isDismissible: true,
        builder: (context) => CopyrightInfo()
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
                        child: Text("settings_information_about_label".tr(), textAlign: TextAlign.center,
                          style: TextStyle(fontSize: FontSizes.fontSize24, fontWeight: FontWeight.bold)),
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Margins.margin8),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(text: "This app uses the ", style: Theme.of(context).textTheme.bodyText2),
                            TextSpan(
                              text: "JMdict",
                              style: TextStyle(color: CustomColors.secondarySubtleColor,
                                  decoration: TextDecoration.underline, fontSize: FontSizes.fontSize14
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () async {
                                final jmdict = "http://www.edrdg.org/wiki/index.php/JMdict-EDICT_Dictionary_Project";
                                if (await canLaunch(jmdict)) await launch(jmdict);
                                else GeneralUtils.getSnackBar(context, "launch_url_failed".tr());
                              },
                            ),
                            TextSpan(text: " dictionary files. These files are the property of the ",
                              style: Theme.of(context).textTheme.bodyText2),
                            TextSpan(
                              text: "Electronic Dictionary Research and Development Group",
                              style: TextStyle(color: CustomColors.secondarySubtleColor,
                                decoration: TextDecoration.underline, fontSize: FontSizes.fontSize14
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () async {
                                final edrdg = "http://www.edrdg.org/";
                                if (await canLaunch(edrdg)) await launch(edrdg);
                                else GeneralUtils.getSnackBar(context, "launch_url_failed".tr());
                              },
                            ),
                            TextSpan(text: ", and are used in conformance with the Group's  ",
                              style: Theme.of(context).textTheme.bodyText2),
                            TextSpan(
                              text: "licence.",
                              style: TextStyle(color: CustomColors.secondarySubtleColor,
                                decoration: TextDecoration.underline, fontSize: FontSizes.fontSize14
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () async {
                                final license = "http://www.edrdg.org/edrdg/licence.html";
                                if (await canLaunch(license)) await launch(license);
                                else GeneralUtils.getSnackBar(context, "launch_url_failed".tr());
                              },
                            ),
                          ]
                        ),
                      ),
                    ),
                    Container(margin: EdgeInsets.only(bottom: Margins.margin32))
                  ],
                ),
              ),
            ]
          );
        }
    );
  }
}
