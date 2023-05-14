import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/widgets/kp_markdown.dart';
import 'package:kanpractice/presentation/store_page/widgets/image_container.dart';

class OCRCarousel extends StatelessWidget {
  final String locale;
  const OCRCarousel({super.key, required this.locale});

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
              ShaderMask(
                shaderCallback: (bounds) {
                  return const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blue,
                        Colors.green,
                        Colors.yellow,
                        Colors.red,
                        Colors.purple
                      ]).createShader(bounds);
                },
                child: const Icon(Icons.camera, color: Colors.white, size: 32),
              ),
              const SizedBox(width: KPMargins.margin12),
              Flexible(
                child: Text(
                  "ocr_scanner".tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
          const SizedBox(height: KPMargins.margin12),
          KPMarkdown(
            data: "pro_ocr"
                .tr()
                .replaceAll('Jisho', '**Jisho**')
                .replaceAll('Google', '**Google**'),
            shrinkWrap: true,
          ),
          const SizedBox(height: KPMargins.margin12),
          ImageContainer(
            image: '$locale/ocr_active.png',
            height: MediaQuery.of(context).size.height / 3,
          ),
          const SizedBox(height: KPMargins.margin4),
          const Icon(Icons.arrow_downward_rounded, size: 32),
          const SizedBox(height: KPMargins.margin4),
          ImageContainer(image: '$locale/ocr_jisho.png'),
        ],
      ),
    );
  }
}
