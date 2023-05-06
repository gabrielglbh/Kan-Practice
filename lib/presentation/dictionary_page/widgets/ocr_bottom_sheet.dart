import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/application/permission_handler/permission_handler_bloc.dart';
import 'package:kanpractice/application/services/ocr_service.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/widgets/kp_button.dart';
import 'package:kanpractice/presentation/core/widgets/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import 'package:permission_handler/permission_handler.dart';

class OCRBottomSheet extends StatefulWidget {
  const OCRBottomSheet({Key? key}) : super(key: key);

  /// Creates and calls the [BottomSheet] with the content for a blitz test
  static Future<String?> show(BuildContext context) async {
    return await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const OCRBottomSheet());
  }

  @override
  State<OCRBottomSheet> createState() => _OCRBottomSheetState();
}

class _OCRBottomSheetState extends State<OCRBottomSheet> {
  File? _image;
  late ImagePicker _imagePicker;
  String? _ocrText;
  double get _maxImageHeight => MediaQuery.of(context).size.height / 2;
  double _bsHeight = KPMargins.margin64 * 2;

  @override
  void initState() {
    _imagePicker = ImagePicker();
    super.initState();
  }

  Future _pickImage(ImageSource source) async {
    InputImage? inputImage;
    final pickedFile = await _imagePicker.pickImage(source: source);
    if (!mounted) return;
    context.read<PermissionHandlerBloc>().add(PermissionHandlerEventIdle());

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _bsHeight =
            MediaQuery.of(context).size.height - (KPMargins.margin64 * 4);

        inputImage = InputImage.fromFilePath(pickedFile.path);
      }
    });

    if (inputImage != null) {
      final ocrText = await getIt<OCRService>().recognize(inputImage!);
      setState(() => _ocrText = ocrText);
    }
  }

  @override
  void dispose() {
    getIt<OCRService>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
        return Wrap(children: [
          BlocConsumer<PermissionHandlerBloc, PermissionHandlerState>(
            listener: (context, state) {
              state.mapOrNull(
                succeeded: (s) {
                  _pickImage(s.source);
                },
              );
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const KPDragContainer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: KPMargins.margin8,
                        horizontal: KPMargins.margin32),
                    child: Text(
                        _image == null
                            ? "ocr_picker_title".tr()
                            : "ocr_scanned".tr(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                  state.mapOrNull(
                        error: (_) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('ocr_permissions_denied'.tr()),
                            IconButton(
                                onPressed: () => openAppSettings(),
                                icon: const Icon(Icons.link_rounded))
                          ],
                        ),
                      ) ??
                      const SizedBox(),
                  const SizedBox(height: KPMargins.margin12),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: _bsHeight,
                    child: Stack(
                      children: [
                        if (_image != null)
                          _imageWidget()
                        else
                          _pickerSelection(),
                        if (_ocrText != null)
                          Padding(
                            padding: const EdgeInsets.all(KPMargins.margin16),
                            child: SizedBox(
                              width: double.infinity,
                              height: _maxImageHeight,
                              child: SingleChildScrollView(
                                child: SelectableText(
                                  _ocrText!,
                                  // TODO: Maybe change size of text depending of number of \n?
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          backgroundColor: Colors.white54),
                                  onSelectionChanged: (textSelection, _) {
                                    // TODO: Selected text make it searchable on Jisho
                                    // TODO: on the bottom of the BS. Also, translate it
                                  },
                                ),
                              ),
                            ),
                          ),
                        // TODO: Make button to translate all input image and show original
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ]);
      },
    );
  }

  GridView _pickerSelection() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 2),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: ImageSource.values.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: KPMargins.margin8),
          child: KPButton(
            title2: ImageSource.values[index] == ImageSource.camera
                ? 'ocr_camera'.tr()
                : 'ocr_gallery'.tr(),
            color: KPColors.getSecondaryColor(context),
            icon: ImageSource.values[index] == ImageSource.camera
                ? Icons.camera_alt_rounded
                : Icons.photo_library_rounded,
            onTap: () {
              if (ImageSource.values[index] == ImageSource.camera) {
                return context
                    .read<PermissionHandlerBloc>()
                    .add(PermissionHandlerEventRequestCamera());
              }
              return context
                  .read<PermissionHandlerBloc>()
                  .add(PermissionHandlerEventRequestGallery());
            },
          ),
        );
      },
    );
  }

  Widget _imageWidget() {
    // TODO: Show info subtle text to remind user that text is selectable and a translation will be provided on selected text
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KPMargins.margin8),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: _maxImageHeight,
        child: FutureBuilder<ui.Image>(
          future: decodeImageFromList(_image!.readAsBytesSync()),
          builder: (context, snapshot) {
            if (snapshot.data == null) return const SizedBox();
            bool isHorizontalImage =
                snapshot.data!.width > snapshot.data!.height;
            return Transform.rotate(
              angle: isHorizontalImage ? pi / 2 : 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(KPRadius.radius24),
                child: Image.file(
                  File(_image!.path),
                  fit: BoxFit.contain,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
