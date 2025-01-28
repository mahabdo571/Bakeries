import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/bloc/purchases/purchases_bloc.dart';
import '/models/purchase.dart';

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
            return ListView.builder(
              itemCount: state.purchases.length,
              itemBuilder: (context, index) {
                final purchase = state.purchases[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text('منتج: ${purchase.productId}'),
                    subtitle: Text('الكمية: ${purchase.quantity}'),
                    trailing: Text('السعر: ${purchase.totalPrice} ريال'),
                    onTap: () {
                      // Open purchase details page
                    },
                  ),
                );
              },
            );
          } else if (state is PurchasesError) {
            return Center(child: Text('حدث خطأ: ${state.message}'));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Open add purchase dialog
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
