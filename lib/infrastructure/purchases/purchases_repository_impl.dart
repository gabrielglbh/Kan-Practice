import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/auth/i_auth_repository.dart';
import 'package:kanpractice/domain/purchases/i_purchases_repository.dart';
import 'package:kanpractice/domain/user/i_user_repository.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

@LazySingleton(as: IPurchasesRepository)
class PurchasesRepositoryImpl implements IPurchasesRepository {
  final IUserRepository _userRepository;
  final IAuthRepository _auth;

  PurchasesRepositoryImpl(this._userRepository, this._auth);

  @override
  Future<void> setUp() async {
    final config = PurchasesConfiguration(dotenv.env['REVENUE_CAT_API_KEY']!);
    await Purchases.configure(config);
  }

  @override
  Future<bool> isUserPro() async {
    try {
      final user = await _userRepository.getUser();
      if (user == null) return false;

      final restoredInfo = await Purchases.restorePurchases();
      if (restoredInfo.entitlements.all['pro_update'] != null) {
        return user.isPro ||
            (restoredInfo.entitlements.all['pro_update']?.isActive ?? false);
      } else {
        return false;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }

  @override
  Future<List<StoreProduct>> loadProducts() async {
    try {
      return await Purchases.getProducts(['pro_update'],
          type: PurchaseType.inapp);
    } on PlatformException catch (_) {
      return [];
    }
  }

  @override
  Future<String> buy(String productId) async {
    try {
      final uid = _auth.getUser()?.uid;
      if (uid == null) return 'User not authorized';

      final customerInfo =
          await Purchases.purchaseProduct(productId, type: PurchaseType.inapp);
      if (customerInfo.entitlements.all['pro_update']?.isActive ?? false) {
        return (await _userRepository.updateUserToPro())
            ? ''
            : 'Something went wrong updating the plan';
      }
      return 'Dont have access to this entitlement';
    } on PlatformException catch (e) {
      final errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        return '$errorCode ${e.message}';
      }
    } on FirebaseException catch (e) {
      return '${e.code} ${e.message}';
    }
    return '';
  }
}
