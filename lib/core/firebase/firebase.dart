import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUtils {
  late FirebaseFirestore dbRef;
  late FirebaseAuth authRef;

  FirebaseUtils._() {
    dbRef = FirebaseFirestore.instance;
    authRef = FirebaseAuth.instance;
  }

  static final FirebaseUtils _instance = FirebaseUtils._();

  /// Singleton instance of [FirebaseUtils]
  static FirebaseUtils get instance => _instance;
}