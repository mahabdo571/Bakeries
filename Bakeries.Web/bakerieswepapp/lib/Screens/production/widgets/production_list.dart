import 'package:flutter/material.dart';

import '../../../models/product.dart';
import '../../../models/production.dart';
import '../../../services/production_service.dart';
import 'production_card.dart';
import 'production_dialog/details_dialog.dart';
import 'production_dialog/production_dialog.dart';

class ProductionList extends StatefulWidget {
  final Product product;
  ProductionList({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _ProductionListState createState() => _ProductionListState();
}

class _ProductionListState extends State<ProductionList> {
  late Stream<List<Production>> productionStream;
  @override
  void initState() {
    super.initState();
    productionStream = ProductionService.getProductionStream(widget.product.Id);
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
                padding: const EdgeInsets.all(10),
                shrinkWrap: false,
                physics: BouncingScrollPhysics(), // يجعل التمرير سلسًا
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => ProductionCard(
                  production: snapshot.data![index],
                  product:widget.product,
                  onEdit: () => _handleEdit(snapshot.data![index]),
                  onDelete: () => _handleDelete(snapshot.data![index].Id),
                  onDetails: () => _handleDetails(snapshot.data![index].Id),
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
      builder: (context) => ProductionDialog(product:widget.product,
        ProductionData: production.toJson(),
        isEdit: true,
      ),
    );
  }

  void _handleDetails(int productionId) {
    showDialog(
      context: context,
      builder: (context) => DetailsDialog(productionId: productionId),
    );
  }

  Future<void> _handleDelete(int id) async {
    try {
      await ProductionService.deleteProduction(id);
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

