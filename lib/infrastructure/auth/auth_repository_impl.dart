import 'package:easy_localization/easy_localization.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/presentation/core/types/sign_in_mode.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kanpractice/domain/auth/i_auth_repository.dart';

@LazySingleton(as: IAuthRepository)
class AuthRepositoryImpl implements IAuthRepository {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepositoryImpl(this._auth, this._googleSignIn);

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
  Future<int> closeGoogleSession() async {
    User? user = getUser();
    if (user != null) {
      await _googleSignIn.signOut();
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
  Future<User?> handleLogIn(
    SignMode mode,
    String email,
    String password,
  ) async {
    try {
      late UserCredential credential;
      if (mode == SignMode.signup) {
        credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      } else if (mode == SignMode.login) {
        credential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      }
      return credential.user;
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  @override
  Future<User?> handleGoogleLogIn() async {
    try {
      if (await _googleSignIn.isSignedIn()) _googleSignIn.signOut();

      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final auth = await googleUser.authentication;
      final credentials = GoogleAuthProvider.credential(
        accessToken: auth.accessToken,
        idToken: auth.idToken,
      );
      return (await _auth.signInWithCredential(credentials)).user;
    } catch (err) {
      print(err.toString());
      return null;
    }
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
