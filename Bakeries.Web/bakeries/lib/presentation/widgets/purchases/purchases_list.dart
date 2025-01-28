import 'package:flutter/material.dart';
import '/models/purchase.dart';
import '/presentation/widgets/purchases/purchase_list_item.dart';
import '/utils/responsive_sizes.dart';

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
      cacheExtent: 500,
      itemCount: purchases.length,
      itemBuilder: (context, index) {
        final purchase = purchases[index];
        return PurchaseListItem(
          key: ValueKey(purchase.id),
          purchase: purchase,
          onEdit: () => onEdit(purchase),
          onDelete: () => onDelete(purchase),
          onTap: () => onTap(purchase),
        );
      },
    );
  }

  Widget _buildMobileTabletView(BuildContext context) {
    return ListView.builder(
      itemCount: purchases.length,
      cacheExtent: 500,
      itemBuilder: (context, index) {
        final purchase = purchases[index];
        return PurchaseListItem(
          key: ValueKey(purchase.id),
          purchase: purchase,
          onEdit: () => onEdit(purchase),
          onDelete: () => onDelete(purchase),
          onTap: () => onTap(purchase),
        );
      },
    );
  }
}
