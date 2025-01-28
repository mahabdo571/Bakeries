import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/bloc/inventory/inventory_bloc.dart';
import '/models/product.dart';
import '/presentation/widgets/inventory/inventory_list.dart';
import '/presentation/widgets/inventory/add_edit_product_dialog.dart';
import '/presentation/widgets/inventory/product_details_dialog.dart';
import '/presentation/widgets/inventory/delete_confirmation_dialog.dart';
import '/utils/responsive_sizes.dart';

class InventoryPage extends StatefulWidget {
  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<InventoryBloc>().add(LoadInventory());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('المخزون'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ResponsiveInventoryBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddProductDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddProductDialog(BuildContext context) {
    if (ResponsiveSizes.isMobile(context)) {
      Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text('إضافة منتج جديد')),
          body: AddEditProductDialog(
            onSave: (product) {
              context.read<InventoryBloc>().add(AddProduct(product));
              Navigator.of(context).pop();
            },
          ),
        ),
      ));
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddEditProductDialog(
            onSave: (product) {
              context.read<InventoryBloc>().add(AddProduct(product));
            },
          );
        },
      );
    }
  }

  void _showEditProductDialog(BuildContext context, Product product) {
    if (ResponsiveSizes.isMobile(context)) {
      Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text('تعديل المنتج')),
          body: AddEditProductDialog(
            product: product,
            onSave: (updatedProduct) {
              context.read<InventoryBloc>().add(UpdateProduct(updatedProduct));
              Navigator.of(context).pop();
            },
          ),
        ),
      ));
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddEditProductDialog(
            product: product,
            onSave: (updatedProduct) {
              context.read<InventoryBloc>().add(UpdateProduct(updatedProduct));
            },
          );
        },
      );
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteConfirmationDialog(
          product: product,
          onConfirm: () {
            context.read<InventoryBloc>().add(DeleteProduct(product.id));
          },
        );
      },
    );
  }

  void _showProductDetails(BuildContext context, Product product) {
    if (ResponsiveSizes.isMobile(context)) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text(product.itemName)),
          body: SingleChildScrollView(
            child: ProductDetailsDialog(product: product),
          ),
        ),
      ));
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ProductDetailsDialog(product: product);
        },
      );
    }
  }
}

class ResponsiveInventoryBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InventoryBloc, InventoryState>(
      builder: (context, state) {
        if (state is InventoryLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is InventoryLoaded) {
          return state.products.isEmpty
              ? Center(child: Text('لا توجد منتجات'))
              : InventoryList(
                  products: state.products,
                  onEdit: (product) => _showEditProductDialog(context, product),
                  onDelete: (product) => _showDeleteConfirmationDialog(context, product),
                  onTap: (product) => _showProductDetails(context, product),
                );
        } else if (state is InventoryError) {
          return Center(child: Text('حدث خطأ: ${state.message}'));
        }
        return Container();
      },
    );
  }

  void _showEditProductDialog(BuildContext context, Product product) {
    if (ResponsiveSizes.isMobile(context)) {
      Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text('تعديل المنتج')),
          body: AddEditProductDialog(
            product: product,
            onSave: (updatedProduct) {
              context.read<InventoryBloc>().add(UpdateProduct(updatedProduct));
              Navigator.of(context).pop();
            },
          ),
        ),
      ));
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddEditProductDialog(
            product: product,
            onSave: (updatedProduct) {
              context.read<InventoryBloc>().add(UpdateProduct(updatedProduct));
            },
          );
        },
      );
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteConfirmationDialog(
          product: product,
          onConfirm: () {
            context.read<InventoryBloc>().add(DeleteProduct(product.id));
          },
        );
      },
    );
  }

  void _showProductDetails(BuildContext context, Product product) {
    if (ResponsiveSizes.isMobile(context)) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text(product.itemName)),
          body: SingleChildScrollView(
            child: ProductDetailsDialog(product: product),
          ),
        ),
      ));
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ProductDetailsDialog(product: product);
        },
      );
    }
  }
}

