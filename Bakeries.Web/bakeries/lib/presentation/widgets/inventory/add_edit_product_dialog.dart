import 'package:flutter/material.dart';

import '/models/product.dart';
import '/utils/responsive_sizes.dart';

class AddEditProductDialog extends StatefulWidget {
  final Product? product;
  final Function(Product) onSave;

  const AddEditProductDialog({
    Key? key,
    this.product,
    required this.onSave,
  }) : super(key: key);

  @override
  _AddEditProductDialogState createState() => _AddEditProductDialogState();
}

class _AddEditProductDialogState extends State<AddEditProductDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _itemNameController;
  late TextEditingController _availableQuantityController;
  late TextEditingController _reorderLevelController;
  late TextEditingController _locationController;
  late TextEditingController _notesController;
  late String _selectedUnitOfMeasure;

  final List<String> _unitOfMeasureOptions = ['كيلو غرام', 'غرام', 'لتر'];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _itemNameController =
        TextEditingController(text: widget.product?.itemName ?? '');
    _availableQuantityController = TextEditingController(
        text: widget.product?.availableQuantity.toString() ?? '');
    _reorderLevelController = TextEditingController(
        text: widget.product?.reorderLevel.toString() ?? '');
    _locationController =
        TextEditingController(text: widget.product?.location ?? '');
    _notesController = TextEditingController(text: widget.product?.notes ?? '');
    _selectedUnitOfMeasure =
        widget.product?.unitOfMeasure ?? _unitOfMeasureOptions.first;
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _availableQuantityController.dispose();
    _reorderLevelController.dispose();
    _locationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveSizes.isDesktop(context);
    final isMobile = ResponsiveSizes.isMobile(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: isDesktop ? 600 : (isMobile ? double.infinity : 400),
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
                      _buildFormSection(
                        context,
                        title: 'معلومات المنتج',
                        children: [
                          _buildTextField(
                            controller: _itemNameController,
                            label: 'اسم المنتج',
                            icon: Icons.inventory,
                            validator: (value) => value!.isEmpty
                                ? 'الرجاء إدخال اسم المنتج'
                                : null,
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: _buildTextField(
                                  controller: _availableQuantityController,
                                  label: 'الكمية المتوفرة',
                                  icon: Icons.format_list_numbered,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'الرجاء إدخال الكمية';
                                    }
                                    if (double.tryParse(value) == null) {
                                      return 'الرجاء إدخال رقم صحيح';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: _buildDropdownField(
                                  value: _selectedUnitOfMeasure,
                                  items: _unitOfMeasureOptions,
                                  label: 'وحدة القياس',
                                  icon: Icons.straighten,
                                  onChanged: (String? value) {
                                    setState(() {
                                      _selectedUnitOfMeasure = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      _buildFormSection(
                        context,
                        title: 'معلومات المخزون',
                        children: [
                          _buildTextField(
                            controller: _reorderLevelController,
                            label: 'مستوى إعادة الطلب',
                            icon: Icons.notification_important,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'الرجاء إدخال مستوى إعادة الطلب';
                              }
                              if (int.tryParse(value) == null) {
                                return 'الرجاء إدخال رقم صحيح';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          _buildTextField(
                            controller: _locationController,
                            label: 'الموقع',
                            icon: Icons.location_on,
                            validator: (value) =>
                                value!.isEmpty ? 'الرجاء إدخال الموقع' : null,
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      _buildFormSection(
                        context,
                        title: 'ملاحظات إضافية',
                        children: [
                          _buildTextField(
                            controller: _notesController,
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
            widget.product == null ? 'إضافة منتج جديد' : 'تعديل المنتج',
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
      ),
      maxLines: maxLines,
      enabled: enabled,
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  Widget _buildDropdownField({
    required String value,
    required List<String> items,
    required String label,
    required IconData icon,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
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
            child: Text(widget.product == null ? 'إضافة' : 'تعديل'),
          ),
        ],
      ),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final product = Product(
        id: widget.product?.id ?? 0,
        itemName: _itemNameController.text,
        availableQuantity: double.parse(_availableQuantityController.text),
        unitOfMeasure: _selectedUnitOfMeasure,
        reorderLevel: int.parse(_reorderLevelController.text),
        location: _locationController.text,
        notes: _notesController.text,
      );
      widget.onSave(product);
      Navigator.of(context).pop();
    }
  }
}
