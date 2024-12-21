import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bakerieswepapp/Model/Purchase.dart'; // استيراد موديل Purchase
import 'add_purchase_dialog.dart'; // استيراد صفحة الاضافة

// class PurchasesPage extends StatefulWidget {
//   @override
//   _PurchasesPageState createState() => _PurchasesPageState();
// }

// class _PurchasesPageState extends State<PurchasesPage> {
//   late Future<List<Purchase>> purchases;

//   @override
//   void initState() {
//     super.initState();
//     purchases = fetchPurchases();
//   }

//   // دالة لجلب البيانات من API
//   Future<List<Purchase>> fetchPurchases() async {
//     final response =
//         await http.get(Uri.parse('http://localhost:5145/api/Purchases/All'));

//     if (response.statusCode == 200) {
//       List jsonResponse = json.decode(response.body);
//       return jsonResponse.map((data) => Purchase.fromJson(data)).toList();
//     } else {
//       throw Exception('فشل في تحميل البيانات');
//     }
//   }

//   // دالة لحذف عنصر
//   Future<void> deletePurchase(int id) async {
//     final response =
//         await http.delete(Uri.parse('http://localhost:5145/api/Purchases/$id'));

//     if (response.statusCode == 200) {
//       setState(() {
//         purchases = fetchPurchases();
//       });
//     } else {
//       throw Exception('فشل في حذف العنصر');
//     }
//   }

//   // دالة لفتح Dialog لإضافة عملية شراء جديدة
//   void openAddPurchaseDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AddPurchaseDialog(
//         isEdit: false,
//         onAdd: (newPurchase) {
//           setState(() {
//             purchases = fetchPurchases();
//           });
//         },
//       ),
//     );
//   }

//   // دالة لفتح Dialog لتعديل عملية شراء
//   void openEditPurchaseDialog(Purchase purchase) {
//     showDialog(
//       context: context,
//       builder: (context) => AddPurchaseDialog(
//         isEdit: true,
//         purchaseData: purchase.toJson(),
//         onEdit: (updatedPurchase) {
//           setState(() {
//             purchases = fetchPurchases();
//           });
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('قائمة المشتريات',
//             style: TextStyle(fontWeight: FontWeight.bold)),
//         backgroundColor: Colors.brown,
//       ),
//       body: FutureBuilder<List<Purchase>>(
//         future: purchases,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('حدث خطأ: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('لا توجد بيانات لعرضها'));
//           } else {
//             List<Purchase> purchaseList = snapshot.data!;
//             return ListView.builder(
//               itemCount: purchaseList.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//                   elevation: 5,
//                   child: ListTile(
//                     title: Text(purchaseList[index].item),
//                     subtitle: Text(
//                       'الكمية: ${purchaseList[index].quantity}, السعر: ${purchaseList[index].price}',
//                     ),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.edit),
//                           onPressed: () {
//                             openEditPurchaseDialog(purchaseList[index]);
//                           },
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.delete),
//                           onPressed: () {
//                             deletePurchase(purchaseList[index].id);
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: openAddPurchaseDialog, // فتح Dialog لإضافة عملية شراء
//         child: Icon(Icons.add),
//         backgroundColor: Colors.brown,
//       ),
//     );
//   }
// }

// //-----------------------

class PurchasesPage extends StatefulWidget {
  @override
  _PurchasesPageState createState() => _PurchasesPageState();
}

class _PurchasesPageState extends State<PurchasesPage> {
  late Stream<List<Purchase>> purchasesStream;

  @override
  void initState() {
    super.initState();
    purchasesStream = fetchPurchasesStream();
  }

  // دالة لإنشاء Stream للتحديث التلقائي
  Stream<List<Purchase>> fetchPurchasesStream() async* {
    while (true) {
      // الانتظار لفترة قصيرة قبل إعادة جلب البيانات (كل 5 ثواني مثلاً)
      await Future.delayed(Duration(seconds: 3));

      final response =
          await http.get(Uri.parse('http://localhost:5145/api/Purchases/All'));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        yield jsonResponse.map((data) => Purchase.fromJson(data)).toList();
      } else {
        throw Exception('فشل في تحميل البيانات');
      }
    }
  }

  // دالة لحذف العنصر
  Future<void> deletePurchase(int id) async {
    final response =
        await http.delete(Uri.parse('http://localhost:5145/api/Purchases/$id'));

    if (response.statusCode == 200) {
      // إذا تم الحذف بنجاح، ستستمر البيانات بالتحديث تلقائيًا
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('تم حذف العنصر')));
    } else {
      throw Exception('فشل في حذف العنصر');
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
  void openEditPurchaseDialog(Purchase purchase) {
    showDialog(
      context: context,
      builder: (context) => AddPurchaseDialog(
        isEdit: true,
        purchaseData: purchase.toJson(),
        onEdit: (updatedPurchase) {
          // بعد التعديل سيتم تحديث البيانات تلقائيًا
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('قائمة المشتريات',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.brown,
      ),
      body: StreamBuilder<List<Purchase>>(
        stream: purchasesStream, // استخدام Stream
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('لا توجد بيانات لعرضها'));
          } else {
            List<Purchase> purchaseList = snapshot.data!;
            return ListView.builder(
              itemCount: purchaseList.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  elevation: 5,
                  child: ListTile(
                    title: Text(purchaseList[index].ItemName),
                    subtitle: Text(
                      'الكمية: ${purchaseList[index].Quantity}, السعر: ${purchaseList[index].UnitPrice}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                          openEditPurchaseDialog(purchaseList[index]);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            deletePurchase(purchaseList[index].Id);
                          },
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
