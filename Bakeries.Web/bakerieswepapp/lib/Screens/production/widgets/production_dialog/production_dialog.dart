import 'package:bakerieswepapp/Screens/production/widgets/production_dialog/production_form.dart';
import 'package:bakerieswepapp/models/production.dart';
import 'package:flutter/material.dart';

class ProductionDialog extends StatelessWidget {
  final bool isEdit;
  final Map<String, dynamic>? ProductionData;
  final Function(Map<String, dynamic>)? onAdd;
  final Function(Map<String, dynamic>)? onEdit;

  const ProductionDialog({
    Key? key,
    this.isEdit = false,
    this.ProductionData,
    this.onAdd,
    this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isEdit ? 'تعديل العملية' : 'إضافة  عملية  جديد'),
      content: ProductionForm(
        isEdit: isEdit,
        ProductionData: ProductionData,
        onSubmit: (p) => _handleSubmit(context, p),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('إلغاء'),
        ),
      ],
    );
  }

  Future<void> _handleSubmit(BuildContext context, Production product) async {
    try {
      if (isEdit) {
        //await ProductService.updateProduct(product.Id, product);

        onEdit?.call(product.toJson());
      } else {
        // final newProduct = await ProductService.addProduct(product);
        //  onAdd?.call(newProduct.toJson());
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
