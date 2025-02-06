import 'package:flutter/material.dart';

import '../../Screens/ingredients/widgets/ingredients_list.dart';
import '../../models/product.dart';
import '../../services/product_service.dart';
import 'widgets/add_update_dialog/add_update_dialog.dart';

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
        appBar:  AppBar(
        title: Text('مكونات المنتج - ${_product!.Name}'),
        // إضافة زر الرجوع للخلف
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
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
