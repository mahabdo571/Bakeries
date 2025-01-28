import 'package:flutter/material.dart';
import '/models/product.dart';
import '/presentation/widgets/common/form_fields.dart';

class PurchaseFormSections {
  static Widget buildProductSection({
    required Product? selectedProduct,
    required List<Product> products,
    required Function(Product?) onProductChanged,
    required TextEditingController descriptionController,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormFields.buildDropdownField<Product?>(
          value: selectedProduct,
          items: [null, ...products],
          label: 'اختر المنتج',
          icon: Icons.shopping_cart,
          onChanged: onProductChanged,
          itemBuilder: (product) => Text(product?.itemName ?? 'اختر منتج'),
        ),
        const SizedBox(height: 16),
        FormFields.buildTextField(
          controller: descriptionController,
          label: 'وصف المنتج',
          icon: Icons.description,
          maxLines: 3,
        ),
      ],
    );
  }

  // يمكن إضافة المزيد من الأقسام هنا
}
