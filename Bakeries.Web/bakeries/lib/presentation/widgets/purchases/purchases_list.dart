import 'package:flutter/material.dart';
import '/models/purchase.dart';
import '/presentation/widgets/purchases/purchase_list_item.dart';

class PurchasesList extends StatelessWidget {
  final List<Purchase> purchases;
  final Function(Purchase) onEdit;
  final Function(Purchase) onDelete;
  final Function(Purchase) onTap;

  const PurchasesList({
    Key? key,
    required this.purchases,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: purchases.length,
      itemBuilder: (context, index) {
        final purchase = purchases[index];
        return PurchaseListItem(
          purchase: purchase,
          onEdit: () => onEdit(purchase),
          onDelete: () => onDelete(purchase),
          onTap: () => onTap(purchase),
        );
      },
    );
  }
}

