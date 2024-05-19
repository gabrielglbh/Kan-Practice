import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kanpractice/application/permission_handler/permission_handler_bloc.dart';
import 'package:kanpractice/presentation/core/util/consts.dart';

class PermissionDenied extends StatelessWidget {
  const PermissionDenied({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.amber.shade900),
              const SizedBox(width: KPMargins.margin8),
              Text('ocr_permissions_denied'.tr()),
              const SizedBox(width: KPMargins.margin8),
              Icon(Icons.warning_amber_rounded, color: Colors.amber.shade900),
            ],
          ),
        ),
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
                    color: Theme.of(context).colorScheme.onSurface,
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
      ],
    );
  }
}
