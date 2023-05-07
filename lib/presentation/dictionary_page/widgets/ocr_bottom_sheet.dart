import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/application/ocr_bottom_sheet/ocr_bottom_sheet_bloc.dart';
import 'package:kanpractice/application/permission_handler/permission_handler_bloc.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/widgets/kp_button.dart';
import 'package:kanpractice/presentation/core/widgets/kp_drag_container.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/widgets/kp_tappable_info.dart';
import 'dart:async';
import 'dart:ui' as ui;

import 'package:permission_handler/permission_handler.dart';

class OCRBottomSheet extends StatefulWidget {
  const OCRBottomSheet({Key? key}) : super(key: key);

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
  double get _maxImageHeight => MediaQuery.of(context).size.height / 2;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
        return BlocProvider(
          create: (context) => getIt<OCRBottomSheetBloc>(),
          child: Wrap(children: [
            BlocConsumer<PermissionHandlerBloc, PermissionHandlerState>(
              listener: (context, state) {
                state.mapOrNull(
                  succeeded: (s) {
                    context
                        .read<OCRBottomSheetBloc>()
                        .add(OCRBottomSheetEventLoadImage(s.source));
                    context
                        .read<PermissionHandlerBloc>()
                        .add(PermissionHandlerEventIdle());
                  },
                );
              },
              builder: (context, state) {
                return BlocConsumer<OCRBottomSheetBloc, OCRBottomSheetState>(
                  listener: (context, ocrState) {
                    ocrState.mapOrNull(
                      imageLoaded: (i) {
                        if (i.image != null) _image = i.image;
                      },
                    );
                  },
                  builder: (context, ocrState) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const KPDragContainer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: KPMargins.margin8,
                              horizontal: KPMargins.margin32),
                          child: Text(
                              ocrState.mapOrNull(
                                    imageLoaded: (_) => "ocr_scanned".tr(),
                                    translationLoaded: (_) =>
                                        "ocr_scanned".tr(),
                                  ) ??
                                  "ocr_picker_title".tr(),
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
                        ocrState.mapOrNull(
                              imageLoaded: (_) => KPTappableInfo(
                                  text: 'ocr_select_text_info'.tr()),
                              translationLoaded: (_) => KPTappableInfo(
                                  text: 'ocr_select_text_info'.tr()),
                            ) ??
                            const SizedBox(),
                        ocrState.maybeWhen(
                          imageLoaded: (ocr, image) =>
                              _imageWidget(image: image ?? _image, text: ocr),
                          translationLoaded: (translation) =>
                              _imageWidget(image: _image, text: translation),
                          loading: () => _imageWidget(loading: true),
                          orElse: () => _pickerSelection(),
                        ),
                        const SizedBox(height: KPMargins.margin16),
                        ocrState.maybeWhen(
                          imageLoaded: (_, __) => KPButton(
                            title2: 'ocr_translate'.tr(),
                            icon: Icons.translate_rounded,
                            onTap: () {
                              context.read<OCRBottomSheetBloc>().add(
                                  OCRBottomSheetEventTranslate(
                                      EasyLocalization.of(context)
                                              ?.currentLocale
                                              ?.languageCode ??
                                          'en'));
                            },
                          ),
                          translationLoaded: (_) => KPButton(
                            title2: 'ocr_show_original'.tr(),
                            icon: Icons.keyboard_backspace_rounded,
                            onTap: () {
                              context
                                  .read<OCRBottomSheetBloc>()
                                  .add(OCRBottomSheetEventShowOriginal());
                            },
                          ),
                          orElse: () => const SizedBox(),
                        ),
                        const SizedBox(height: KPMargins.margin16),
                      ],
                    );
                  },
                );
              },
            ),
          ]),
        );
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
            color: KPColors.secondaryColor,
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

  Widget _imageWidget({File? image, String? text, bool loading = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KPMargins.margin8),
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: _maxImageHeight,
            child: loading
                ? const Center(child: KPProgressIndicator())
                : image != null
                    ? FutureBuilder<ui.Image>(
                        future: decodeImageFromList(image.readAsBytesSync()),
                        builder: (context, snapshot) {
                          if (snapshot.data == null) return const SizedBox();
                          bool isHorizontalImage =
                              snapshot.data!.width > snapshot.data!.height;
                          return Transform.rotate(
                            angle: isHorizontalImage ? pi / 2 : 0,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(KPRadius.radius24),
                              child: Image.file(
                                File(image.path),
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        },
                      )
                    : const SizedBox(),
          ),
          if (text != null)
            Padding(
              padding: const EdgeInsets.all(KPMargins.margin16),
              child: SizedBox(
                width: double.infinity,
                height: _maxImageHeight,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(KPMargins.margin8),
                    child: SelectableText(
                      text,
                      // TODO: Maybe change size of text depending of number of \n?
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(backgroundColor: Colors.white54),
                      onSelectionChanged: (textSelection, _) {
                        // TODO: Selected text make it searchable on Jisho
                        // TODO: on the bottom of the BS. Also, translate it
                      },
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
