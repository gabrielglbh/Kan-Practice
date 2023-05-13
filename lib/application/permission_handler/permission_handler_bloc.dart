import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/permission_handler/i_permission_handler_repository.dart';
import 'package:permission_handler/permission_handler.dart';

part 'permission_handler_event.dart';
part 'permission_handler_state.dart';

part 'permission_handler_bloc.freezed.dart';

@lazySingleton
class PermissionHandlerBloc
    extends Bloc<PermissionHandlerEvent, PermissionHandlerState> {
  final IPermissionHandlerRepository _permissionHandlerRepository;

  PermissionHandlerBloc(this._permissionHandlerRepository)
      : super(const PermissionHandlerState.initial()) {
    on<PermissionHandlerEventIdle>((event, emit) async {
      emit(const PermissionHandlerState.initial());
    });

    on<PermissionHandlerEventRequestCamera>((event, emit) async {
      final granted = await _permissionHandlerRepository
          .requestPermission(Permission.camera);
      if (granted == 0) {
        emit(const PermissionHandlerState.succeeded(ImageSource.camera));
      } else {
        emit(const PermissionHandlerState.error());
      }
    });

    on<PermissionHandlerEventRequestGallery>((event, emit) async {
      late int granted = 0;
      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        if (androidInfo.version.sdkInt! <= 32) {
          granted = await _permissionHandlerRepository
              .requestPermission(Permission.storage);
        } else {
          granted = await _permissionHandlerRepository
              .requestPermission(Permission.photos);
        }
      }

      if (granted == 0) {
        emit(const PermissionHandlerState.succeeded(ImageSource.gallery));
      } else {
        emit(const PermissionHandlerState.error());
      }
    });
  }
}
