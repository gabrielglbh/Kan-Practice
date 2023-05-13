part of 'purchases_bloc.dart';

@freezed
class PurchasesState with _$PurchasesState {
  const factory PurchasesState.initial() = PurchasesInitial;
  const factory PurchasesState.loading() = PurchasesLoading;
  const factory PurchasesState.error(String message) = PurchasesError;
  const factory PurchasesState.loaded(List<StoreProduct> products) =
      PurchasesLoaded;
  const factory PurchasesState.updatedToPro() = PurchasesUpdatedToPro;
  const factory PurchasesState.nonPro() = PurchasesNonPro;
}
