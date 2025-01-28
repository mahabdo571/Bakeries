import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/bloc/products/products_bloc.dart';
import '/models/product.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductsBloc>().add(LoadProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('المنتجات'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductsLoaded) {
            return state.products.isEmpty
                ? Center(child: Text('لا توجد منتجات'))
                : ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ListTile(
                          title: Text(product.itemName),
                          subtitle: Text('الكمية المتوفرة: ${product.availableQuantity} ${product.unitOfMeasure}'),
                          trailing: Text('الموقع: ${product.location}'),
                          onTap: () {
                            _showProductDetails(context, product);
                          },
                        ),
                      );
                    },
                  );
          } else if (state is ProductsError) {
            return Center(child: Text('حدث خطأ: ${state.message}'));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddProductDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddProductDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddProductDialog();
      },
    );
  }

  void _showProductDetails(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(product.itemName),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('الكمية المتوفرة: ${product.availableQuantity} ${product.unitOfMeasure}'),
              Text('مستوى إعادة الطلب: ${product.reorderLevel}'),
              Text('الموقع: ${product.location}'),
              Text('ملاحظات: ${product.notes}'),
            ],
          ),
          actions: [
            TextButton(
              child: Text('إغلاق'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class AddProductDialog extends StatefulWidget {
  @override
  _AddProductDialogState createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  final _formKey = GlobalKey<FormState>();
  String _itemName = '';
  double _availableQuantity = 0;
  String _unitOfMeasure = '';
  int _reorderLevel = 0;
  String _location = '';
  String _notes = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('إضافة منتج جديد'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'اسم المنتج'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال اسم المنتج';
                  }
                  return null;
                },
                onSaved: (value) => _itemName = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'الكمية المتوفرة'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال الكمية المتوفرة';
                  }
                  if (double.tryParse(value) == null) {
                    return 'الرجاء إدخال رقم صحيح';
                  }
                  return null;
                },
                onSaved: (value) => _availableQuantity = double.parse(value!),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'وحدة القياس'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال وحدة القياس';
                  }
                  return null;
                },
                onSaved: (value) => _unitOfMeasure = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'مستوى إعادة الطلب'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال مستوى إعادة الطلب';
                  }
                  if (int.tryParse(value) == null) {
                    return 'الرجاء إدخال رقم صحيح';
                  }
                  return null;
                },
                onSaved: (value) => _reorderLevel = int.parse(value!),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'الموقع'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال الموقع';
                  }
                  return null;
                },
                onSaved: (value) => _location = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'ملاحظات'),
                onSaved: (value) => _notes = value ?? '',
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text('إلغاء'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: Text('إضافة'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final newProduct = Product(
                id: 0, // The API will assign the actual ID
                itemName: _itemName,
                availableQuantity: _availableQuantity,
                unitOfMeasure: _unitOfMeasure,
                reorderLevel: _reorderLevel,
                location: _location,
                notes: _notes,
              );
              context.read<ProductsBloc>().add(AddProduct(newProduct));
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}

