import 'package:bakerieswepapp/models/production.dart';
import 'package:bakerieswepapp/screens/production/widgets/production_card.dart';
import 'package:bakerieswepapp/services/production_service.dart';
import 'package:flutter/material.dart';


import '../../../services/ingredients_service.dart';

class ProductionList extends StatefulWidget {
  ProductionList({
    Key? key,
  }) : super(key: key);

  @override
  _ProductionListState createState() => _ProductionListState();
}

class _ProductionListState extends State<ProductionList> {
  late Stream<List<Production>> productionStream;
  @override
  void initState() {
    super.initState();
    productionStream = ProductionService.getProductionStream();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<List<Production>>(
            stream: productionStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('حدث خطأ: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('لا توجد بيانات لعرضها'));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => ProductionCard(
                  production: snapshot.data![index],
                  onEdit: () => _handleEdit(snapshot.data![index]),
                  onDelete: () => _handleDelete(snapshot.data![index].Id),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _handleEdit(Production production) {
    showDialog(
      context: context,
      builder: (context) => Text('ToDo'),
    );
  }

  Future<void> _handleDelete(int id) async {
    try {
      await IngredientsService.deleteProductIngredient(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم حذف العنصر بنجاح')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('فشل في حذف العنصر: $e')),
      );
    }
  }
}
