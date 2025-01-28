import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/bloc/purchases/purchases_bloc.dart';
import '/models/product.dart';
import '/models/purchase.dart';
import '/presentation/widgets/purchases/add_edit_purchase_dialog.dart';
import '/presentation/widgets/purchases/delete_confirmation_dialog.dart';
import '/presentation/widgets/purchases/purchase_details_dialog.dart';
import '/presentation/widgets/purchases/purchases_list.dart';

class PurchasesPage extends StatefulWidget {
  @override
  _PurchasesPageState createState() => _PurchasesPageState();
}

class _PurchasesPageState extends State<PurchasesPage> {
  @override
  void initState() {
    super.initState();
    context.read<PurchasesBloc>().add(LoadPurchases());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('المشتريات'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: BlocBuilder<PurchasesBloc, PurchasesState>(
        builder: (context, state) {
          if (state is PurchasesLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PurchasesLoaded) {
            return state.purchases.isEmpty
                ? Center(child: Text('لا توجد مشتريات'))
                : PurchasesList(
                    purchases: state.purchases,
                    onEdit: (purchase) => _showEditPurchaseDialog(context, purchase, state.products),
                    onDelete: (purchase) => _showDeleteConfirmationDialog(context, purchase),
                    onTap: (purchase) => _showPurchaseDetails(context, purchase),
                  );
          } else if (state is PurchasesError) {
            return Center(child: Text('حدث خطأ: ${state.message}'));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddPurchaseDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddPurchaseDialog(BuildContext context) {
    final state = context.read<PurchasesBloc>().state;
    if (state is PurchasesLoaded) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddEditPurchaseDialog(
            products: state.products,
            onSave: (purchase) {
              context.read<PurchasesBloc>().add(AddPurchase(purchase));
            },
          );
        },
      );
    }
  }

  void _showEditPurchaseDialog(BuildContext context, Purchase purchase, List<Product> products) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddEditPurchaseDialog(
          purchase: purchase,
          products: products,
          onSave: (updatedPurchase) {
            context.read<PurchasesBloc>().add(UpdatePurchase(updatedPurchase));
          },
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, Purchase purchase) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteConfirmationDialog(
          purchase: purchase,
          onConfirm: () {
            context.read<PurchasesBloc>().add(DeletePurchase(purchase.id));
          },
        );
      },
    );
  }

  void _showPurchaseDetails(BuildContext context, Purchase purchase) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PurchaseDetailsDialog(purchase: purchase);
      },
    );
  }
}

