import 'package:bakerieswepapp/screens/stock/widgets/add_stock_dialog/add_stock_dialog.dart';
import 'package:flutter/material.dart';
import 'package:bakerieswepapp/components/app_bar/app_bar_for_all_page.dart';
import 'package:bakerieswepapp/screens/stock/widgets/stock_list.dart';

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
