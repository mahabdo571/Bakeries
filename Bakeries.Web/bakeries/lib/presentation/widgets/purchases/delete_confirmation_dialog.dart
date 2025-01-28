import 'package:flutter/material.dart';

import '/models/purchase.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final Purchase purchase;
  final VoidCallback onConfirm;

  const DeleteConfirmationDialog({
    Key? key,
    required this.purchase,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('تأكيد الحذف'),
      content:
          Text('هل أنت متأكد أنك تريد حذف عملية شراء ${purchase.itemName}؟'),
      actions: [
        TextButton(
          child: Text('إلغاء'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: Text('حذف'),
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
