
import 'package:flutter/material.dart';

import '../../components/app_bar/app_bar_for_all_page.dart';
import '../../models/dashboard_item.dart';
import 'widgets/dashboard_section.dart';
import 'widgets/responsive_grid.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarForAllPage(
        pageName: 'الرئيسية',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ResponsiveGrid(
            children: [
              DashboardSection(
                item: DashboardItem(
                  title: 'آخر عمليات الإنتاج',
                  data: const [
                    {'title': 'إنتاج خبز 100 قطعة', 'date': '18 ديسمبر 2024'},
                    {'title': 'إنتاج كعك 50 قطعة', 'date': '17 ديسمبر 2024'},
                  ],
                ),
              ),
              DashboardSection(
                item: DashboardItem(
                  title: 'آخر عمليات الشراء',
                  data: const [
                    {'title': 'شراء طحين 100 كجم', 'date': '18 ديسمبر 2024'},
                    {'title': 'شراء سكر 50 كجم', 'date': '17 ديسمبر 2024'},
                  ],
                ),
              ),
              DashboardSection(
                item: DashboardItem(
                  title: 'آخر تحديثات المخزن',
                  data: const [
                    {'title': 'إضافة طحين 50 كجم', 'date': '18 ديسمبر 2024'},
                    {'title': 'إضافة سكر 20 كجم', 'date': '17 ديسمبر 2024'},
                  ],
                ),
              ),
              DashboardSection(
                item: DashboardItem(
                  title: 'آخر المنتجات',
                  data: const [
                    {'title': 'خبز فرنسي', 'date': 'إضافة بتاريخ 18 ديسمبر 2024'},
                    {'title': 'كعك بالسمسم', 'date': 'إضافة بتاريخ 17 ديسمبر 2024'},
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}