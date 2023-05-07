import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/application/ocr_page/ocr_page_bloc.dart';
import 'package:kanpractice/application/permission_handler/permission_handler_bloc.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/widgets/kp_button.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/core/widgets/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/widgets/kp_tappable_info.dart';
import 'package:kanpractice/presentation/ocr_page/ocr_context_menu.dart';
import 'dart:ui' as ui;
import 'package:permission_handler/permission_handler.dart';

class OCRPage extends StatefulWidget {
  const OCRPage({Key? key}) : super(key: key);

  @override
  State<OCRPage> createState() => _OCRPageState();
}

class _OCRPageState extends State<OCRPage> {
  File? _image;
  double get _maxImageHeight => MediaQuery.of(context).size.height / 2;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OCRPageBloc>(),
      child: BlocConsumer<OCRPageBloc, OCRPageState>(
        listener: (context, ocrState) {
          ocrState.mapOrNull(
            imageLoaded: (i) {
              if (i.image != null) _image = i.image;
            },
          );
        },
        builder: (context, ocrState) {
          return KPScaffold(
            appBarTitle: "ocr_scanner".tr(),
            appBarActions: [
              IconButton(
                onPressed: () {
                  context.read<OCRPageBloc>().add(OCRPageEventReset());
                },
                icon: const Icon(Icons.add_photo_alternate_rounded),
              ),
            ],
            child: BlocConsumer<PermissionHandlerBloc, PermissionHandlerState>(
              listener: (context, state) {
                state.mapOrNull(
                  succeeded: (s) {
                    context
                        .read<OCRPageBloc>()
                        .add(OCRPageEventLoadImage(s.source));
                    context
                        .read<PermissionHandlerBloc>()
                        .add(PermissionHandlerEventIdle());
                  },
                );
              },
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    state.maybeWhen(
                      error: () => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('ocr_permissions_denied'.tr()),
                          IconButton(
                              onPressed: () => openAppSettings(),
                              icon: const Icon(Icons.link_rounded))
                        ],
                      ),
                      orElse: () => const SizedBox(),
                    ),
                    ocrState.maybeWhen(
                      initial: () => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: KPMargins.margin16),
                          const Icon(Icons.info_outline_rounded),
                          const SizedBox(height: KPMargins.margin8),
                          Text('ocr_scanner_explain'.tr()),
                        ],
                      ),
                      orElse: () => const SizedBox(),
                    ),
                    const SizedBox(height: KPMargins.margin8),
                    Flexible(
                      child: ocrState.maybeWhen(
                        initial: () => Center(child: _pickerSelection()),
                        orElse: () => Column(
                          children: [
                            KPTappableInfo(text: 'ocr_select_text_info'.tr()),
                            const Expanded(child: SizedBox()),
                            Padding(
                              padding: const EdgeInsets.all(KPMargins.margin8),
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      _imagePaint(),
                                      ocrState.maybeWhen(
                                        imageLoaded: (text, _) => _text(text),
                                        translationLoaded: (translation) =>
                                            _text(translation),
                                        loading: () =>
                                            const KPProgressIndicator(),
                                        orElse: () => const SizedBox(),
                                      ),
                                    ],
                                  ),
                                  ocrState.maybeWhen(
                                    imageLoaded: (text, __) => Positioned(
                                      bottom: KPMargins.margin16,
                                      right: KPMargins.margin24,
                                      child: GestureDetector(
                                        onTap: () {
                                          context.read<OCRPageBloc>().add(
                                              OCRPageEventTraverseText(text));
                                        },
                                        child: Container(
                                          width: KPMargins.margin48,
                                          height: KPMargins.margin48,
                                          margin: const EdgeInsets.only(
                                              bottom: KPMargins.margin16),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: KPColors.secondaryColor,
                                          ),
                                          child: const Icon(
                                              Icons.text_format_rounded,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    orElse: () => const SizedBox(),
                                  ),
                                ],
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            ocrState.maybeWhen(
                              imageLoaded: (_, __) => KPButton(
                                title2: 'ocr_translate'.tr(),
                                icon: Icons.translate_rounded,
                                onTap: () {
                                  context.read<OCRPageBloc>().add(
                                      OCRPageEventTranslate(
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
                                      .read<OCRPageBloc>()
                                      .add(OCRPageEventShowOriginal());
                                },
                              ),
                              orElse: () => const SizedBox(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: KPMargins.margin16),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  GridView _pickerSelection() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, childAspectRatio: 3),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
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

  Widget _imagePaint() {
    return _image != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(KPRadius.radius24),
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
                    child: Image.file(
                      File(_image!.path),
                      fit: BoxFit.fill,
                    ),
                  );
                },
              ),
            ),
          )
        : const SizedBox();
  }

  Widget _text(String? text) {
    return SizedBox(
      width: double.infinity,
      height: _maxImageHeight,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(KPMargins.margin8),
          child: SelectableText(
            text ?? '',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.black,
                  backgroundColor: Colors.white70,
                  fontWeight: FontWeight.normal,
                ),
            contextMenuBuilder: ((context, editableTextState) {
              final ts = editableTextState.currentTextEditingValue.selection;
              final selectedText = editableTextState
                  .currentTextEditingValue.text
                  .substring(ts.baseOffset, ts.extentOffset);
              final anchor = editableTextState.contextMenuAnchors.primaryAnchor;

              return OCRContextMenu(anchor: anchor, selectedText: selectedText);
            }),
          ),
        ),
      ),
    );
  }
}
