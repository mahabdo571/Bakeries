import 'package:bakerieswepapp/Componant/app_bar_for_all_bage.dart';
import 'package:bakerieswepapp/Screens/PurchasesPage.dart';
import 'package:bakerieswepapp/Screens/stockScreens.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, String>> productionData = [
    {"date": "2024-12-19", "product": "Bread", "quantity": "50"},
    {"date": "2024-12-18", "product": "Cake", "quantity": "20"},
    {"date": "2024-12-17", "product": "Cookies", "quantity": "100"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarForAllBage(
        NamePage: 'الرئيسية',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 4, // عدد الأعمدة في الشبكة
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          children: [
            _buildSection(
              title: 'آخر عمليات الإنتاج',
              content: ListView(
                children: [
                  ListTile(
                    title: Text('إنتاج خبز 100 قطعة'),
                    subtitle: Text('18 ديسمبر 2024'),
                  ),
                  ListTile(
                    title: Text('إنتاج كعك 50 قطعة'),
                    subtitle: Text('17 ديسمبر 2024'),
                  ),
                ],
              ),
            ),
            _buildSection(
              title: 'آخر عمليات الشراء',
              content: ListView(
                children: [
                  ListTile(
                    title: Text('شراء طحين 100 كجم'),
                    subtitle: Text('18 ديسمبر 2024'),
                  ),
                  ListTile(
                    title: Text('شراء سكر 50 كجم'),
                    subtitle: Text('17 ديسمبر 2024'),
                  ),
                ],
              ),
            ),
            _buildSection(
              title: 'آخر تحديثات المخزن',
              content: ListView(
                children: [
                  ListTile(
                    title: Text('إضافة طحين 50 كجم'),
                    subtitle: Text('18 ديسمبر 2024'),
                  ),
                  ListTile(
                    title: Text('إضافة سكر 20 كجم'),
                    subtitle: Text('17 ديسمبر 2024'),
                  ),
                ],
              ),
            ),
            _buildSection(
              title: 'آخر المنتجات',
              content: ListView(
                children: [
                  ListTile(
                    title: Text('خبز فرنسي'),
                    subtitle: Text('إضافة بتاريخ 18 ديسمبر 2024'),
                  ),
                  ListTile(
                    title: Text('كعك بالسمسم'),
                    subtitle: Text('إضافة بتاريخ 17 ديسمبر 2024'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required Widget content}) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.brown,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: content,
            ),
          ),
        ],
      ),
    );
  }
}
