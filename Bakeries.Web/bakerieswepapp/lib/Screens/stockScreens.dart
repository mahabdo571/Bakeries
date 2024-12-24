import 'dart:convert';

import 'package:bakerieswepapp/Componant/app_bar_for_all_bage.dart';
import 'package:bakerieswepapp/Model/Stock.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bakerieswepapp/Model/Purchase.dart'; // استيراد موديل Purchase
import '../Componant/add_purchase_dialog.dart'; // استيراد صفحة الاضافة

class StockScreens extends StatefulWidget {
  @override
  _StockScreensState createState() => _StockScreensState();
}

class _StockScreensState extends State<StockScreens> {
  late Stream<List<Stock>> StockStream;
  late Stream<List<Stock>> stockStream;

  @override
  void initState() {
    super.initState();
    StockStream = fetchStockStream();
  }

  // دالة لإنشاء Stream للتحديث التلقائي
  Stream<List<Stock>> fetchStockStream() async* {
    while (true) {
      // الانتظار لفترة قصيرة قبل إعادة جلب البيانات (كل 5 ثواني مثلاً)
      await Future.delayed(Duration(seconds: 2));

      final response =
          await http.get(Uri.parse('http://localhost:5145/api/Stock/All'));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        yield jsonResponse.map((data) => Stock.fromJson(data)).toList();
      } else {
        throw Exception('فشل في تحميل البيانات');
      }
    }
  }

  // دالة لحذف العنصر
  Future<void> deletePurchase(int id) async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      final response = await http
          .delete(Uri.parse('http://localhost:5145/api/Purchases/$id'));

      if (response.statusCode == 200) {
        // إذا تم الحذف بنجاح، ستستمر البيانات بالتحديث تلقائيًا
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('تم حذف العنصر')));
      } else {
        throw Exception('فشل في حذف العنصر');
      }
    } catch (e) {
      print(e);
    } finally {
      await Future.delayed(Duration(seconds: 3));
      // إغلاق مؤشر التحميل
      Navigator.of(context).pop();
    }
  }

  // دالة لفتح Dialog لإضافة عملية شراء جديدة
  void openAddPurchaseDialog() {
    showDialog(
      context: context,
      builder: (context) => AddPurchaseDialog(
        isEdit: false,
        onAdd: (newPurchase) {
          // بعد إضافة عنصر جديد سيتم تحديث البيانات تلقائيًا
        },
      ),
    );
  }

  // دالة لفتح Dialog لتعديل عملية شراء
  void openEditPurchaseDialog(Stock stock) {
    showDialog(
      context: context,
      builder: (context) => AddPurchaseDialog(
        isEdit: true,
        purchaseData: stock.toJson(),
        onEdit: (updatedPurchase) {
          // بعد التعديل سيتم تحديث البيانات تلقائيًا
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarForAllBage(
        NamePage: 'المخزن',
      ),
      body: StreamBuilder<List<Stock>>(
        stream: StockStream, // استخدام Stream
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
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // العنوان والوصف
                        Row(
                          children: [
                            Icon(Icons.shopping_cart,
                                color: Colors.brown, size: 24),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                StockList[index].ItemName,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          StockList[index].Notes,
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                        Divider(),

                        // تفاصيل الكمية والسعر والتكلفة
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildDetailItem(Icons.inventory, 'الكمية',
                                '${StockList[index].QuantityInStock}'),
                          ],
                        ),
                        SizedBox(height: 10),

                        // المورد والفاتورة
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildDetailItem(Icons.person, 'الموقع في المخزن',
                                StockList[index].Location),
                            _buildDetailItem(Icons.upcoming_outlined,
                                'وحدة القياس', StockList[index].UnitOfMeasure),
                          ],
                        ),
                        Divider(),

                        // الحالة وطريقة الدفع
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildDetailItem(Icons.payment, 'الحد الادنى للطلب',
                                StockList[index].ReorderLevel.toString()),
                          ],
                        ),

                        // أزرار التحكم
                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton.icon(
                                icon: Icon(Icons.edit, color: Colors.white),
                                label: Text('تعديل'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                ),
                                onPressed: () {
                                  openEditPurchaseDialog(StockList[index]);
                                },
                              ),
                              SizedBox(width: 10),
                              ElevatedButton.icon(
                                icon: Icon(Icons.delete, color: Colors.white),
                                label: Text('حذف'),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red),
                                onPressed: () {
                                  deletePurchase(StockList[index].Id);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openAddPurchaseDialog, // فتح Dialog لإضافة عملية شراء
        child: Icon(Icons.add),
        backgroundColor: Colors.brown,
      ),
    );
  }
}

Widget _buildDetailItem(IconData icon, String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(icon, color: Colors.brown, size: 18),
          SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
      Text(
        value,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ],
  );
}
