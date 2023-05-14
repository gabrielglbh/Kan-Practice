import 'package:kanpractice/domain/user/user.dart';

abstract class IUserRepository {
  Future<User?> getUser();
  Future<bool> updateUserToPro();
}
