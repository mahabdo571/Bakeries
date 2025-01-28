import 'package:flutter/material.dart';
import '/models/purchase.dart';
import '/utils/responsive_sizes.dart';

class PurchaseDetailsDialog extends StatelessWidget {
  final Purchase purchase;

  const PurchaseDetailsDialog({
    Key? key,
    required this.purchase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveSizes.isDesktop(context);
    final isMobile = ResponsiveSizes.isMobile(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: isDesktop ? 600 : (isMobile ? double.infinity : 400),
        constraints: BoxConstraints(
          maxHeight:
              MediaQuery.of(context).size.height * (isDesktop ? 0.8 : 0.9),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Padding(
              padding: EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'تفاصيل عملية الشراء',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Divider(height: 1),
            // Scrollable Content
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow(
                      context,
                      icon: Icons.shopping_cart,
                      label: 'المنتج',
                      value: purchase.itemName,
                    ),
                    _buildDetailRow(
                      context,
                      icon: Icons.description,
                      label: 'الوصف',
                      value: purchase.itemDescription,
                    ),
                    _buildDetailRow(
                      context,
                      icon: Icons.person,
                      label: 'المورد',
                      value: purchase.supplierName,
                    ),
                    _buildDetailRow(
                      context,
                      icon: Icons.receipt,
                      label: 'رقم الفاتورة',
                      value: purchase.supplierInvoiceNumber,
                    ),
                    _buildDetailRow(
                      context,
                      icon: Icons.format_list_numbered,
                      label: 'الكمية',
                      value: '${purchase.quantity} ${purchase.unitOfMeasure}',
                    ),
                    _buildDetailRow(
                      context,
                      icon: Icons.attach_money,
                      label: 'سعر الوحدة',
                      value: '${purchase.unitPrice} ريال',
                    ),
                    _buildDetailRow(
                      context,
                      icon: Icons.shopping_cart_checkout,
                      label: 'السعر الإجمالي',
                      value: '${purchase.totalPrice} ريال',
                    ),
                    _buildDetailRow(
                      context,
                      icon: Icons.payment,
                      label: 'طريقة الدفع',
                      value: purchase.paymentMethod,
                    ),
                    _buildDetailRow(
                      context,
                      icon: Icons.info_outline,
                      label: 'الحالة',
                      value: purchase.status,
                    ),
                    if (purchase.notes.isNotEmpty)
                      _buildDetailRow(
                        context,
                        icon: Icons.note,
                        label: 'ملاحظات',
                        value: purchase.notes,
                      ),
                  ],
                ),
              ),
            ),
            // Footer
            Divider(height: 1),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: Text('إغلاق'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Theme.of(context).primaryColor),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
