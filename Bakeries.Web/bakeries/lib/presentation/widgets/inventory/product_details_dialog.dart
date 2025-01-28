import 'package:flutter/material.dart';
import '/models/product.dart';

class ProductDetailsDialog extends StatelessWidget {
  final Product product;

  const ProductDetailsDialog({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(product.itemName),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading:
                Icon(Icons.inventory, color: Theme.of(context).primaryColor),
            title: Text('الكمية المتوفرة'),
            subtitle:
                Text('${product.availableQuantity} ${product.unitOfMeasure}'),
          ),
          ListTile(
            leading: Icon(Icons.refresh, color: Theme.of(context).primaryColor),
            title: Text('مستوى إعادة الطلب'),
            subtitle: Text('${product.reorderLevel}'),
          ),
          ListTile(
            leading:
                Icon(Icons.location_on, color: Theme.of(context).primaryColor),
            title: Text('الموقع'),
            subtitle: Text(product.location),
          ),
          ListTile(
            leading: Icon(Icons.note, color: Theme.of(context).primaryColor),
            title: Text('ملاحظات'),
            subtitle: Text(product.notes),
          ),
        ],
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
