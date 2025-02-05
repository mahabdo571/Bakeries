import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/production.dart';
import '../../Product/widgets/product_detail_item.dart';

/// عنصر البطاقة لعرض معلومات الإنتاج
class ProductionCard extends StatelessWidget {
  final Production production;
  final VoidCallback onEdit;
  final VoidCallback onDetails;
  final VoidCallback onDelete;

  const ProductionCard({
    Key? key,
    required this.production,
    required this.onEdit,
    required this.onDelete,
    required this.onDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const Divider(height: 24, thickness: 1),
            _buildDetails(),
            const Divider(height: 24, thickness: 1),
            _buildActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.brown.shade100,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.inventory, color: Colors.brown, size: 32),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                production.ProductName ?? '',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                production.Notes,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetails() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ProductDetailItem(
              icon: Icons.production_quantity_limits,
              label: 'الكمية المنتجة',
              value: production.QuantityProduced.toString(),
            ),
            ProductDetailItem(
              icon: Icons.error,
              label: 'الكمية التالفة',
              value: production.QuantityDamaged.toString(),
            ),
            ProductDetailItem(
              icon: Icons.category,
              label: 'الوحدة',
              value: 'كيلو غرام',
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ProductDetailItem(
              icon: Icons.production_quantity_limits,
              label: 'تاريخ الانتاج',
              value: DateFormat('dd/MM/yyyy (HH:mm)')
                  .format(production.CreatedAt ?? DateTime.now())
                  .toString(),
            ),
            ProductDetailItem(
              icon: Icons.error,
              label: 'تاريخ التعديل',
              value: DateFormat('dd/MM/yyyy (HH:mm)')
                  .format(production.UpdatedAt ?? DateTime.now())
                  .toString(),
            ),
           
          ],
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton.icon(
          onPressed: onDetails,
          icon: const Icon(Icons.edit, color: Colors.white),
          label: const Text('تفاصيل'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.green,
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton.icon(
          onPressed: onEdit,
          icon: const Icon(Icons.edit, color: Colors.white),
          label: const Text('تعديل'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.blue,
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton.icon(
          onPressed: onDelete,
          icon: const Icon(Icons.delete, color: Colors.white),
          label: const Text('حذف'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.red,
          ),
        ),
      ],
    );
  }
}
