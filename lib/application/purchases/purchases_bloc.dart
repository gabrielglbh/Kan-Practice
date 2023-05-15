import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kanpractice/domain/purchases/i_purchases_repository.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

part 'purchases_event.dart';
part 'purchases_state.dart';

part 'purchases_bloc.freezed.dart';

@lazySingleton
class PurchasesBloc extends Bloc<PurchasesEvent, PurchasesState> {
  final IPurchasesRepository _purchasesRepository;

  PurchasesBloc(this._purchasesRepository)
      : super(const PurchasesState.initial()) {
    on<PurchasesEventSetUp>((event, emit) async {
      emit(const PurchasesState.loading());
      await _purchasesRepository.setUp();
      if (await _purchasesRepository.isUserPro()) {
        emit(const PurchasesState.updatedToPro());
      } else {
        emit(const PurchasesState.nonPro());
      }
    });

    on<PurchasesEventBuy>((event, emit) async {
      emit(const PurchasesState.loading());
      final res = await _purchasesRepository.buy(event.productId);
      if (res.isEmpty) {
        if (await _purchasesRepository.isUserPro()) {
          emit(const PurchasesState.updatedToPro());
        } else {
          emit(const PurchasesState.nonPro());
        }
      } else {
        emit(PurchasesState.error(res));
      }
    });

    on<PurchasesEventLoadProducts>((event, emit) async {
      emit(const PurchasesState.loading());
      final products = await _purchasesRepository.loadProducts();
      emit(PurchasesState.loaded(products));
    });

    on<PurchasesEventDidNotPurchase>((event, emit) async {
      emit(const PurchasesState.nonPro());
    });

    on<PurchasesEventRestorePurchases>((event, emit) async {
      emit(const PurchasesState.loading());
      final status = await _purchasesRepository.restorePurchases();
      if (status.isEmpty) {
        emit(const PurchasesState.updatedToPro());
      } else {
        emit(PurchasesState.error(status));
      }
    });
  }
}
