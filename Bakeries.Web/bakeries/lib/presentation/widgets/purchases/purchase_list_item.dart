import 'package:flutter/material.dart';

import '/models/purchase.dart';
import '/utils/responsive_sizes.dart';

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
    return RepaintBoundary(
      child: ResponsiveSizes.isDesktop(context)
          ? _buildDesktopItem(context)
          : _buildMobileTabletItem(context),
    );
  }

  Widget _buildDesktopItem(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                purchase.itemName,
                style: Theme.of(context).textTheme.headlineLarge,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const SizedBox(height: 8),
              Text(
                'الكمية: ${purchase.quantity} ${purchase.unitOfMeasure}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'المورد: ${purchase.supplierName}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'السعر الإجمالي: ${purchase.totalPrice} ريال',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: onEdit,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: onDelete,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileTabletItem(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(purchase.itemName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('الكمية: ${purchase.quantity} ${purchase.unitOfMeasure}'),
            Text('المورد: ${purchase.supplierName}'),
            Text('السعر الإجمالي: ${purchase.totalPrice} ريال'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
