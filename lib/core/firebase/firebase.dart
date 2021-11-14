import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUtils {
  /// Singleton instance of [FirebaseUtils]
  static FirebaseUtils instance = FirebaseUtils();

  FirebaseFirestore? dbRef;
  FirebaseAuth? authRef;

  FirebaseUtils() {
    dbRef = FirebaseFirestore.instance;
    authRef = FirebaseAuth.instance;
  }
}