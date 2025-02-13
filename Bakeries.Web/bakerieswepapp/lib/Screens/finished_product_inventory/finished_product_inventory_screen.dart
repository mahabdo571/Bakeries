import 'package:bakerieswepapp/Screens/finished_product_inventory/widgets/add_edit_dialog/add_finished_product_inventory_dialog.dart';
import 'package:bakerieswepapp/Screens/finished_product_inventory/widgets/finished_product_inventory_list.dart';
import 'package:flutter/material.dart';



class FinishedProductInventoryScreen extends StatelessWidget {
  const FinishedProductInventoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: const FinishedProductInventoryList(),
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
      builder: (context) => AddFinishedProductInventoryDialog(
        isEdit: false,
        onAdd: (newStock) {
          // Handle add callback
        },
      ),
    );
  }
}
