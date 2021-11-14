import 'package:firebase_auth/firebase_auth.dart';
import 'package:kanpractice/core/firebase/firebase.dart';
import 'package:kanpractice/core/firebase/queries/back_ups.dart';
import 'package:kanpractice/ui/pages/firebase_login/login.dart';

class AuthRecords {
  FirebaseAuth? _auth;
  /// Singleton instance of [AuthRecords]
  static AuthRecords instance = AuthRecords();

  AuthRecords() {
    _auth = FirebaseUtils.instance.authRef;
  }

  /// Handles the log in with Firebase based on an [email] and [password]. The [mode]
  /// just indicates if we have to perform a sign in or a create user.
  Future<String> handleLogIn(SignMode mode, String email, String password) async {
    try {
      if (mode == SignMode.signup) {
        await _auth?.createUserWithEmailAndPassword(email: email, password: password);
      } else if (mode == SignMode.login) {
        await _auth?.signInWithEmailAndPassword(email: email, password: password);
      }
    } catch(err) {
      return err.toString();
    }
    return "";
  }

  /// Handles the change of password of an account. User must log in again inputting
  /// the current [previousPassword] and new password [newPassword] for user validation.
  Future<String> changePassword(String previousPassword, String newPassword) async {
    try {
      User? user = _auth?.currentUser;

      if (user != null) {
        // Signs In again before operation ONLY WITH EMAIL
        AuthCredential credential = EmailAuthProvider.credential(email: user.email!, password: previousPassword);
        User? reUser = (await user.reauthenticateWithCredential(credential)).user;

        if (reUser != null && reUser.uid == user.uid && reUser.email == user.email){
          await user.updatePassword(newPassword);
          return "";
        }
        else {
          return "Re-authentication failed. Try again later.";
        }
      } else return "You are not logged in. Login, and you will be able to change your password.";
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
        AuthCredential credential = EmailAuthProvider.credential(email: user.email!, password: password);
        User? reUser = (await user.reauthenticateWithCredential(credential)).user;

        if (reUser != null && reUser.uid == user.uid && reUser.email == user.email) {
          await BackUpRecords.instance.removeBackUp();
          await user.delete();
          return "";
        }
        else {
          return "Re-authentication failed. Try again later.";
        }
      } else return "Wrong provider. Try again later.";
    } catch (err) {
      return err.toString();
    }
  }

  /// Gets the actual user
  User? getUser() => _auth?.currentUser;

  /// Logs out the current user
  Future<int> closeSession() async {
    User? user = getUser();
    if (user != null) {
      await _auth?.signOut();
      return 0;
    }
    else return -1;
  }
}