import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/application/ocr_page/ocr_page_bloc.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';
import 'package:kanpractice/presentation/core/util/utils.dart';
import 'package:kanpractice/presentation/core/widgets/kp_progress_indicator.dart';
import 'package:kanpractice/presentation/ocr_page/widgets/zoom_slider.dart';

class CameraPreviewPicker extends StatefulWidget {
  final CameraController? camera;
  final Future<void>? initializeControllerFuture;
  const CameraPreviewPicker({
    super.key,
    required this.camera,
    required this.initializeControllerFuture,
  });

  @override
  State<CameraPreviewPicker> createState() => _CameraPreviewPickerState();
}

class _CameraPreviewPickerState extends State<CameraPreviewPicker> {
  double _zoom = 1.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: FutureBuilder<void>(
              future: widget.initializeControllerFuture,
              builder: (context, snapshot) => snapshot.connectionState ==
                      ConnectionState.done
                  ? Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        if (widget.camera != null)
                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(KPRadius.radius16),
                            child: CameraPreview(widget.camera!),
                          ),
                        Positioned(
                          top: KPMargins.margin12,
                          child: Chip(
                              label: Text('x${Utils.getFixedDouble(_zoom)}')),
                        ),
                        Positioned(
                          bottom: KPMargins.margin64,
                          child: CircleAvatar(
                            radius: KPRadius.radius32,
                            backgroundColor: KPColors.secondaryDarkerColor,
                            child: IconButton(
                              onPressed: () async {
                                try {
                                  final bloc = context.read<OCRPageBloc>();
                                  await widget.initializeControllerFuture;
                                  final file =
                                      await widget.camera?.takePicture();
                                  bloc.add(OCRPageEventCrop(file: file));
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
                          left: KPMargins.margin12,
                          child: ZoomSlider(
                            zoom: _zoom,
                            onChanged: (value) {
                              setState(() => _zoom = value);
                              widget.camera?.setZoomLevel(_zoom);
                            },
                          ),
                        ),
                        Positioned(
                          top: KPMargins.margin12,
                          right: KPMargins.margin12,
                          child: CircleAvatar(
                            radius: KPRadius.radius32,
                            backgroundColor: KPColors.secondaryColor,
                            child: IconButton(
                              onPressed: () {
                                context
                                    .read<OCRPageBloc>()
                                    .add(const OCRPageEventCrop());
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
          const SizedBox(height: KPMargins.margin24),
        ],
      ),
    );
  }
}
