import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/ocr_page/ocr_page_bloc.dart';
import 'package:kanpractice/application/permission_handler/permission_handler_bloc.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraPreviewPicker extends StatefulWidget {
  const CameraPreviewPicker({super.key});

  @override
  State<CameraPreviewPicker> createState() => _CameraPreviewPickerState();
}

class _CameraPreviewPickerState extends State<CameraPreviewPicker> {
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocListener<OCRPageBloc, OCRPageState>(
            listener: (context, state) {
              state.mapOrNull(initial: (_) {
                _initCamera();
              });
            },
            child: BlocConsumer<PermissionHandlerBloc, PermissionHandlerState>(
              listener: (context, state) {
                state.mapOrNull(succeeded: (s) {
                  _initCamera();
                });
              },
              builder: (context, state) {
                return state.maybeWhen(
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
                );
              },
            ),
          ),
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) => Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(KPRadius.radius16),
                border: snapshot.connectionState != ConnectionState.done
                    ? Border.all(color: KPColors.getSubtle(context))
                    : null,
                color: snapshot.connectionState == ConnectionState.done
                    ? Colors.black
                    : null,
              ),
              alignment: Alignment.center,
              child: snapshot.connectionState == ConnectionState.done
                  ? Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        if (_camera != null) CameraPreview(_camera!),
                        Positioned(
                          bottom: KPMargins.margin12,
                          child: CircleAvatar(
                            radius: KPRadius.radius32,
                            backgroundColor: KPColors.secondaryDarkerColor,
                            child: IconButton(
                              onPressed: () async {
                                try {
                                  final bloc = context.read<OCRPageBloc>();
                                  await _initializeControllerFuture;
                                  final file = await _camera?.takePicture();
                                  bloc.add(OCRPageEventLoadImage(file: file));
                                } catch (_) {}
                              },
                              icon: const Icon(
                                Icons.photo_camera,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: KPMargins.margin12,
                          right: KPMargins.margin12,
                          child: CircleAvatar(
                            radius: KPRadius.radius32,
                            backgroundColor: KPColors.secondaryColor,
                            child: IconButton(
                              onPressed: () {
                                context.read<PermissionHandlerBloc>().add(
                                    PermissionHandlerEventRequestGallery());
                              },
                              icon: const Icon(
                                Icons.photo_library_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : const Center(
                      child: KPProgressIndicator(),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
