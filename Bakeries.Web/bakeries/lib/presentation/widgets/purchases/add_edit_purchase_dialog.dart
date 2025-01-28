import 'package:flutter/material.dart';
import 'dart:async';

import '/models/product.dart';
import '/models/purchase.dart';
import '/utils/responsive_sizes.dart';
import 'controllers/purchase_form_controller.dart';
import 'sections/purchase_form_sections.dart';

class AddEditPurchaseDialog extends StatefulWidget {
  final Purchase? purchase;
  final List<Product> products;
  final Function(Purchase) onSave;

  const AddEditPurchaseDialog({
    Key? key,
    this.purchase,
    required this.products,
    required this.onSave,
  }) : super(key: key);

  @override
  _AddEditPurchaseDialogState createState() => _AddEditPurchaseDialogState();
}

class _AddEditPurchaseDialogState extends State<AddEditPurchaseDialog> {
  late final PurchaseFormController _controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = PurchaseFormController(
      initialPurchase: widget.purchase,
      products: widget.products,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveSizes.isDesktop(context);
    final isMobile = ResponsiveSizes.isMobile(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: isDesktop ? 800 : (isMobile ? double.infinity : 600),
        constraints: BoxConstraints(
          maxHeight:
              MediaQuery.of(context).size.height * (isDesktop ? 0.8 : 0.9),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context),
            Divider(height: 1),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PurchaseFormSections.buildProductSection(
                        selectedProduct: _controller.selectedProduct,
                        products: widget.products,
                        onProductChanged: _controller.onProductChanged,
                        descriptionController:
                            _controller.itemDescriptionController,
                      ),
                      SizedBox(height: 24),
                      _buildFormSection(
                        context,
                        title: 'معلومات المورد',
                        children: [
                          _buildTextField(
                            controller: _controller.supplierNameController,
                            label: 'اسم المورد',
                            icon: Icons.person,
                            validator: (value) => value!.isEmpty
                                ? 'الرجاء إدخال اسم المورد'
                                : null,
                          ),
                          SizedBox(height: 16),
                          _buildTextField(
                            controller:
                                _controller.supplierInvoiceNumberController,
                            label: 'رقم فاتورة المورد',
                            icon: Icons.receipt,
                            validator: (value) => value!.isEmpty
                                ? 'الرجاء إدخال رقم فاتورة المورد'
                                : null,
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      _buildFormSection(
                        context,
                        title: 'تفاصيل الشراء',
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _buildTextField(
                                  controller: _controller.quantityController,
                                  label: 'الكمية',
                                  icon: Icons.format_list_numbered,
                                  keyboardType: TextInputType.number,
                                  validator: (value) => value!.isEmpty
                                      ? 'الرجاء إدخال الكمية'
                                      : null,
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: _buildDropdownField(
                                  value: _controller.selectedUnitOfMeasure,
                                  items: _controller.unitOfMeasureOptions,
                                  label: 'وحدة القياس',
                                  icon: Icons.straighten,
                                  onChanged: _controller.onUnitOfMeasureChanged,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: _buildTextField(
                                  controller: _controller.unitPriceController,
                                  label: 'سعر الوحدة',
                                  icon: Icons.attach_money,
                                  keyboardType: TextInputType.number,
                                  validator: (value) => value!.isEmpty
                                      ? 'الرجاء إدخال سعر الوحدة'
                                      : null,
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: _buildTextField(
                                  controller: _controller.totalPriceController,
                                  label: 'السعر الإجمالي',
                                  icon: Icons.shopping_cart_checkout,
                                  enabled: false,
                                  filled: true,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      _buildFormSection(
                        context,
                        title: 'معلومات الدفع',
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _buildDropdownField(
                                  value: _controller.selectedPaymentMethod,
                                  items: _controller.paymentMethodOptions,
                                  label: 'طريقة الدفع',
                                  icon: Icons.payment,
                                  onChanged: _controller.onPaymentMethodChanged,
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: _buildDropdownField(
                                  value: _controller.selectedStatus,
                                  items: _controller.statusOptions,
                                  label: 'الحالة',
                                  icon: Icons.info_outline,
                                  onChanged: _controller.onStatusChanged,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      _buildFormSection(
                        context,
                        title: 'ملاحظات إضافية',
                        children: [
                          _buildTextField(
                            controller: _controller.notesController,
                            label: 'ملاحظات',
                            icon: Icons.note,
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.purchase == null ? 'إضافة عملية شراء' : 'تعديل عملية الشراء',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    bool enabled = true,
    bool filled = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: filled,
        helperText:
            keyboardType == TextInputType.number ? 'أدخل رقماً صحيحاً' : null,
      ),
      maxLines: maxLines,
      enabled: enabled,
      keyboardType: keyboardType,
      validator: (value) {
        if (validator != null) {
          final result = validator(value);
          if (result != null) return result;
        }

        if (keyboardType == TextInputType.number &&
            value != null &&
            value.isNotEmpty) {
          if (double.tryParse(value) == null) {
            return 'الرجاء إدخال رقم صحيح';
          }
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: keyboardType == TextInputType.number
          ? _controller.onQuantityChanged
          : null,
    );
  }

  Widget _buildDropdownField({
    required String value,
    required List<String> items,
    required String label,
    required IconData icon,
    required void Function(String?) onChanged,
  }) {
    final safeValue = items.contains(value) ? value : items.first;

    return DropdownButtonFormField<String>(
      value: safeValue,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('إلغاء'),
          ),
          SizedBox(width: 16),
          ElevatedButton(
            onPressed: _handleSubmit,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(widget.purchase == null ? 'إضافة' : 'تعديل'),
          ),
        ],
      ),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate() &&
        _controller.selectedProduct != null) {
      final purchase = Purchase(
        id: widget.purchase?.id ?? 0,
        itemName: _controller.selectedProduct!.itemName,
        itemDescription: _controller.itemDescriptionController.text,
        notes: _controller.notesController.text,
        supplierName: _controller.supplierNameController.text,
        itemId: _controller.selectedProduct!.id,
        supplierInvoiceNumber: _controller.supplierInvoiceNumberController.text,
        quantity: int.parse(_controller.quantityController.text),
        unitOfMeasure: _controller.selectedUnitOfMeasure,
        unitPrice: double.parse(_controller.unitPriceController.text),
        totalPrice: double.parse(_controller.totalPriceController.text),
        paymentMethod: _controller.selectedPaymentMethod,
        status: _controller.selectedStatus,
      );
      widget.onSave(purchase);
      Navigator.of(context).pop();
    }
  }
}
