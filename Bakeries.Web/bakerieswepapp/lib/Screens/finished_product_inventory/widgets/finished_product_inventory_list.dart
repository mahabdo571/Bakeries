import 'package:bakerieswepapp/Screens/finished_product_inventory/widgets/add_edit_dialog/add_finished_product_inventory_dialog.dart';
import 'package:bakerieswepapp/Screens/finished_product_inventory/widgets/finished_product_inventory_card.dart';
import 'package:bakerieswepapp/models/finished_product_inventory.dart';
import 'package:bakerieswepapp/services/finished_product_inventory_service.dart';
import 'package:flutter/material.dart';

import '../../../services/stock_service.dart';


class FinishedProductInventoryList extends StatefulWidget {
  const FinishedProductInventoryList({Key? key}) : super(key: key);

  @override
  _FinishedProductInventoryListState createState() => _FinishedProductInventoryListState();
}

class _FinishedProductInventoryListState extends State<FinishedProductInventoryList> {
  late Stream<List<FinishedProductInventory>> FinishedProductInventoryStream;

  @override
  void initState() {
    super.initState();
    FinishedProductInventoryStream = FinishedProductInventoryService.getFinishedProductInventoryStream();
  }


  int _calculateCrossAxisCount(double width) {
    if (width >= 1240) {
      return 4;
    } else if (width >= 630) {
      return 2;
    } else {
      return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = _calculateCrossAxisCount(screenWidth);

    // إعداد المسافات الخارجية والداخلية
    const double padding = 16.0;
    const double spacing = 16.0;
    // تحديد ارتفاع ثابت للكرت لضمان عرض كل المحتويات
    const double desiredCardHeight = 420.0;

    return StreamBuilder<List<FinishedProductInventory>>(
      stream: FinishedProductInventoryStream,
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

        return Padding(
          padding: const EdgeInsets.all(padding),
          child: GridView.builder(
            itemCount: snapshot.data!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
              // استخدام mainAxisExtent لتحديد ارتفاع ثابت لكل كرت
              mainAxisExtent: desiredCardHeight,
            ),
            itemBuilder: (context, index) => FinishedProductInventoryCard(
              finishedProductInventory: snapshot.data![index],
              onEdit: _handleEdit,
              onDelete: _handleDelete,
            ),
          ),
        );
      },
    );
  }

  void _handleEdit(FinishedProductInventory fpi) {
    showDialog(
      context: context,
      builder: (context) => AddFinishedProductInventoryDialog(
        isEdit: true,
        stockData: fpi.toJson(),
        onAdd: (newStock) {
          // يمكن معالجة عملية التعديل هنا
        },
      ),
    );
  }

  Future<void> _handleDelete(int id) async {
    try {
      await StockService.deleteStock(id);
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
