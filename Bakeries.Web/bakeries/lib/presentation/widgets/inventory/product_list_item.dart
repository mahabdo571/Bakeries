import 'package:flutter/material.dart';

import '/models/product.dart';
import '/utils/responsive_sizes.dart';

class ProductListItem extends StatelessWidget {
  final Product product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const ProductListItem({
    Key? key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (ResponsiveSizes.isDesktop(context)) {
      return _buildDesktopItem(context);
    } else {
      return _buildMobileTabletItem(context);
    }
  }

  Widget _buildDesktopItem(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.itemName,
                style: Theme.of(context).textTheme.headlineLarge,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8),
              Text(
                'الكمية: ${product.availableQuantity} ${product.unitOfMeasure}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: 8),
              Text(
                'الموقع: ${product.location}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: onEdit,
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
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
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(product.itemName),
        subtitle: Text('الكمية: ${product.availableQuantity} ${product.unitOfMeasure}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}

