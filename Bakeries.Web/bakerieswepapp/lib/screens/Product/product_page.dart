import 'package:flutter/material.dart';

import '../../Screens/product/widgets/product_dialog/product_dialog.dart';
import 'widgets/product_list.dart';

class ProductScreens extends StatelessWidget {
  const ProductScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 
      body: const ProductList(),
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
      builder: (context) => ProductDialog(
        isEdit: false,
        onAdd: (newStock) {},
      ),
    );
  }
}
