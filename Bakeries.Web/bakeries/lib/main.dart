import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/bloc/auth/auth_bloc.dart';
import '/bloc/dashboard/dashboard_bloc.dart';
import '/bloc/inventory/inventory_bloc.dart';
import '/bloc/production/production_bloc.dart';
import '/bloc/products/products_bloc.dart';
import '/bloc/purchases/purchases_bloc.dart';
import '/bloc/settings/settings_bloc.dart';
import '/bloc/theme/theme_bloc.dart';
import '/bloc/users/users_bloc.dart';
import '/data/datasources/inventory_data_source.dart';
import '/data/repositories/dashboard_repository.dart';
import '/data/repositories/inventory_repository_impl.dart';
import '/data/repositories/production_repository.dart';
import '/data/repositories/products_repository.dart';
import '/data/repositories/purchases_repository.dart';
import '/data/repositories/settings_repository.dart';
import '/data/repositories/users_repository.dart';
import '/domain/repositories/i_inventory_repository.dart';
import '/presentation/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => DashboardRepository(),
        ),
        RepositoryProvider<IInventoryRepository>(
          create: (context) => InventoryRepositoryImpl(
            dataSource: InventoryDataSource(),
          ),
        ),
        RepositoryProvider(
          create: (context) => PurchasesRepository(),
        ),
        RepositoryProvider(
          create: (context) => ProductsRepository(),
        ),
        RepositoryProvider(
          create: (context) => ProductionRepository(),
        ),
        RepositoryProvider(
          create: (context) => SettingsRepository(),
        ),
        RepositoryProvider(
          create: (context) => UsersRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ThemeBloc()),
          BlocProvider(create: (context) => AuthBloc()),
          BlocProvider(
            create: (context) => DashboardBloc(
              repository: context.read<DashboardRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => InventoryBloc(
              repository: context.read<IInventoryRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => PurchasesBloc(
              purchasesRepository: PurchasesRepository(),
              inventoryRepository: context.read<IInventoryRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => ProductsBloc(
              repository: context.read<ProductsRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => ProductionBloc(
              repository: context.read<ProductionRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SettingsBloc(
              repository: context.read<SettingsRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => UsersBloc(
              repository: context.read<UsersRepository>(),
            ),
          ),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'لوحة التحكم',
              theme: state.themeData,
              debugShowCheckedModeBanner: false,
              home: HomePage(),
            );
          },
        ),
      ),
    );
  }
}
