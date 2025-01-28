import 'package:flutter_bloc/flutter_bloc.dart';

import '/data/repositories/purchases_repository.dart';
import '/domain/repositories/i_inventory_repository.dart';
import '/models/product.dart';
import '/models/purchase.dart';

// Events
abstract class PurchasesEvent {}

class LoadPurchases extends PurchasesEvent {}

class LoadProducts extends PurchasesEvent {}

class AddPurchase extends PurchasesEvent {
  final Purchase purchase;
  AddPurchase(this.purchase);
}

class UpdatePurchase extends PurchasesEvent {
  final Purchase purchase;
  UpdatePurchase(this.purchase);
}

class DeletePurchase extends PurchasesEvent {
  final int purchaseId;
  DeletePurchase(this.purchaseId);
}

// States
abstract class PurchasesState {}

class PurchasesLoading extends PurchasesState {}

class PurchasesLoaded extends PurchasesState {
  final List<Purchase> purchases;
  final List<Product> products;
  PurchasesLoaded(this.purchases, this.products);
}

class PurchasesError extends PurchasesState {
  final String message;
  PurchasesError(this.message);
}

// BLoC
class PurchasesBloc extends Bloc<PurchasesEvent, PurchasesState> {
  final PurchasesRepository purchasesRepository;
  final IInventoryRepository inventoryRepository;

  PurchasesBloc({
    required this.purchasesRepository,
    required this.inventoryRepository,
  }) : super(PurchasesLoading()) {
    on<LoadPurchases>((event, emit) async {
      emit(PurchasesLoading());
      try {
        final purchases = await purchasesRepository.getPurchases();
        final products = await inventoryRepository.getProducts();
        emit(PurchasesLoaded(purchases, products));
      } catch (e) {
        emit(PurchasesError(e.toString()));
      }
    });

    on<LoadProducts>((event, emit) async {
      try {
        final currentState = state;
        if (currentState is PurchasesLoaded) {
          final products = await inventoryRepository.getProducts();
          emit(PurchasesLoaded(currentState.purchases, products));
        }
      } catch (e) {
        emit(PurchasesError(e.toString()));
      }
    });

    on<AddPurchase>((event, emit) async {
      emit(PurchasesLoading());
      try {
        await purchasesRepository.addPurchase(event.purchase);
        final purchases = await purchasesRepository.getPurchases();
        final products = await inventoryRepository.getProducts();
        emit(PurchasesLoaded(purchases, products));
      } catch (e) {
        emit(PurchasesError(e.toString()));
      }
    });

    on<UpdatePurchase>((event, emit) async {
      emit(PurchasesLoading());
      try {
        await purchasesRepository.updatePurchase(event.purchase);
        final purchases = await purchasesRepository.getPurchases();
        final products = await inventoryRepository.getProducts();
        emit(PurchasesLoaded(purchases, products));
      } catch (e) {
        emit(PurchasesError(e.toString()));
      }
    });

    on<DeletePurchase>((event, emit) async {
      emit(PurchasesLoading());
      try {
        await purchasesRepository.deletePurchase(event.purchaseId);
        final purchases = await purchasesRepository.getPurchases();
        final products = await inventoryRepository.getProducts();
        emit(PurchasesLoaded(purchases, products));
      } catch (e) {
        emit(PurchasesError(e.toString()));
      }
    });
  }
}

