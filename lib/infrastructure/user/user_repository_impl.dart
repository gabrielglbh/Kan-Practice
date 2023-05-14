import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/auth/i_auth_repository.dart';
import 'package:kanpractice/domain/user/i_user_repository.dart';
import 'package:kanpractice/domain/user/user.dart';
import 'package:kanpractice/infrastructure/user/user_dto.dart';

@LazySingleton(as: IUserRepository)
class UserRepositoryImpl implements IUserRepository {
  final FirebaseFirestore _ref;
  final IAuthRepository _auth;

  UserRepositoryImpl(this._ref, this._auth);

  @override
  Future<User?> getUser() async {
    final uid = _auth.getUser()?.uid;
    if (uid == null) return null;

    final user = await _ref.collection('Users').doc(uid).get();
    if (!user.exists || user.data() == null) return null;

    return UserDto.fromJson(user.data()!).toDomain();
  }

  @override
  Future<bool> updateUserToPro() async {
    try {
      final uid = _auth.getUser()?.uid;
      if (uid == null) return false;
      await _ref.collection('Users').doc(uid).update({'isPro': true});
      return true;
    } on FirebaseException catch (_) {
      return false;
    }
  }
}
