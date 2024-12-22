import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bakerieswepapp/Model/Purchase.dart'; // استيراد الموديل

class AddPurchaseDialog extends StatefulWidget {
  final bool isEdit;
  final Map<String, dynamic>? purchaseData;
  final Function(Map<String, dynamic>)? onAdd;
  final Function(Map<String, dynamic>)? onEdit;

  AddPurchaseDialog({
    this.isEdit = false,
    this.purchaseData,
    this.onAdd,
    this.onEdit,
  });

  @override
  _AddPurchaseDialogState createState() => _AddPurchaseDialogState();
}

class _AddPurchaseDialogState extends State<AddPurchaseDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _itemDescriptionController;
  late TextEditingController _itemNameController;
  late TextEditingController _notesController;
  late TextEditingController _quantityController;
  late TextEditingController _supplierInvoiceNumberController;
  late TextEditingController _supplierNameController;
  late TextEditingController _totalCostController;
  late TextEditingController _totalPriceController;
  late TextEditingController _unitPriceController;

  final List<String> _statusList = [
    'مدفوع',
    'جديد',
    'مرجعة',
    'ملغي',
    'مؤرشف',
    'مرفوض',
    'جزئية'
  ];
  final List<String> _paymentMethod = ['كاش', 'شيك'];

  final List<String> _units = [
    'غرام',
    'كيلو غرام',
    'طن',
    'لتر',
    'كيلو وات',
    'شيكل'
  ];

  String? _selectedUnit;
  String? _selectedPaymentMethod;
  String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    _itemDescriptionController = TextEditingController(
        text: widget.purchaseData?['ItemDescription'].toString() ?? '');
    _itemNameController =
        TextEditingController(text: widget.purchaseData?['ItemName'] ?? '');
    _notesController =
        TextEditingController(text: widget.purchaseData?['Notes'] ?? '');
    _supplierInvoiceNumberController = TextEditingController(
        text: widget.purchaseData?['SupplierInvoiceNumber'] ?? '');
    _supplierNameController =
        TextEditingController(text: widget.purchaseData?['SupplierName'] ?? '');
    _quantityController = TextEditingController(
        text: widget.purchaseData?['Quantity'].toString() ?? '');
    _totalCostController = TextEditingController(
        text: widget.purchaseData?['TotalCost'].toString() ?? '');
    _totalPriceController = TextEditingController(
        text: widget.purchaseData?['TotalPrice'].toString() ?? '');
    _unitPriceController = TextEditingController(
        text: widget.purchaseData?['UnitPrice'].toString() ?? '');

    _selectedUnit = widget.purchaseData?['UnitOfMeasure'];

    _selectedPaymentMethod = widget.purchaseData?['PaymentMethod'];
    _selectedStatus = widget.purchaseData?['Status'];
  }

  @override
  void dispose() {
    _itemDescriptionController.dispose();
    _itemNameController.dispose();
    _notesController.dispose();
    _quantityController.dispose();
    _supplierInvoiceNumberController.dispose();
    _supplierNameController.dispose();
    _totalCostController.dispose();
    _totalPriceController.dispose();
    _unitPriceController.dispose();
    super.dispose();
  }

  Future<void> submitForm() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final purchase = Purchase(
        Id: widget.isEdit ? widget.purchaseData!['Id'] ?? 0 : 0,
        ItemDescription: _itemDescriptionController.text,
        ItemName: _itemNameController.text,
        Notes: _notesController.text,
        PaymentMethod: _selectedPaymentMethod.toString(),
        Quantity: int.tryParse(_quantityController.text) ?? 0,
        Status: _selectedStatus.toString(),
        SupplierInvoiceNumber: _supplierInvoiceNumberController.text,
        SupplierName: _supplierNameController.text,
        TotalCost: double.tryParse(_totalCostController.text) ?? 0.0,
        TotalPrice: double.tryParse(_totalPriceController.text) ?? 0.0,
        UnitOfMeasure: _selectedUnit.toString(),
        UnitPrice: double.tryParse(_unitPriceController.text) ?? 0.0,
      );

      final url = widget.isEdit
          ? Uri.parse('http://localhost:5145/api/Purchases/${purchase.Id}')
          : Uri.parse('http://localhost:5145/api/Purchases/');

      final purchaseTojson = purchase.toJson();

      try {
        final response = widget.isEdit
            ? await http.put(
                url,
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode(purchaseTojson),
              )
            : await http.post(
                url,
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode(purchaseTojson),
              );

        if (response.statusCode == 200 || response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Purchase ${widget.isEdit ? "updated" : "added"} successfully!')),
          );

          widget.isEdit
              ? widget.onEdit?.call(purchase.toJson())
              : widget.onAdd?.call(purchase.toJson());
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Failed to add/update purchase: ${response.body}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double fieldWidth =
        MediaQuery.of(context).size.width * 0.4; // تحديد العرض النسبي للحقول

    return AlertDialog(
      title: Text(widget.isEdit ? 'تعديل عملية شراء' : 'إضافة عملية شراء'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          // للتأكد من دعم التمرير إذا زاد المحتوى
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // صف يحتوي على الحقلين "اسم الصنف" و "اسم المورد"
              Row(
                children: [
                  Container(
                    width: fieldWidth,
                    child: TextFormField(
                      controller: _itemNameController,
                      decoration: InputDecoration(labelText: 'اسم الصنف'),
                      validator: (value) =>
                          value!.isEmpty ? 'يجب إدخال الصنف' : null,
                    ),
                  ),
                  SizedBox(width: 16),
                  Container(
                    width: fieldWidth,
                    child: TextFormField(
                      controller: _supplierNameController,
                      decoration:
                          InputDecoration(labelText: 'اسم المورد - التاجر'),
                      validator: (value) =>
                          value!.isEmpty ? 'يجب إدخال المورد' : null,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    width: fieldWidth,
                    child: TextFormField(
                      controller: _totalPriceController,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(labelText: 'السعر الكلي'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'يجب إدخال السعر الكلي';
                        } else if (!RegExp(r'^[+-]?\d+(\.\d+)?$')
                            .hasMatch(value)) {
                          return 'أدخل رقم صحيح';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Container(
                    width: fieldWidth,
                    child: TextFormField(
                      controller: _unitPriceController,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(labelText: 'سعر الوحدة '),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'يجب إدخال السعر الكلي';
                        } else if (!RegExp(r'^[+-]?\d+(\.\d+)?$')
                            .hasMatch(value)) {
                          return 'أدخل رقم صحيح';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              // صف يحتوي على الحقلين "رقم الفاتورة" و "السعر الكلي"
              Row(
                children: [
                  Container(
                    width: fieldWidth,
                    child: TextFormField(
                      controller: _supplierInvoiceNumberController,
                      decoration: InputDecoration(labelText: 'رقم الفاتورة'),
                      validator: (value) =>
                          value!.isEmpty ? 'يجب إدخال رقم الفاتورة' : null,
                    ),
                  ),
                  SizedBox(width: 16),
                  Container(
                    width: fieldWidth,
                    child: TextFormField(
                      controller: _totalCostController,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(labelText: 'التكلفة الكلية '),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'يجب إدخال السعر الكلي';
                        } else if (!RegExp(r'^[+-]?\d+(\.\d+)?$')
                            .hasMatch(value)) {
                          return 'أدخل رقم صحيح';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              // صف يحتوي على الحقلين "الكمية" و "وحدة القياس"
              Row(
                children: [
                  Container(
                    width: fieldWidth,
                    child: TextFormField(
                      controller: _quantityController,
                      keyboardType:
                          TextInputType.numberWithOptions(signed: true),
                      decoration: InputDecoration(labelText: 'الكمية'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'يجب إدخال الكمية';
                        } else if (!RegExp(r'^[+-]?\d+$').hasMatch(value)) {
                          return 'أدخل رقم صحيح';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Container(
                    width: fieldWidth,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(labelText: 'وحدة القياس'),
                      value: _selectedUnit,
                      items: _units.map((unit) {
                        return DropdownMenuItem<String>(
                          value: unit,
                          child: Text(unit),
                        );
                      }).toList(),
                      onChanged: (value) {
                        _selectedUnit = value;
                      },
                      validator: (value) =>
                          value == null ? 'يجب اختيار وحدة قياس' : null,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              // صف يحتوي على الحقلين "طريقة الدفع" و "حالة الفاتورة"
              Row(
                children: [
                  Container(
                    width: fieldWidth,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(labelText: 'طريقة الدفع'),
                      value: _selectedPaymentMethod,
                      items: _paymentMethod.map((p) {
                        return DropdownMenuItem<String>(
                          value: p,
                          child: Text(p),
                        );
                      }).toList(),
                      onChanged: (value) {
                        _selectedPaymentMethod = value;
                      },
                      validator: (value) =>
                          value == null ? 'يجب اختيار طريقة دفع' : null,
                    ),
                  ),
                  SizedBox(width: 16),
                  Container(
                    width: fieldWidth,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(labelText: 'حالة الفاتورة'),
                      value: _selectedStatus,
                      items: _statusList.map((p) {
                        return DropdownMenuItem<String>(
                          value: p,
                          child: Text(p),
                        );
                      }).toList(),
                      onChanged: (value) {
                        _selectedStatus = value;
                      },
                      validator: (value) =>
                          value == null ? 'يجب اختيار حالة الفاتورة' : null,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              // الحقلين "تفاصيل إضافية" و "السعر"
              TextFormField(
                controller: _itemDescriptionController,
                maxLines: 4,
                decoration: InputDecoration(labelText: 'تفاصيل إضافية'),
                validator: (value) =>
                    value!.isEmpty ? 'يجب إدخال التفاصيل العنصر' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration: InputDecoration(labelText: 'ملاحظات'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'يجب إدخال الملاحظات' : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('إلغاء'),
        ),
        ElevatedButton(
          onPressed: submitForm,
          child: Text(widget.isEdit ? 'تعديل' : 'إضافة'),
        ),
      ],
    );
  }
}
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text(widget.isEdit ? 'تعديل عملية شراء' : 'إضافة عملية شراء'),
//       content: Form(
//         key: _formKey,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextFormField(
//               controller: _itemNameController,
//               decoration: InputDecoration(labelText: 'اسم الصنف'),
//               validator: (value) => value!.isEmpty ? 'يجب إدخال الصنف' : null,
//             ),
//             TextFormField(
//               controller: _supplierNameController,
//               decoration: InputDecoration(labelText: 'اسم المورد - التاجر'),
//               validator: (value) => value!.isEmpty ? 'يجب إدخال المورد' : null,
//             ),
//             TextFormField(
//               controller: _supplierInvoiceNumberController,
//               decoration: InputDecoration(labelText: 'رقم الفاتورة'),
//               validator: (value) =>
//                   value!.isEmpty ? 'يجب إدخال رقم الفاتورة' : null,
//             ),
//             TextFormField(
//                 controller: _totalCostController,
//                 keyboardType: TextInputType.numberWithOptions(decimal: true),
//                 decoration: InputDecoration(labelText: 'السعر الكلي'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'يجب إدخال الكمية';
//                   } else if (!RegExp(r'^[+-]?\d+(\.\d+)?$').hasMatch(value)) {
//                     return 'أدخل رقم صحيح';
//                   }
//                 }),
//             SizedBox(height: 16),
//             TextFormField(
//                 controller: _quantityController,
//                 keyboardType: TextInputType.numberWithOptions(signed: true),
//                 decoration: InputDecoration(labelText: 'الكمية'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'يجب إدخال الكمية';
//                   } else if (!RegExp(r'^[+-]?\d+$').hasMatch(value)) {
//                     return 'أدخل رقم صحيح';
//                   }
//                 }),
//             SizedBox(height: 16),
//             DropdownButtonFormField<String>(
//               decoration: InputDecoration(labelText: 'وحدة القياس'),
//               value: _selectedUnit, // القيمة الافتراضية
//               items: _units.map((unit) {
//                 return DropdownMenuItem<String>(
//                   value: unit,
//                   child: Text(unit),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 _selectedUnit = value;
//               },
//               validator: (value) =>
//                   value == null ? 'يجب اختيار وحدة قياس' : null,
//             ),
//             SizedBox(height: 16),
//             DropdownButtonFormField<String>(
//               decoration: InputDecoration(labelText: 'طريقة الدفع'),
//               value: _selectedPaymentMethod, // القيمة الافتراضية
//               items: _paymentMethod.map((p) {
//                 return DropdownMenuItem<String>(
//                   value: p,
//                   child: Text(p),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 _selectedPaymentMethod = value;
//               },
//               validator: (value) =>
//                   value == null ? 'يجب اختيار طريقة دفع' : null,
//             ),
//             SizedBox(height: 16),
//             DropdownButtonFormField<String>(
//               decoration: InputDecoration(labelText: 'حالة الفاتورة'),
//               value: _selectedStatus, // القيمة الافتراضية
//               items: _statusList.map((p) {
//                 return DropdownMenuItem<String>(
//                   value: p,
//                   child: Text(p),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 _selectedStatus = value;
//               },
//               validator: (value) =>
//                   value == null ? 'يجب اختيار طريقة دفع' : null,
//             ),
//             TextFormField(
//               controller: _itemDescriptionController,
//               maxLines: 4,
//               decoration: InputDecoration(labelText: 'تفاصيل اضافية'),
//               validator: (value) =>
//                   value!.isEmpty ? 'يجب إدخال التفاصيل العنصر' : null,
//             ),
//             TextFormField(
//               controller: _notesController,
//               maxLines: 3,
//               decoration: InputDecoration(labelText: 'السعر'),
//               keyboardType: TextInputType.number,
//               validator: (value) => value!.isEmpty ? 'يجب إدخال السعر' : null,
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(),
//           child: Text('إلغاء'),
//         ),
//         ElevatedButton(
//           onPressed: submitForm,
//           child: Text(widget.isEdit ? 'تعديل' : 'إضافة'),
//         ),
//       ],
//     );
//   }
// }
