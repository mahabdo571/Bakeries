import 'package:flutter/material.dart';

import 'widgets/add_purchase_dialog/add_purchase_dialog.dart';
import 'widgets/purchase_list.dart';

class PurchasesPage extends StatelessWidget {
  const PurchasesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 
      body: const PurchaseList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddPurchaseDialog(context),
        backgroundColor: Colors.brown,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddPurchaseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddPurchaseDialog(
        isEdit: false,
        onAdd: (newPurchase) {
          // Handle add callback
        },
      ),
    );
  }
}
