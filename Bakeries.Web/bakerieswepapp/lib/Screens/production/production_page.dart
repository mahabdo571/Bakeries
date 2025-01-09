import 'package:bakerieswepapp/Screens/production/widgets/production_list.dart';
import 'package:flutter/material.dart';
import '../../components/app_bar/app_bar_for_all_page.dart';

class ProductionScreen extends StatelessWidget {
  const ProductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarForAllPage(pageName: 'عمليات الانتاج'),
      body: ProductionList(productId: productId, product: product),
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
      builder: (context) => Text('fff'),
    );
  }
}
