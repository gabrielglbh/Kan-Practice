import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/widgets/kp_markdown.dart';
import 'package:kanpractice/presentation/store_page/widgets/image_container.dart';

class MarketCarousel extends StatelessWidget {
  final String locale;
  const MarketCarousel({super.key, required this.locale});

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
              Icon(Icons.g_translate_rounded,
                  color: Colors.amber.shade800, size: 32),
              const SizedBox(width: KPMargins.margin12),
              Flexible(
                child: Text(
                  "market_automatic_translation".tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
          const SizedBox(height: KPMargins.margin12),
          KPMarkdown(
            data: "pro_translation_market"
                .tr()
                .replaceAll('ML', '**ML**')
                .replaceAll('Kit', '**Kit**')
                .replaceAll('Google', '**Google**'),
            shrinkWrap: true,
          ),
          const SizedBox(height: KPMargins.margin12),
          ImageContainer(image: '$locale/market.png'),
        ],
      ),
    );
  }
}
