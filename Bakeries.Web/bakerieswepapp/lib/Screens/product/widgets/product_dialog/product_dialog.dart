import 'package:bakerieswepapp/Screens/product/widgets/product_dialog/product_form.dart';
import 'package:bakerieswepapp/models/product.dart';
import 'package:bakerieswepapp/services/product_service.dart';
import 'package:flutter/material.dart';

class ProductDialog extends StatelessWidget {
  final bool isEdit;
  final Map<String, dynamic>? productData;
  final Function(Map<String, dynamic>)? onAdd;
  final Function(Map<String, dynamic>)? onEdit;

  const ProductDialog({
    Key? key,
    this.isEdit = false,
    this.productData,
    this.onAdd,
    this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isEdit ? 'تعديل المنتج' : 'إضافة  منتج جديد'),
      content: ProductForm(
        isEdit: isEdit,
        productData: productData,
        onSubmit: (product) => _handleSubmit(context, product),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('إلغاء'),
        ),
      ],
    );
  }

  Future<void> _handleSubmit(BuildContext context, Product product) async {
    try {
      if (isEdit) {
        await ProductService.updateProduct(product.Id, product);

        onEdit?.call(product.toJson());
      } else {
        final newProduct = await ProductService.addProduct(product);
        onAdd?.call(newProduct.toJson());
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم ${isEdit ? "تعديل" : "إضافة"} منتج  بنجاح')),
      );
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ: $e')),
      );
    }
  }
}
