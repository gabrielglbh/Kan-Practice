import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/widgets/kp_markdown.dart';
import 'package:kanpractice/presentation/store_page/widgets/image_container.dart';

class TranslationCarousel extends StatelessWidget {
  final String locale;
  const TranslationCarousel({super.key, required this.locale});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KPMargins.margin8),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.travel_explore_rounded, size: 32),
              const SizedBox(width: KPMargins.margin12),
              Flexible(
                child: Text(
                  "test_mode_translation".tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
          const SizedBox(height: KPMargins.margin12),
          KPMarkdown(
            data: "pro_translation"
                .tr()
                .replaceAll('ChatGPT', '**ChatGPT**')
                .replaceAll('ML', '**ML**')
                .replaceAll('Google', '**Google**')
                .replaceAll('Kit', '**Kit**'),
            shrinkWrap: true,
          ),
          const SizedBox(height: KPMargins.margin12),
          const ImageContainer(image: 'translation_basic.png'),
          const SizedBox(height: KPMargins.margin4),
          const Icon(Icons.arrow_downward_rounded, size: 32),
          const SizedBox(height: KPMargins.margin4),
          ImageContainer(image: '$locale/translation_resolved.png'),
        ],
      ),
    );
  }
}
