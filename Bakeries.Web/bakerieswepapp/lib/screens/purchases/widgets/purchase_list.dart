
import 'package:flutter/material.dart';
import '../../../models/Purchase.dart';
import '../../../services/purchases_service.dart';
import 'add_purchase_dialog/add_purchase_dialog.dart';
import 'purchase_card.dart';

class PurchaseList extends StatefulWidget {
  const PurchaseList({Key? key}) : super(key: key);

  @override
  _PurchaseListState createState() => _PurchaseListState();
}

class _PurchaseListState extends State<PurchaseList> {
  late Stream<List<Purchase>> purchasesStream;
  

  @override
  void initState() {
    super.initState();
    purchasesStream = PurchasesService.getPurchasesStream();

  }

  /// تحدد عدد الأعمدة حسب عرض الشاشة:
  /// - >= 1024: 4 أعمدة (سطح مكتب)
  /// - >= 600: 2 أعمدة (جهاز لوحي)
  /// - أقل من 600: عمود واحد (موبايل)
  int _calculateCrossAxisCount(double width) {
    if (width >= 1240) {
      return 4;
    } else if (width >= 640) {
      return 2;
    } else {
      return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = _calculateCrossAxisCount(screenWidth);

    // إعداد الثوابت للمسافات والارتفاع الثابت لكل كرت
    const double padding = 16.0;
    const double spacing = 16.0;
    const double desiredCardHeight = 380.0;

    // حساب عرض كل خلية في الشبكة (لاستخدامه إذا أردت التعديل لاحقاً)
    final cellWidth =
        (screenWidth - (2 * padding) - ((crossAxisCount - 1) * spacing)) /
            crossAxisCount;

    return StreamBuilder<List<Purchase>>(
      stream: purchasesStream,
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
              mainAxisExtent: desiredCardHeight,
            ),
            itemBuilder: (context, index) => PurchaseCard(
              purchase: snapshot.data![index],
              onEdit: () => _handleEdit(snapshot.data![index]),
              onDelete: () => _handleDelete(snapshot.data![index].Id),
            ),
          ),
        );
      },
    );
  }

  void _handleEdit(Purchase purchase) {
    showDialog(
      context: context,
      builder: (context) => AddPurchaseDialog(
        isEdit: true,
        isFinishedProductInventory: false,
        purchaseData: purchase.toJson(),
        onAdd: (newPurchase) {
          // معالجة عملية التعديل عند الحاجة
        },
      ),
    );
  }

  Future<void> _handleDelete(int id) async {
    try {
      await PurchasesService.deletePurchase(id);
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
