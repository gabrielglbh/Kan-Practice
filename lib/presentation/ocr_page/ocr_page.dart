import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/application/ocr_page/ocr_page_bloc.dart';
import 'package:kanpractice/application/permission_handler/permission_handler_bloc.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
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
  final _textEditingController = TextEditingController();
  final _focusNode = FocusNode();
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
              _textEditingController.text = i.text;
            },
          );
        },
        builder: (bloc, ocrState) {
          return KPScaffold(
            appBarTitle: "ocr_scanner".tr(),
            appBarActions: [
              IconButton(
                onPressed: () {
                  _image = null;
                  bloc.read<OCRPageBloc>().add(OCRPageEventReset());
                },
                icon: const Icon(Icons.add_photo_alternate_rounded),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(KanPracticePages.historyWordPage);
                },
                icon: const Icon(Icons.history_rounded),
              ),
            ],
            resizeToAvoidBottomInset: true,
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
                return SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height -
                        KPSizes.appBarHeight -
                        KPMargins.margin64,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: ocrState.maybeWhen(
                            initial: () => Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: _maxImageHeight,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          KPRadius.radius24),
                                      border: Border.all(
                                          color: KPColors.getSubtle(context)),
                                    ),
                                    alignment: Alignment.center,
                                    child: _pickerSelection(state),
                                  ),
                                ],
                              ),
                            ),
                            orElse: () => Column(
                              children: [
                                const Expanded(child: SizedBox()),
                                KPTappableInfo(
                                    text: 'ocr_select_text_info'.tr()),
                                const SizedBox(height: KPMargins.margin16),
                                Padding(
                                  padding:
                                      const EdgeInsets.all(KPMargins.margin8),
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxWidth:
                                              MediaQuery.of(context).size.width,
                                          maxHeight: _maxImageHeight,
                                        ),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            _imagePaint(),
                                            ocrState.maybeWhen(
                                              imageLoaded: (text, _) =>
                                                  _text(bloc, text),
                                              translationLoaded:
                                                  (translation) =>
                                                      _translation(translation),
                                              loading: () =>
                                                  const KPProgressIndicator(),
                                              orElse: () => const SizedBox(),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ocrState.maybeWhen(
                                        imageLoaded: (text, __) => Positioned(
                                          right: KPMargins.margin24,
                                          child: GestureDetector(
                                            onTap: () {
                                              _focusNode.unfocus();
                                              bloc.read<OCRPageBloc>().add(
                                                  OCRPageEventTraverseText(
                                                      text));
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
                                ocrState.maybeWhen(
                                  imageLoaded: (_, image) => GestureDetector(
                                    onTap: () {
                                      bloc.read<OCRPageBloc>().add(
                                          OCRPageEventReloadImage(
                                              image ?? _image!));
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.refresh),
                                        const SizedBox(
                                            width: KPMargins.margin4),
                                        Text('ocr_reload_image'.tr()),
                                      ],
                                    ),
                                  ),
                                  orElse: () => const SizedBox(),
                                ),
                                const Expanded(child: SizedBox()),
                                ocrState.maybeWhen(
                                  imageLoaded: (_, __) => KPButton(
                                    title2: 'ocr_translate'.tr(),
                                    icon: Icons.translate_rounded,
                                    onTap: () {
                                      bloc.read<OCRPageBloc>().add(
                                          OCRPageEventTranslate(WidgetsBinding
                                              .instance
                                              .window
                                              .locale
                                              .languageCode));
                                    },
                                  ),
                                  translationLoaded: (_) => KPButton(
                                    title2: 'ocr_show_original'.tr(),
                                    icon: Icons.keyboard_backspace_rounded,
                                    onTap: () {
                                      bloc
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
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _pickerSelection(PermissionHandlerState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("${"ocr_choose_opts".tr()}:"),
        const SizedBox(height: KPMargins.margin24),
        Flexible(
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: ImageSource.values.length,
            separatorBuilder: (_, __) => Row(
              children: [
                const SizedBox(width: KPMargins.margin18),
                const Expanded(child: Divider()),
                Container(
                  width: KPMargins.margin12,
                  height: KPMargins.margin12,
                  margin: const EdgeInsets.symmetric(
                      horizontal: KPMargins.margin12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: KPColors.getAccent(context),
                  ),
                ),
                const Expanded(child: Divider()),
                const SizedBox(width: KPMargins.margin18),
              ],
            ),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  if (index == 1) const SizedBox(height: KPMargins.margin18),
                  IconButton(
                    onPressed: () {
                      if (ImageSource.values[index] == ImageSource.camera) {
                        return context
                            .read<PermissionHandlerBloc>()
                            .add(PermissionHandlerEventRequestCamera());
                      }
                      return context
                          .read<PermissionHandlerBloc>()
                          .add(PermissionHandlerEventRequestGallery());
                    },
                    icon: Icon(ImageSource.values[index] == ImageSource.camera
                        ? Icons.camera_alt_rounded
                        : Icons.photo_library_rounded),
                  ),
                  const SizedBox(height: KPMargins.margin12),
                  Text(
                    ImageSource.values[index] == ImageSource.camera
                        ? 'ocr_camera'.tr()
                        : 'ocr_gallery'.tr(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  if (index == 0) const SizedBox(height: KPMargins.margin18),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: KPMargins.margin24),
        state.maybeWhen(
          error: () => GestureDetector(
            onTap: () => openAppSettings(),
            child: SizedBox(
              height: KPMargins.margin32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.warning_amber_rounded,
                      color: Colors.amber.shade900),
                  const SizedBox(width: KPMargins.margin8),
                  Text('ocr_permissions_denied'.tr()),
                  const SizedBox(width: KPMargins.margin8),
                  Icon(Icons.warning_amber_rounded,
                      color: Colors.amber.shade900),
                ],
              ),
            ),
          ),
          orElse: () => const SizedBox(),
        ),
      ],
    );
  }

  Widget _imagePaint() {
    return _image != null
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
        : const SizedBox();
  }

  Widget _text(BuildContext bloc, String? text) {
    return SingleChildScrollView(
      child: TextField(
        controller: _textEditingController,
        focusNode: _focusNode,
        cursorColor: KPColors.secondaryDarkerColor,
        maxLines: null,
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Colors.black,
              backgroundColor: Colors.white70,
              fontWeight: FontWeight.normal,
              height: 1.2,
            ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.all(KPMargins.margin8),
        ),
        onTapOutside: (event) {
          bloc
              .read<OCRPageBloc>()
              .add(OCRPageEventShowUpdateText(_textEditingController.text));
        },
        contextMenuBuilder: ((context, editableTextState) {
          final ts = editableTextState.currentTextEditingValue.selection;
          final selectedText = editableTextState.currentTextEditingValue.text
              .substring(ts.baseOffset, ts.extentOffset);
          final anchor = editableTextState.contextMenuAnchors.primaryAnchor;

          return OCRContextMenu(anchor: anchor, selectedText: selectedText);
        }),
      ),
    );
  }

  Widget _translation(String? text) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(KPMargins.margin8),
        child: Text(
          text ?? '',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.black,
                backgroundColor: Colors.white70,
                fontWeight: FontWeight.normal,
              ),
        ),
      ),
    );
  }
}
