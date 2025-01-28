import 'package:flutter_bloc/flutter_bloc.dart';
import '/data/repositories/production_repository.dart';
import '/models/production.dart';

// Events
abstract class ProductionEvent {}

class LoadProduction extends ProductionEvent {}

class AddProduction extends ProductionEvent {
  final Production production;
  AddProduction(this.production);
}

// States
abstract class ProductionState {}

class ProductionLoading extends ProductionState {}

class ProductionLoaded extends ProductionState {
  final List<Production> productions;

  ProductionLoaded(this.productions);
}

class ProductionError extends ProductionState {
  final String message;

  ProductionError(this.message);
}

// BLoC
class ProductionBloc extends Bloc<ProductionEvent, ProductionState> {
  final ProductionRepository repository;

  ProductionBloc({required this.repository}) : super(ProductionLoading()) {
    on<LoadProduction>((event, emit) async {
      emit(ProductionLoading());
      try {
        final productions = await repository.getProductions();
        emit(ProductionLoaded(productions));
      } catch (e) {
        emit(ProductionError(e.toString()));
      }
    });

    on<AddProduction>((event, emit) async {
      emit(ProductionLoading());
      try {
        await repository.addProduction(event.production);
        final productions = await repository.getProductions();
        emit(ProductionLoaded(productions));
      } catch (e) {
        emit(ProductionError(e.toString()));
      }
    });
  }
}

