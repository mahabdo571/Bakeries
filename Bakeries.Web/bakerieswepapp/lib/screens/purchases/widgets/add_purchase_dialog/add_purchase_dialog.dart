import 'package:flutter/material.dart';
import '../../../../models/Purchase.dart';
import 'purchase_form.dart';
import '../../../../services/purchases_service.dart';

class AddPurchaseDialog extends StatelessWidget {
  final bool isEdit;
  final Map<String, dynamic>? purchaseData;
  final Function(Map<String, dynamic>)? onAdd;
  final Function(Map<String, dynamic>)? onEdit;

  const AddPurchaseDialog({
    Key? key,
    this.isEdit = false,
    this.purchaseData,
    this.onAdd,
    this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isEdit ? 'تعديل عملية شراء' : 'إضافة عملية شراء'),
      content: PurchaseForm(
        isEdit: isEdit,
        purchaseData: purchaseData,
        onSubmit: (purchase) => _handleSubmit(context, purchase),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('إلغاء'),
        ),
      ],
    );
  }

  Future<void> _handleSubmit(BuildContext context, Purchase purchase) async {
    try {
      
      if (isEdit) {
         await PurchasesService.updatePurchase(purchase.Id, purchase);
         
         onEdit?.call(purchase.toJson());
      } else {
  
        final newPurchase = await PurchasesService.addPurchase(purchase);
        onAdd?.call(newPurchase.toJson());
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم ${isEdit ? "تعديل" : "إضافة"} عملية الشراء بنجاح')),
      );
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ: $e')),
      );
    }
  }
}