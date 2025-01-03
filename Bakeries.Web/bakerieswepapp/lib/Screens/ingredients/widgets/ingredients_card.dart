import 'package:bakerieswepapp/models/product_ingredient.dart';
import 'package:bakerieswepapp/screens/Product/widgets/product_detail_item.dart';
import 'package:flutter/material.dart';

class IngredientsCard extends StatelessWidget {
  final ProductIngredient productIngredient;
  final Function(ProductIngredient) onEdit;
  final Function(int) onDelete;
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
                productIngredient.stock.ItemName,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                productIngredient.product.Name,
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
              value: productIngredient.Quantity.toString(),
            ),
            ProductDetailItem(
              icon: Icons.inventory,
              label: 'تفاصيل اضافية',
              value: productIngredient.UnitOfMeasure.toString(),
            ),
            ProductDetailItem(
              icon: Icons.category,
              label: 'الوحدة',
              value: productIngredient.UnitOfMeasure,
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
          onPressed: () => onEdit(productIngredient),
          icon: const Icon(Icons.edit, color: Colors.white),
          label: const Text('تعديل'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        ),
        const SizedBox(width: 8),
        ElevatedButton.icon(
          onPressed: () => onDelete(productIngredient.Id),
          icon: const Icon(Icons.delete, color: Colors.white),
          label: const Text('حذف'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        ),
      ],
    );
  }
}
