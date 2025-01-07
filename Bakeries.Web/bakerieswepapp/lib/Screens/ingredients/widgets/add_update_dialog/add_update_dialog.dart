import 'package:bakerieswepapp/Screens/ingredients/widgets/add_update_dialog/add_updte_form.dart';

import '../../../../models/Stock.dart';
import '../../../../services/stock_service.dart';
import 'package:flutter/material.dart';

class AddUpdateDialog extends StatelessWidget {
  final bool isEdit;
  final Map<String, dynamic>? stockData;
  final Function(Map<String, dynamic>)? onAdd;
  final Function(Map<String, dynamic>)? onEdit;

  const AddUpdateDialog({
    Key? key,
    this.isEdit = false,
    this.stockData,
    this.onAdd,
    this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isEdit ? 'تعديل عملية شراء' : 'إضافة عملية شراء'),
      content: AddUpdateForm(
        isEdit: isEdit,
        stockData: stockData,
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

  Future<void> _handleSubmit(BuildContext context, Stock stock) async {
    try {
      if (isEdit) {
        await StockService.updateStock(stock.Id, stock);

        onEdit?.call(stock.toJson());
      } else {
        final newstock = await StockService.addStock(stock);
        onAdd?.call(newstock.toJson());
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('تم ${isEdit ? "تعديل" : "إضافة"} عملية الشراء بنجاح')),
      );
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ: $e')),
      );
    }
  }
}
