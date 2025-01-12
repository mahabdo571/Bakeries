import 'package:flutter/material.dart';

import '../../components/app_bar/app_bar_for_all_page.dart';
import 'widgets/add_stock_dialog/add_stock_dialog.dart';
import 'widgets/stock_list.dart';

class StockScreens extends StatelessWidget {
  const StockScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarForAllPage(pageName: 'المخزن'),
      body: const StockList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddStockDialog(context),
        backgroundColor: Colors.brown,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddStockDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddStockDialog(
        isEdit: false,
        onAdd: (newStock) {
          // Handle add callback
        },
      ),
    );
  }
}
