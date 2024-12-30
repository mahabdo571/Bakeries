import 'package:bakerieswepapp/screens/stock/widgets/add_stock_dialog/add_stock_dialog.dart';
import 'package:flutter/material.dart';
import 'package:bakerieswepapp/models/Stock.dart';
import 'package:bakerieswepapp/screens/stock/widgets/stock_card.dart';
import 'package:bakerieswepapp/services/stock_service.dart';

class StockList extends StatefulWidget {
  const StockList({Key? key}) : super(key: key);

  @override
  _StockListState createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  late Stream<List<Stock>> stockStream;

  @override
  void initState() {
    super.initState();
    stockStream = StockService.getStockStream();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Stock>>(
      stream: stockStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (snapshot.hasError) {
          return Center(child: Text('حدث خطأ: ${snapshot.error}'));
        }
        
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('لا توجد بيانات لعرضها'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) => StockCard(
            stock: snapshot.data![index],
            onEdit: _handleEdit,
            onDelete: _handleDelete,
          ),
        );
      },
    );
  }

  void _handleEdit(Stock stock) {
          showDialog(
      context: context,
      builder: (context) => AddStockDialog(
        isEdit: true,
        stockData: stock.toJson() ,
        onAdd: (newStock) {
          // Handle add callback
        },
      ),
    );
  }

  Future<void> _handleDelete(int id) async {
    try {
      await StockService.deleteStock(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم حذف العنصر بنجاح')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('فشل في حذف العنصر: $e')),
      );
    }
  }
}