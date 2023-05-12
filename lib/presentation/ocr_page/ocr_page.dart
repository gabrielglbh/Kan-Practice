import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kanpractice/application/ocr_page/ocr_page_bloc.dart';
import 'package:kanpractice/application/permission_handler/permission_handler_bloc.dart';
import 'package:kanpractice/injection.dart';
import 'package:kanpractice/presentation/core/routing/pages.dart';
import 'package:kanpractice/presentation/core/widgets/kp_button.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/widgets/kp_scaffold.dart';
import 'package:kanpractice/presentation/core/widgets/kp_tappable_info.dart';
import 'package:kanpractice/presentation/ocr_page/widgets/camera_preview_picker.dart';
import 'package:kanpractice/presentation/ocr_page/widgets/ocr_content.dart';
import 'package:kanpractice/presentation/ocr_page/widgets/permission_denied.dart';

class OCRPage extends StatefulWidget {
  const OCRPage({Key? key}) : super(key: key);

  @override
  State<OCRPage> createState() => _OCRPageState();
}

class _OCRPageState extends State<OCRPage> {
  CameraController? _camera;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    final bloc = context.read<PermissionHandlerBloc>();
    if (bloc.state is! PermissionHandlerSucceeded) {
      bloc.add(PermissionHandlerEventRequestCamera());
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final cameras = await availableCameras();
        final firstCamera = cameras.first;
        _camera = CameraController(firstCamera, ResolutionPreset.veryHigh);
        _initializeControllerFuture = _camera?.initialize();
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _camera?.dispose();
    super.dispose();
  }

  void _initCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    setState(() {
      _camera = CameraController(firstCamera, ResolutionPreset.veryHigh);
      _initializeControllerFuture = _camera?.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OCRPageBloc>(),
      child: BlocConsumer<OCRPageBloc, OCRPageState>(
        listener: (context, state) {
          state.mapOrNull(initial: (_) {
            _initCamera();
          });
        },
        builder: (bloc, ocrState) {
          return KPScaffold(
            appBarTitle: "ocr_scanner".tr(),
            appBarActions: [
              IconButton(
                onPressed: () {
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
                state.mapOrNull(succeeded: (s) {
                  switch (s.source) {
                    case ImageSource.camera:
                      _initCamera();
                      break;
                    case ImageSource.gallery:
                      bloc
                          .read<OCRPageBloc>()
                          .add(const OCRPageEventLoadImage());
                      break;
                  }
                  context
                      .read<PermissionHandlerBloc>()
                      .add(PermissionHandlerEventIdle());
                });
              },
              builder: (context, state) {
                return state.maybeWhen(
                  initial: () => ocrState.maybeWhen(
                    initial: () => CameraPreviewPicker(
                      camera: _camera,
                      initializeControllerFuture: _initializeControllerFuture,
                    ),
                    orElse: () => Column(
                      children: [
                        const SizedBox(height: KPMargins.margin16),
                        KPTappableInfo(text: 'ocr_select_text_info'.tr()),
                        const Expanded(child: SizedBox()),
                        const Expanded(
                          flex: 30,
                          child: Align(
                            alignment: Alignment.center,
                            child: OCRContent(),
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        ocrState.maybeWhen(
                          imageLoaded: (_, __) => KPButton(
                            title2: 'ocr_translate'.tr(),
                            icon: Icons.translate_rounded,
                            onTap: () {
                              bloc.read<OCRPageBloc>().add(
                                  OCRPageEventTranslate(WidgetsBinding
                                      .instance.window.locale.languageCode));
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
                        const SizedBox(height: KPMargins.margin16),
                      ],
                    ),
                  ),
                  orElse: () => const PermissionDenied(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
