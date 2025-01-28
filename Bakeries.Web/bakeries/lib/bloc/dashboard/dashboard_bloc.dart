import 'package:flutter_bloc/flutter_bloc.dart';

import '/data/repositories/dashboard_repository.dart';

// Events
abstract class DashboardEvent {}

class LoadDashboard extends DashboardEvent {}

// States
abstract class DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final String latestInventoryUpdate;
  final String latestPurchase;
  final int productCount;
  final String latestProduction;

  DashboardLoaded({
    required this.latestInventoryUpdate,
    required this.latestPurchase,
    required this.productCount,
    required this.latestProduction,
  });
}

class DashboardError extends DashboardState {
  final String message;

  DashboardError(this.message);
}

// BLoC
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository repository;

  DashboardBloc({required this.repository}) : super(DashboardLoading()) {
    on<LoadDashboard>((event, emit) async {
      emit(DashboardLoading());
      try {
        final dashboardData = await repository.getDashboardData();
        emit(DashboardLoaded(
          latestInventoryUpdate: dashboardData.latestInventoryUpdate,
          latestPurchase: dashboardData.latestPurchase,
          productCount: dashboardData.productCount,
          latestProduction: dashboardData.latestProduction,
        ));
      } catch (e) {
        emit(DashboardError(e.toString()));
      }
    });
  }
}

