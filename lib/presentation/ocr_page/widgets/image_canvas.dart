import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/ocr_page/ocr_page_bloc.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class ImageCanvas extends StatefulWidget {
  const ImageCanvas({super.key});

  @override
  State<ImageCanvas> createState() => _ImageCanvasState();
}

class _ImageCanvasState extends State<ImageCanvas> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OCRPageBloc, OCRPageState>(
      builder: (context, state) {
        return state.maybeWhen(
          imageLoaded: (_, image) => _image(image!),
          translationLoaded: (_, image) => _image(image!),
          orElse: () => const SizedBox(),
        );
      },
    );
  }

  ClipRRect _image(File image) => ClipRRect(
        borderRadius: BorderRadius.circular(KPRadius.radius24),
        child: FutureBuilder<ui.Image>(
          future: decodeImageFromList(image.readAsBytesSync()),
          builder: (context, snapshot) {
            if (snapshot.data == null) return const SizedBox();
            return Image.file(
              image,
              fit: BoxFit.contain,
            );
          },
        ),
      );
}
