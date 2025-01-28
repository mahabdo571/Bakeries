import 'package:flutter/material.dart';

import '/models/purchase.dart';

class PurchaseDetailsDialog extends StatelessWidget {
  final Purchase purchase;

  const PurchaseDetailsDialog({Key? key, required this.purchase})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(purchase.itemName),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('وصف المنتج'),
              subtitle: Text(purchase.itemDescription),
            ),
            ListTile(
              title: Text('ملاحظات'),
              subtitle: Text(purchase.notes),
            ),
            ListTile(
              title: Text('المورد'),
              subtitle: Text(purchase.supplierName),
            ),
            ListTile(
              title: Text('رقم المنتج'),
              subtitle: Text(purchase.itemId.toString()),
            ),
            ListTile(
              title: Text('رقم فاتورة المورد'),
              subtitle: Text(purchase.supplierInvoiceNumber),
            ),
            ListTile(
              title: Text('الكمية'),
              subtitle: Text('${purchase.quantity} ${purchase.unitOfMeasure}'),
            ),
            ListTile(
              title: Text('سعر الوحدة'),
              subtitle: Text('${purchase.unitPrice} ريال'),
            ),
            ListTile(
              title: Text('السعر الإجمالي'),
              subtitle: Text('${purchase.totalPrice} ريال'),
            ),
            ListTile(
              title: Text('طريقة الدفع'),
              subtitle: Text(purchase.paymentMethod),
            ),
            ListTile(
              title: Text('الحالة'),
              subtitle: Text(purchase.status),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('إغلاق'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
