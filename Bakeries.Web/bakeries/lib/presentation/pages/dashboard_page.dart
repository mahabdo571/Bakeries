import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/bloc/dashboard/dashboard_bloc.dart';
import '/presentation/widgets/dashboard_card.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    // Load dashboard data when the page is initialized
    context.read<DashboardBloc>().add(LoadDashboard());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('لوحة التحكم الرئيسية'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is DashboardLoaded) {
            return GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(16),
              childAspectRatio: 1.5,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                DashboardCard(
                  title: 'المخزن',
                  content: 'آخر تحديث: ${state.latestInventoryUpdate}',
                  icon: Icons.inventory,
                  onTap: () {
                    // Navigate to Inventory page
                  },
                ),
                DashboardCard(
                  title: 'المشتريات',
                  content: 'آخر عملية شراء: ${state.latestPurchase}',
                  icon: Icons.shopping_cart,
                  onTap: () {
                    // Navigate to Purchases page
                  },
                ),
                DashboardCard(
                  title: 'المنتجات',
                  content: 'عدد المنتجات: ${state.productCount}',
                  icon: Icons.category,
                  onTap: () {
                    // Navigate to Products page
                  },
                ),
                DashboardCard(
                  title: 'عمليات الإنتاج',
                  content: 'آخر عملية إنتاج: ${state.latestProduction}',
                  icon: Icons.build,
                  onTap: () {
                    // Navigate to Production page
                  },
                ),
              ],
            );
          } else if (state is DashboardError) {
            return Center(child: Text('حدث خطأ: ${state.message}'));
          }
          return Container();
        },
      ),
    );
  }
}

