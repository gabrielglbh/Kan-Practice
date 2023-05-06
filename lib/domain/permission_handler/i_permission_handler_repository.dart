import 'package:permission_handler/permission_handler.dart';

abstract class IPermissionHandlerRepository {
  Future<int> requestPermission(Permission permission);
}
