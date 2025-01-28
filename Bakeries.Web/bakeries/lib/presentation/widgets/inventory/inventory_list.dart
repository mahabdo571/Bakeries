import 'package:flutter/material.dart';

import '/models/product.dart';
import '/presentation/widgets/inventory/product_list_item.dart';
import '/utils/responsive_sizes.dart';

class InventoryList extends StatelessWidget {
  final List<Product> products;
  final Function(Product) onEdit;
  final Function(Product) onDelete;
  final Function(Product) onTap;

  const InventoryList({
    Key? key,
    required this.products,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (ResponsiveSizes.isDesktop(context)) {
      return _buildDesktopView();
    } else {
      return _buildMobileTabletView(context);
    }
  }

  Widget _buildDesktopView() {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductListItem(
          product: product,
          onEdit: () => onEdit(product),
          onDelete: () => onDelete(product),
          onTap: () => onTap(product),
        );
      },
    );
  }

  Widget _buildMobileTabletView(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductListItem(
          product: product,
          onEdit: () => onEdit(product),
          onDelete: () => onDelete(product),
          onTap: () => onTap(product),
        );
      },
    );
  }
}

