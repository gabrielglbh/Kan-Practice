import 'package:firebase_auth/firebase_auth.dart';
import 'package:kanpractice/core/firebase/firebase.dart';
import 'package:kanpractice/core/firebase/queries/back_ups.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kanpractice/core/types/sign_in_mode.dart';

class AuthRecords {
  FirebaseAuth? _auth;

  AuthRecords._() {
    _auth = FirebaseUtils.instance.authRef;
  }

  static final AuthRecords _instance = AuthRecords._();

  /// Singleton instance of [AuthRecords]
  static AuthRecords get instance => _instance;

  /// Handles the log in with Firebase based on an [email] and [password]. The [mode]
  /// just indicates if we have to perform a sign in or a create user.
  Future<String> handleLogIn(
      SignMode mode, String email, String password) async {
    try {
      if (mode == SignMode.signup) {
        await _auth?.createUserWithEmailAndPassword(
            email: email, password: password);
      } else if (mode == SignMode.login) {
        await _auth?.signInWithEmailAndPassword(
            email: email, password: password);
      }
    } catch (err) {
      return err.toString();
    }
    return "";
  }

  /// Handles the change of password of an account. User must log in again inputting
  /// the current [previousPassword] and new password [newPassword] for user validation.
  Future<String> changePassword(
      String previousPassword, String newPassword) async {
    try {
      User? user = _auth?.currentUser;

      if (user != null) {
        // Signs In again before operation ONLY WITH EMAIL
        AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!, password: previousPassword);
        User? reUser =
            (await user.reauthenticateWithCredential(credential)).user;

        if (reUser != null &&
            reUser.uid == user.uid &&
            reUser.email == user.email) {
          await user.updatePassword(newPassword);
          return "";
        } else {
          return "authentication_failed".tr();
        }
      } else {
        return "authentication_changePassword_log_out".tr();
      }
    } catch (err) {
      return err.toString();
    }
  }

  /// Handles the deletion of an account. User must log in again inputting
  /// the current [password] for user validation.
  Future<String> deleteAccount(String password) async {
    try {
      User? user = _auth?.currentUser;

      if (user != null && user.providerData[0].providerId == "password") {
        // Signs In again before operation
        AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!, password: password);
        User? reUser =
            (await user.reauthenticateWithCredential(credential)).user;

        if (reUser != null &&
            reUser.uid == user.uid &&
            reUser.email == user.email) {
          await BackUpRecords.instance.removeBackUp();
          await user.delete();
          return "";
        } else {
          return "authentication_failed".tr();
        }
      } else {
        return "authentication_deleteAccount_wrong_provider".tr();
      }
    } catch (err) {
      return err.toString();
    }
  }

  /// Gets the actual user
  User? getUser() => _auth?.currentUser;

  Future<bool> updateUserName(String name) async {
    try {
      await _auth?.currentUser?.updateDisplayName(name);
      return true;
    } catch (err) {
      return false;
    }
  }

  /// Logs out the current user
  Future<int> closeSession() async {
    User? user = getUser();
    if (user != null) {
      await _auth?.signOut();
      return 0;
    } else {
      return -1;
    }
  }
}
