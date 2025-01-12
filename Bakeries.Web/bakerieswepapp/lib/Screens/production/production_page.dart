import '../../Screens/production/widgets/production_dialog/production_dialog.dart';
import '../../Screens/production/widgets/production_list.dart';
import 'package:flutter/material.dart';
import '../../components/app_bar/app_bar_for_all_page.dart';

class ProductionScreen extends StatelessWidget {
  const ProductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarForAllPage(pageName: 'عمليات الانتاج'),
      body: ProductionList(),
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
      builder: (context) => ProductionDialog(),
    );
  }
}
