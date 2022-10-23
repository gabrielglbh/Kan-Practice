import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/core/types/sign_in_mode.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kanpractice/domain/auth/i_auth_repository.dart';
import 'package:kanpractice/infrastructure/backup/backup_repository_impl.dart';
import 'package:sqflite/sqlite_api.dart';

@LazySingleton(as: IAuthRepository)
class AuthRepositoryImpl implements IAuthRepository {
  final FirebaseAuth _auth;
  final Database _database;
  final FirebaseFirestore _ref;

  AuthRepositoryImpl(this._auth, this._ref, this._database);

  @override
  Future<String> changePassword(
      String previousPassword, String newPassword) async {
    try {
      User? user = _auth.currentUser;

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

  @override
  Future<int> closeSession() async {
    User? user = getUser();
    if (user != null) {
      await _auth.signOut();
      return 0;
    } else {
      return -1;
    }
  }

  @override
  Future<String> deleteAccount(String password) async {
    try {
      User? user = _auth.currentUser;

      if (user != null && user.providerData[0].providerId == "password") {
        // Signs In again before operation
        AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!, password: password);
        User? reUser =
            (await user.reauthenticateWithCredential(credential)).user;

        if (reUser != null &&
            reUser.uid == user.uid &&
            reUser.email == user.email) {
          await BackupRepositoryImpl(_auth, _ref, _database).removeBackUp();
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

  @override
  User? getUser() => _auth.currentUser;

  @override
  Future<String> handleLogIn(
    SignMode mode,
    String email,
    String password,
  ) async {
    try {
      if (mode == SignMode.signup) {
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      } else if (mode == SignMode.login) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      }
    } catch (err) {
      return err.toString();
    }
    return "";
  }

  @override
  Future<bool> updateUserName(String name) async {
    try {
      await _auth.currentUser?.updateDisplayName(name);
      return true;
    } catch (err) {
      return false;
    }
  }
}
