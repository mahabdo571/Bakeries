import 'package:bakerieswepapp/Screens/ingredients/widgets/ingredients_list.dart';
import 'package:bakerieswepapp/screens/Product/widgets/product_list.dart';
import 'package:bakerieswepapp/screens/stock/widgets/add_stock_dialog/add_stock_dialog.dart';
import 'package:flutter/material.dart';
import 'package:bakerieswepapp/components/app_bar/app_bar_for_all_page.dart';

class IngredientsScreens extends StatelessWidget {
  final int productId;
  const IngredientsScreens({Key? key, required this.productId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarForAllPage(pageName: 'مكونات المنتج - $productId'),
      body: IngredientsList(
        productId: productId,
      ),
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
