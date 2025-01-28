import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/bloc/production/production_bloc.dart';
import '/models/production.dart';

class ProductionPage extends StatefulWidget {
  @override
  _ProductionPageState createState() => _ProductionPageState();
}

class _ProductionPageState extends State<ProductionPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductionBloc>().add(LoadProduction());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('عمليات الإنتاج'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: BlocBuilder<ProductionBloc, ProductionState>(
        builder: (context, state) {
          if (state is ProductionLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductionLoaded) {
            return ListView.builder(
              itemCount: state.productions.length,
              itemBuilder: (context, index) {
                final production = state.productions[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text('منتج: ${production.productId}'),
                    subtitle: Text('الكمية: ${production.quantity}'),
                    trailing: Text('التاريخ: ${production.date.toString().split(' ')[0]}'),
                    onTap: () {
                      // Open production details page
                    },
                  ),
                );
              },
            );
          } else if (state is ProductionError) {
            return Center(child: Text('حدث خطأ: ${state.message}'));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Open add production dialog
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

