import 'package:flutter/material.dart';

import '/models/purchase.dart';

class PurchaseListItem extends StatelessWidget {
  final Purchase purchase;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const PurchaseListItem({
    Key? key,
    required this.purchase,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(purchase.itemName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('الكمية: ${purchase.quantity} ${purchase.unitOfMeasure}'),
            Text('السعر الإجمالي: ${purchase.totalPrice} ريال'),
            Text('المورد: ${purchase.supplierName}'),
            Text('الحالة: ${purchase.status}'),
          ],
        ),
        trailing: Text('رقم الفاتورة: ${purchase.supplierInvoiceNumber}'),
        onTap: onTap,
      ),
    );
  }
}

