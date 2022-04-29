import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/ui/general_utils.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/kp_drag_container.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class CopyrightInfo extends StatelessWidget {
  const CopyrightInfo({Key? key}) : super(key: key);

  static Future<void> callModalSheet(BuildContext context) async {
    await showModalBottomSheet(context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        isDismissible: true,
        builder: (context) => const CopyrightInfo()
    );
  }

  Future<void> _launchUrl(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      GeneralUtils.getSnackBar(context, "launch_url_failed".tr());
    }
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
                        child: Text("settings_information_about_label".tr(), textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline5),
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: Margins.margin8),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(text: "“ETL Character Database” is a collection of "
                                "images of about 1.2 million hand-written and machine-printed "
                                "numerals, symbols, Latin alphabets and Japanese characters "
                                "and compiled in 9 datasets (ETL-1 to ETL-9). This database "
                                "has been collected by Electrotechnical Laboratory (currently "
                                "reorganized as the ", style: Theme.of(context).textTheme.bodyText2),
                            TextSpan(
                              text: "National Institute of Advanced Industrial Science and Technology (AIST)",
                              style: Theme.of(context).textTheme.overline,
                              recognizer: TapGestureRecognizer()..onTap = () async {
                                await _launchUrl(context, "https://www.aist.go.jp/index_e.html");
                              },
                            ),
                            TextSpan(text: " under the cooperation with Japan Electronic "
                                "Industry Developement Association (currently reorganized as ",
                              style: Theme.of(context).textTheme.bodyText2),
                            TextSpan(
                              text: "Japan Electronics and Information Technology Industries Association",
                              style: Theme.of(context).textTheme.overline,
                              recognizer: TapGestureRecognizer()..onTap = () async {
                                await _launchUrl(context, "https://www.jeita.or.jp/english/");
                              },
                            ),
                            TextSpan(text: "), universities and other research "
                                "organizations for character recognition researches "
                                "from 1973 to 1984.",
                              style: Theme.of(context).textTheme.bodyText2),
                          ]
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: Margins.margin16),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "About the ETL Character Database",
                              style: Theme.of(context).textTheme.overline,
                              recognizer: TapGestureRecognizer()..onTap = () async {
                                await _launchUrl(context, "http://etlcdb.db.aist.go.jp/");
                              },
                            ),
                            TextSpan(text: ". From all the 9 datasets, the one used "
                                "in this app is ",
                                style: Theme.of(context).textTheme.bodyText2),
                            TextSpan(
                              text: "ETL-9.",
                              style: Theme.of(context).textTheme.overline,
                              recognizer: TapGestureRecognizer()..onTap = () async {
                                await _launchUrl(context, "http://etlcdb.db.aist.go.jp/specification-of-etl-9");
                              },
                            ),
                          ]
                        ),
                      ),
                    ),
                    Container(margin: const EdgeInsets.only(bottom: Margins.margin32))
                  ],
                ),
              ),
            ]
          );
        }
    );
  }
}
