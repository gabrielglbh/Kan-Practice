import 'package:firebase_auth/firebase_auth.dart';
import 'package:kanpractice/presentation/core/types/sign_in_mode.dart';

abstract class IAuthRepository {
  /// Handles the log in with Firebase based on an [email] and [password]. The [mode]
  /// just indicates if we have to perform a sign in or a create user.
  Future<String> handleLogIn(SignMode mode, String email, String password);
  Future<String> changePassword(String previousPassword, String newPassword);
  Future<String> deleteAccount(String password);
  User? getUser();
  Future<bool> updateUserName(String name);
  Future<int> closeSession();
}
