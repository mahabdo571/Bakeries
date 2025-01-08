import 'widgets/add_update_dialog/add_update_dialog.dart';

import '../../Screens/ingredients/widgets/ingredients_list.dart';
import '../../models/product.dart';
import '../../services/product_service.dart';
import 'package:flutter/material.dart';
import '../../components/app_bar/app_bar_for_all_page.dart';

class IngredientsScreens extends StatefulWidget {
  final int productId;

  const IngredientsScreens({Key? key, required this.productId})
      : super(key: key);

  @override
  State<IngredientsScreens> createState() => _IngredientsScreensState();
}

class _IngredientsScreensState extends State<IngredientsScreens> {
  Product? _product;
  @override
  void initState() {
    super.initState();
    _getProductById(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    if (_product == null) {
      return Scaffold(
        appBar: AppBarForAllPage(pageName: ''),
        body: Center(
          child: CircularProgressIndicator(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddDialog(context),
          backgroundColor: Colors.brown,
          child: const Icon(Icons.add),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBarForAllPage(pageName: 'مكونات المنتج - ${_product!.Name}'),
        body: IngredientsList(
          productId: widget.productId,
          product: _product!,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddDialog(context),
          backgroundColor: Colors.brown,
          child: const Icon(Icons.add),
        ),
      );
    }
  }

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddUpdateDialog(
        productId: widget.productId,
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
      setState(() {
        _product = product;
      });
    } catch (e) {
      print('Error: $e');
      throw Exception('Unexpected response format');
    }
  }
}
