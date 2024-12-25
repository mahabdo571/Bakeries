import 'dart:convert';
import 'package:bakerieswepapp/components/add_stock_dilog.dart';
import 'package:bakerieswepapp/components/app_bar/app_bar_for_all_page.dart';
import 'package:bakerieswepapp/components/stock_card.dart';
import 'package:bakerieswepapp/models/Stock.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api_config.dart';

class StockScreens extends StatefulWidget {
  @override
  _StockScreensState createState() => _StockScreensState();
}

class _StockScreensState extends State<StockScreens> {
  late Stream<List<Stock>> StockStream;

  @override
  void initState() {
    super.initState();
    StockStream = fetchStockStream();
  }

  // دالة لإنشاء Stream للتحديث التلقائي
  Stream<List<Stock>> fetchStockStream() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 2));
      final response = await http.get(Uri.parse(ApiConfig.stockAll));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        yield jsonResponse.map((data) => Stock.fromJson(data)).toList();
      } else {
        throw Exception('فشل في تحميل البيانات');
      }
    }
  }

  // دالة لحذف العنصر
  Future<void> deleteStockItem(int id) async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    try {
      final response =
          await http.delete(Uri.parse('${ApiConfig.StockById}$id'));
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('تم حذف العنصر')));
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      await Future.delayed(Duration(seconds: 3));
      Navigator.of(context).pop();
    }
  }

  // دالة لفتح Dialog لإضافة عملية شراء جديدة
  void openAddStockDialog() {
    showDialog(
      context: context,
      builder: (context) => AddStockDialog(
        isEdit: false,
        onAdd: (newPurchase) {},
      ),
    );
  }

  // دالة لفتح Dialog لتعديل عملية شراء
  void openEditStockDialog(Stock stock) {
    showDialog(
      context: context,
      builder: (context) => AddStockDialog(
        isEdit: true,
        stockData: stock.toJson(),
        onEdit: (updatedstock) {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarForAllPage(pageName: 'المخزن'),
      body: StreamBuilder<List<Stock>>(
        stream: StockStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('لا توجد بيانات لعرضها'));
          } else {
            List<Stock> StockList = snapshot.data!;
            return ListView.builder(
              itemCount: StockList.length,
              itemBuilder: (context, index) {
                return StockCard(
                  stock: StockList[index],
                  onEdit: openEditStockDialog,
                  onDelete: deleteStockItem,
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openAddStockDialog,
        child: Icon(Icons.add),
        backgroundColor: Colors.brown,
      ),
    );
  }
}
