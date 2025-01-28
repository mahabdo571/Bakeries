import 'package:flutter_bloc/flutter_bloc.dart';
import '/data/repositories/products_repository.dart';
import '/models/product.dart';

// Events
abstract class ProductsEvent {}

class LoadProducts extends ProductsEvent {}

class AddProduct extends ProductsEvent {
  final Product product;
  AddProduct(this.product);
}

// States
abstract class ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<Product> products;
  ProductsLoaded(this.products);
}

class ProductsError extends ProductsState {
  final String message;
  ProductsError(this.message);
}

// BLoC
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepository repository;

  ProductsBloc({required this.repository}) : super(ProductsLoading()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductsLoading());
      try {
        final products = await repository.getProducts();
        emit(ProductsLoaded(products));
      } catch (e) {
        emit(ProductsError(e.toString()));
      }
    });

    on<AddProduct>((event, emit) async {
      final currentState = state;
      if (currentState is ProductsLoaded) {
        emit(ProductsLoading());
        try {
          await repository.addProduct(event.product);
          final updatedProducts = await repository.getProducts();
          emit(ProductsLoaded(updatedProducts));
        } catch (e) {
          emit(ProductsError(e.toString()));
        }
      }
    });
  }
}

