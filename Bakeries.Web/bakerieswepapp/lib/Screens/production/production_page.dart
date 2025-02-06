import '../ingredients/widgets/ditels_prouduct.dart';
import '../../models/product.dart';

import '../../Screens/production/widgets/production_dialog/production_dialog.dart';
import '../../Screens/production/widgets/production_list.dart';
import 'package:flutter/material.dart';
import '../../components/app_bar/app_bar_for_all_page.dart';

class ProductionScreen extends StatelessWidget {
  final Product? product;
  const ProductionScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBarForAllPage(pageName: 'عمليات الانتاج للمنتج ${product!.Name}'),
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
      builder: (context) => ProductionDialog(product:product!),
    );
  }
}
