import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/widgets/kp_markdown.dart';
import 'package:kanpractice/presentation/store_page/widgets/image_container.dart';

class ContextCarousel extends StatelessWidget {
  final String locale;
  const ContextCarousel({super.key, required this.locale});

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
              const Icon(Icons.psychology_outlined, size: 32),
              const SizedBox(width: KPMargins.margin12),
              Flexible(
                child: Text(
                  "provide_context".tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
          const SizedBox(height: KPMargins.margin12),
          KPMarkdown(
            data: "pro_context"
                .tr()
                .replaceAll('ChatGPT', '**ChatGPT**')
                .replaceAll('context', '**context**'),
            shrinkWrap: true,
          ),
          const SizedBox(height: KPMargins.margin12),
          ImageContainer(image: '$locale/context.png'),
          const SizedBox(height: KPMargins.margin4),
          const Icon(Icons.arrow_downward_rounded, size: 32),
          const SizedBox(height: KPMargins.margin4),
          const ImageContainer(image: 'context_resolved.png'),
        ],
      ),
    );
  }
}
