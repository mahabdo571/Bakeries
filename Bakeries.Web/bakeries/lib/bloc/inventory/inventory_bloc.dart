import 'package:flutter_bloc/flutter_bloc.dart';
import '/domain/repositories/i_inventory_repository.dart';
import '/models/product.dart';

// Events
abstract class InventoryEvent {}

class LoadInventory extends InventoryEvent {}

class AddProduct extends InventoryEvent {
  final Product product;
  AddProduct(this.product);
}

class UpdateProduct extends InventoryEvent {
  final Product product;
  UpdateProduct(this.product);
}

class DeleteProduct extends InventoryEvent {
  final int productId;
  DeleteProduct(this.productId);
}

// States
abstract class InventoryState {}

class InventoryLoading extends InventoryState {}

class InventoryLoaded extends InventoryState {
  final List<Product> products;
  InventoryLoaded(this.products);
}

class InventoryError extends InventoryState {
  final String message;
  InventoryError(this.message);
}

// BLoC
class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final IInventoryRepository repository;

  InventoryBloc({required this.repository}) : super(InventoryLoading()) {
    on<LoadInventory>((event, emit) async {
      emit(InventoryLoading());
      try {
        final products = await repository.getProducts();
        emit(InventoryLoaded(products));
      } catch (e) {
        emit(InventoryError(e.toString()));
      }
    });

    on<AddProduct>((event, emit) async {
      emit(InventoryLoading());
      try {
        await repository.addProduct(event.product);
        final products = await repository.getProducts();
        emit(InventoryLoaded(products));
      } catch (e) {
        emit(InventoryError(e.toString()));
      }
    });

    on<UpdateProduct>((event, emit) async {
      emit(InventoryLoading());
      try {
        await repository.updateProduct(event.product);
        final products = await repository.getProducts();
        emit(InventoryLoaded(products));
      } catch (e) {
        emit(InventoryError(e.toString()));
      }
    });

    on<DeleteProduct>((event, emit) async {
      emit(InventoryLoading());
      try {
        await repository.deleteProduct(event.productId);
        final products = await repository.getProducts();
        emit(InventoryLoaded(products));
      } catch (e) {
        emit(InventoryError(e.toString()));
      }
    });
  }
}

