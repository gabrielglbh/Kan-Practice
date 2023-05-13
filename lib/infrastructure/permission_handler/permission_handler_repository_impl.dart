import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/permission_handler/i_permission_handler_repository.dart';
import 'package:permission_handler/permission_handler.dart';

@LazySingleton(as: IPermissionHandlerRepository)
class PermissionHandlerRepository implements IPermissionHandlerRepository {
  PermissionHandlerRepository();

  @override
  Future<int> requestPermission(Permission permission) async {
    final status = await permission.request();
    if (status.isGranted) return 0;
    if (status.isDenied || status.isPermanentlyDenied) return -1;
    return -2;
  }
}
