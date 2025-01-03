import 'package:bakerieswepapp/Screens/ingredients/widgets/ingredients_list.dart';
import 'package:bakerieswepapp/models/product.dart';
import 'package:bakerieswepapp/screens/stock/widgets/add_stock_dialog/add_stock_dialog.dart';
import 'package:bakerieswepapp/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:bakerieswepapp/components/app_bar/app_bar_for_all_page.dart';

class IngredientsScreens extends StatefulWidget {
  final int productId;

  const IngredientsScreens({Key? key, required this.productId})
      : super(key: key);

  @override
  State<IngredientsScreens> createState() => _IngredientsScreensState();
}

class _IngredientsScreensState extends State<IngredientsScreens> {
  @override
  Widget build(BuildContext context) {
    _getProductById(widget.productId);

    return Scaffold(
      appBar: AppBarForAllPage(pageName: 'مكونات المنتج - '),
      body: IngredientsList(
        productId: widget.productId,
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

  void _getProductById(int id) async {
    try {
      Product product = await ProductService.getProductById(id);
      print(product.Name);
    } catch (e) {
      print('Error: $e');
    }
  }
}
