import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/widgets/kp_markdown.dart';

class KPProPerks extends StatelessWidget {
  final bool showIsProSubtitle;
  final double proIconSize;
  final bool applyPaddings;
  const KPProPerks({
    super.key,
    this.showIsProSubtitle = true,
    this.applyPaddings = true,
    this.proIconSize = KPSizes.maxHeightValidationCircle,
  });

  @override
  Widget build(BuildContext context) {
    final dash = Padding(
      padding: const EdgeInsets.only(
        top: KPMargins.margin8,
        bottom: KPMargins.margin8,
        left: KPMargins.margin8,
      ),
      child: Text(
        '✅',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
    final theme = Theme.of(context).textTheme.bodyLarge;

    return Padding(
      padding: EdgeInsets.only(
        bottom: applyPaddings ? KPMargins.margin16 : 0,
        right: applyPaddings ? KPMargins.margin12 : 0,
        left: applyPaddings ? KPMargins.margin12 : 0,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_play_rounded,
              color: KPColors.getSecondaryColor(context),
              size: proIconSize,
            ),
            if (showIsProSubtitle)
              Padding(
                padding: const EdgeInsets.all(KPMargins.margin16),
                child: Text("already_pro".tr(),
                    textAlign: TextAlign.center, style: theme),
              ),
            const SizedBox(height: KPMargins.margin24),
            Flexible(
              child: ListView(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      dash,
                      const SizedBox(width: KPMargins.margin8),
                      Flexible(
                          child: KPMarkdown(
                        data: "updated_pro_translation"
                            .tr()
                            .replaceAll('ChatGPT', '**ChatGPT**')
                            .replaceAll('ML', '**ML**')
                            .replaceAll('Google', '**Google**')
                            .replaceAll('Kit', '**Kit**'),
                        shrinkWrap: true,
                      )),
                    ],
                  ),
                  const SizedBox(height: KPMargins.margin12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      dash,
                      const SizedBox(width: KPMargins.margin8),
                      Flexible(
                          child: KPMarkdown(
                        data: "updated_pro_ocr"
                            .tr()
                            .replaceAll('ML', '**ML**')
                            .replaceAll('Google', '**Google**')
                            .replaceAll('Kit', '**Kit**'),
                        shrinkWrap: true,
                      )),
                    ],
                  ),
                  const SizedBox(height: KPMargins.margin12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      dash,
                      const SizedBox(width: KPMargins.margin8),
                      Flexible(
                          child: KPMarkdown(
                        data: "updated_pro_context"
                            .tr()
                            .replaceAll('ChatGPT', '**ChatGPT**'),
                        shrinkWrap: true,
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
