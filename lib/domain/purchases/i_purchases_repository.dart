import 'dart:async';

import 'package:purchases_flutter/purchases_flutter.dart';

abstract class IPurchasesRepository {
  Future<void> setUp();
  Future<bool> isUserPro();
  Future<List<StoreProduct>> loadProducts();
  Future<String> buy(String productId);
  Future<LogInResult> logIn(String uid);
  Future<String> restorePurchases();
}
