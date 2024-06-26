import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class KPCachedNetworkImage extends StatelessWidget {
  final String url;
  final String errorMessage;
  const KPCachedNetworkImage({
    super.key,
    required this.url,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: url,
        placeholder: (context, _) => const KPProgressIndicator(),
        fadeInDuration: const Duration(milliseconds: 200),
        fadeOutDuration: const Duration(milliseconds: 200),
        errorWidget: (context, error, _) => Center(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: KPMargins.margin8),
                  child: Text(errorMessage)),
            ));
  }
}
