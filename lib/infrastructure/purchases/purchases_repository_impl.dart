import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/purchases/i_purchases_repository.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

@LazySingleton(as: IPurchasesRepository)
class PurchasesRepositoryImpl implements IPurchasesRepository {
  PurchasesRepositoryImpl();

  @override
  Future<void> setUp() async {
    final config = PurchasesConfiguration(dotenv.env['REVENUE_CAT_API_KEY']!);
    await Purchases.configure(config);
  }

  @override
  Future<bool> isUserPro() async {
    try {
      final restoredInfo = await Purchases.restorePurchases();
      if (restoredInfo.entitlements.all['pro_update'] != null) {
        return restoredInfo.entitlements.all['pro_update']?.isActive ?? false;
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
      final customerInfo =
          await Purchases.purchaseProduct(productId, type: PurchaseType.inapp);
      return (customerInfo.entitlements.all['pro_update']?.isActive ?? false)
          ? ''
          : 'Dont have access to this entitlement';
    } on PlatformException catch (e) {
      final errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        return '$errorCode ${e.message}';
      }
    }
    return '';
  }
}
