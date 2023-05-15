part of 'purchases_bloc.dart';

abstract class PurchasesEvent extends Equatable {
  const PurchasesEvent();

  @override
  List<Object> get props => [];
}

class PurchasesEventSetUp extends PurchasesEvent {}

class PurchasesEventLoadProducts extends PurchasesEvent {}

class PurchasesEventRestorePurchases extends PurchasesEvent {}

class PurchasesEventDidNotPurchase extends PurchasesEvent {}

class PurchasesEventBuy extends PurchasesEvent {
  final String productId;

  const PurchasesEventBuy(this.productId);

  @override
  List<Object> get props => [productId];
}
