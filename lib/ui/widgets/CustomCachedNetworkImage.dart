import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/ProgressIndicator.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String url;
  final String errorMessage;
  const CustomCachedNetworkImage({required this.url, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: url,
        placeholder: (context, _) => CustomProgressIndicator(),
        fadeInDuration: Duration(milliseconds: 200),
        fadeOutDuration: Duration(milliseconds: 200),
        errorWidget: (context, error, _) => Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Margins.margin8),
            child: Text(errorMessage)
          ),
        )
    );
  }
}
