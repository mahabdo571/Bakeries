import 'dart:async';
import 'add_purchase_dialog/add_purchase_dialog.dart';
import 'package:flutter/material.dart';
import '../../../models/Purchase.dart';
import 'purchase_card.dart';
import '../../../services/purchases_service.dart';

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

  @override
  Widget build(BuildContext context) {
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

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) => PurchaseCard(
            purchase: snapshot.data![index],
            onEdit: () => _handleEdit(snapshot.data![index]),
            onDelete: () => _handleDelete(snapshot.data![index].Id),
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
        purchaseData: purchase.toJson() ,
        onAdd: (newPurchase) {
          // Handle add callback
        },
      ),
    );

  }

  void _handleDelete(int id) async {
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
