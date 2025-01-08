import 'package:bakerieswepapp/Screens/ingredients/widgets/add_update_dialog/add_updte_form.dart';
import 'package:bakerieswepapp/models/product_ingredient.dart';
import 'package:bakerieswepapp/services/ingredients_service.dart';

import 'package:flutter/material.dart';

class AddUpdateDialog extends StatelessWidget {
  final bool isEdit;
  final Map<String, dynamic>? stockData;
  final Function(Map<String, dynamic>)? onAdd;
  final Function(Map<String, dynamic>)? onEdit;
  final int productId;
  const AddUpdateDialog({
    Key? key,
    this.isEdit = false,
    this.stockData,
    this.onAdd,
    this.onEdit,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isEdit ? 'تعديل عملية شراء' : 'إضافة عملية شراء'),
      content: AddUpdateForm(
        isEdit: isEdit,
        productId: productId,
        productIngredientData: stockData,
        onSubmit: (purchase) => _handleSubmit(context, purchase),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('إلغاء'),
        ),
      ],
    );
  }

  Future<void> _handleSubmit(
      BuildContext context, ProductIngredient productIngredient) async {
    try {
      if (isEdit) {
        //await StockService.updateStock(stock.Id,);

        onEdit?.call(productIngredient.toJson());
      } else {
        final newstock =
            await IngredientsService.addProductIngredient(productIngredient);
        onAdd?.call(newstock.toJson());
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('تم ${isEdit ? "تعديل" : "إضافة"} عملية الشراء بنجاح')),
      );
      Navigator.of(context).pop();
    } catch (e) {
      print('ddddd $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ: $e')),
      );
    }
  }
}
