part of 'permission_handler_bloc.dart';

@freezed
class PermissionHandlerState with _$PermissionHandlerState {
  const factory PermissionHandlerState.initial() = PermissionHandlerInitial;
  const factory PermissionHandlerState.succeeded(ImageSource source) =
      PermissionHandlerSucceeded;
  const factory PermissionHandlerState.error() = PermissionHandlerError;
}
