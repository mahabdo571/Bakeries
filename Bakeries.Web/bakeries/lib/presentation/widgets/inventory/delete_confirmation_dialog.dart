import 'package:flutter/material.dart';
import '/models/product.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final Product product;
  final VoidCallback onConfirm;

  const DeleteConfirmationDialog({
    Key? key,
    required this.product,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('تأكيد الحذف'),
      content: Text('هل أنت متأكد أنك تريد حذف ${product.itemName}؟'),
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

