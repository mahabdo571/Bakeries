import 'package:flutter/material.dart';

import '../../Screens/production/widgets/production_dialog/production_dialog.dart';
import '../../Screens/production/widgets/production_list.dart';
import '../../models/product.dart';
import '../ingredients/widgets/ditels_prouduct.dart';

class ProductionScreen extends StatelessWidget {
  final Product? product;
  const ProductionScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('   عمليات انتاج ${product!.Name}'),
        // إضافة زر الرجوع للخلف
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ditels_prouduct(product: product!),
            flex: 1,
          ),
          Expanded(
            child: ProductionList(product: product!),
            flex: 4,
          ),
        ],
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
      builder: (context) => ProductionDialog(product: product!),
    );
  }
}
