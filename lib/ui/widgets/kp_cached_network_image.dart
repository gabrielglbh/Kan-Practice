import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/kp_progress_indicator.dart';

class KPCachedNetworkImage extends StatelessWidget {
  final String url;
  final String errorMessage;
  const KPCachedNetworkImage({
    Key? key,
    required this.url,
    required this.errorMessage
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: url,
        placeholder: (context, _) => const KPProgressIndicator(),
        fadeInDuration: const Duration(milliseconds: 200),
        fadeOutDuration: const Duration(milliseconds: 200),
        errorWidget: (context, error, _) => Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Margins.margin8),
            child: Text(errorMessage)
          ),
        )
    );
  }
}
