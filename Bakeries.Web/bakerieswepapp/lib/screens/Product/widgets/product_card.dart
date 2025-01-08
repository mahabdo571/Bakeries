import 'package:flutter/material.dart';

import '../../../models/product.dart';
import 'product_detail_item.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function(Product) onEdit;
  final Function(int) onDelete;
  final Function(int) onClickOnTheIngredients;

  const ProductCard({
    Key? key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
    required this.onClickOnTheIngredients,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const Divider(height: 24),
            _buildDetails(),
            const Divider(height: 24),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const Icon(Icons.inventory, color: Colors.brown, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.Name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                product.Notes,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
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
              icon: Icons.inventory,
              label: 'السعر',
              value: product.Price.toString(),
            ),
            ProductDetailItem(
              icon: Icons.inventory,
              label: 'تفاصيل اضافية',
              value: product.Description.toString(),
            ),
            ProductDetailItem(
              icon: Icons.category,
              label: 'الوحدة',
              value: product.Unit,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton.icon(
          onPressed: () => onClickOnTheIngredients(product.Id),
          icon: const Icon(Icons.list, color: Colors.white),
          label: const Text('المكونات'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        ),
        const SizedBox(width: 8),
        ElevatedButton.icon(
          onPressed: () => onEdit(product),
          icon: const Icon(Icons.edit, color: Colors.white),
          label: const Text('تعديل'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        ),
        const SizedBox(width: 8),
        ElevatedButton.icon(
          onPressed: () => onDelete(product.Id),
          icon: const Icon(Icons.delete, color: Colors.white),
          label: const Text('حذف'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        ),
      ],
    );
  }
}
