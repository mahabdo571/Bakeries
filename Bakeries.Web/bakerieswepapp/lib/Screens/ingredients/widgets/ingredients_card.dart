import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/product_ingredient.dart';
import '../../Product/widgets/product_detail_item.dart';

class IngredientsCard extends StatelessWidget {
  final ProductIngredient productIngredient;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Function(int) onClickOnTheIngredients;

  const IngredientsCard({
    Key? key,
    required this.productIngredient,
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
                productIngredient.stock!.ItemName,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                productIngredient.product!.Name,
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
              isMobile: false,
              icon: Icons.inventory,
              label: 'الكمية ',
              value: productIngredient.Quantity.toString(),
            ),
            ProductDetailItem(
              isMobile: false,
              icon: Icons.inventory,
              label: 'تفاصيل اضافية',
              value: productIngredient.Notes,
            ),
            ProductDetailItem(
              isMobile: false,
              icon: Icons.category,
              label: 'الوحدة',
              value: productIngredient.UnitOfMeasure,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ProductDetailItem(
              isMobile: false,
              icon: Icons.inventory,
              label: 'تاريخ الاضافة',
              value: DateFormat('dd/MM/yyyy (HH:mm)')
                  .format(productIngredient.CreatedAt ?? DateTime.now())
                  .toString(),
            ),
            ProductDetailItem(
              isMobile: false,
              icon: Icons.inventory,
              label: 'تاريخ التعديل',
              value: DateFormat('dd/MM/yyyy (HH:mm)')
                  .format(productIngredient.UpdatedAt ?? DateTime.now())
                  .toString(),
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
          onPressed: () => onEdit(),
          icon: const Icon(Icons.edit, color: Colors.white),
          label: const Text('تعديل'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        ),
        const SizedBox(width: 8),
        ElevatedButton.icon(
          onPressed: () => onDelete(),
          icon: const Icon(Icons.delete, color: Colors.white),
          label: const Text('حذف'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        ),
      ],
    );
  }
}
