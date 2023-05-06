part of 'permission_handler_bloc.dart';

abstract class PermissionHandlerEvent extends Equatable {
  const PermissionHandlerEvent();

  @override
  List<Object> get props => [];
}

class PermissionHandlerEventRequestCamera extends PermissionHandlerEvent {}

class PermissionHandlerEventRequestGallery extends PermissionHandlerEvent {}

class PermissionHandlerEventIdle extends PermissionHandlerEvent {}
