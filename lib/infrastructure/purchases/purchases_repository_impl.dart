import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/auth/i_auth_repository.dart';
import 'package:kanpractice/domain/purchases/i_purchases_repository.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

@LazySingleton(as: IPurchasesRepository)
class PurchasesRepositoryImpl implements IPurchasesRepository {
  final IAuthRepository _auth;

  PurchasesRepositoryImpl(this._auth);

  static const proId = 'pro_update';

  @override
  Future<void> setUp() async {
    final config = PurchasesConfiguration(dotenv.env['REVENUE_CAT_API_KEY']!);
    final uid = _auth.getUser()?.uid;
    if (uid != null) {
      config.appUserID = uid;
    }
    await Purchases.configure(config);
  }

  @override
  Future<bool> isUserPro() async {
    try {
      final restoredInfo = await Purchases.getCustomerInfo();
      if (restoredInfo.entitlements.all[proId] != null) {
        return (restoredInfo.entitlements.all[proId]?.isActive ?? false);
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
      return await Purchases.getProducts([proId], type: PurchaseType.inapp);
    } on PlatformException catch (_) {
      return [];
    }
  }

  @override
  Future<String> buy(String productId) async {
    try {
      final uid = _auth.getUser()?.uid;
      if (uid == null) return 'buy_error_1'.tr();

      await logIn(uid);

      final customerInfo =
          await Purchases.purchaseProduct(productId, type: PurchaseType.inapp);
      return (customerInfo.entitlements.all[proId]?.isActive ?? false)
          ? ''
          : 'buy_error_2'.tr();
    } on PlatformException catch (e) {
      final errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode == PurchasesErrorCode.purchaseCancelledError) return '';
      return '$errorCode ${e.message}';
    } on FirebaseException catch (e) {
      return '${e.code} ${e.message}';
    }
  }

  @override
  Future<LogInResult> logIn(String uid) async {
    return await Purchases.logIn(uid);
  }

  @override
  Future<String> restorePurchases() async {
    try {
      final uid = _auth.getUser()?.uid;
      if (uid == null) return 'buy_error_1'.tr();

      await logIn(uid);

      final restoredInfo = await Purchases.restorePurchases();
      if (restoredInfo.entitlements.all[proId] != null) {
        return (restoredInfo.entitlements.all[proId]?.isActive ?? false)
            ? ''
            : 'buy_error_2'.tr();
      } else {
        return 'buy_error_4'.tr();
      }
    } on PlatformException catch (err) {
      return '${err.code} ${err.message}';
    }
  }
}
