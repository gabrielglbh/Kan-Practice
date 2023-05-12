import 'dart:io';
import 'dart:math';
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
  File? _image;

  @override
  Widget build(BuildContext context) {
    return BlocListener<OCRPageBloc, OCRPageState>(
      listener: (context, state) {
        setState(() {
          state.mapOrNull(
            imageLoaded: (i) {
              if (i.image != null) _image = i.image;
            },
            initial: (i) {
              _image = null;
            },
          );
        });
      },
      child: _image != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(KPRadius.radius24),
              child: FutureBuilder<ui.Image>(
                future: decodeImageFromList(_image!.readAsBytesSync()),
                builder: (context, snapshot) {
                  if (snapshot.data == null) return const SizedBox();
                  bool isHorizontalImage =
                      snapshot.data!.width > snapshot.data!.height;
                  return Transform.rotate(
                    angle: isHorizontalImage ? pi / 2 : 0,
                    child: Image.file(
                      File(_image!.path),
                      fit: BoxFit.contain,
                    ),
                  );
                },
              ),
            )
          : const SizedBox(),
    );
  }
}
