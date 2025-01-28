import 'package:flutter_bloc/flutter_bloc.dart';
import '/data/repositories/purchases_repository.dart';
import '/models/purchase.dart';

// Events
abstract class PurchasesEvent {}

class LoadPurchases extends PurchasesEvent {}

class AddPurchase extends PurchasesEvent {
  final Purchase purchase;
  AddPurchase(this.purchase);
}

// States
abstract class PurchasesState {}

class PurchasesLoading extends PurchasesState {}

class PurchasesLoaded extends PurchasesState {
  final List<Purchase> purchases;

  PurchasesLoaded(this.purchases);
}

class PurchasesError extends PurchasesState {
  final String message;

  PurchasesError(this.message);
}

// BLoC
class PurchasesBloc extends Bloc<PurchasesEvent, PurchasesState> {
  final PurchasesRepository repository;

  PurchasesBloc({required this.repository}) : super(PurchasesLoading()) {
    on<LoadPurchases>((event, emit) async {
      emit(PurchasesLoading());
      try {
        final purchases = await repository.getPurchases();
        emit(PurchasesLoaded(purchases));
      } catch (e) {
        emit(PurchasesError(e.toString()));
      }
    });

    on<AddPurchase>((event, emit) async {
      emit(PurchasesLoading());
      try {
        await repository.addPurchase(event.purchase);
        final purchases = await repository.getPurchases();
        emit(PurchasesLoaded(purchases));
      } catch (e) {
        emit(PurchasesError(e.toString()));
      }
    });
  }
}

