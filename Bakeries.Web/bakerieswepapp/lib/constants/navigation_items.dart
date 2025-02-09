import 'package:flutter/material.dart';

import '../models/navigation_item.dart';
import '../screens/home/home_page.dart';
import '../screens/product/product_page.dart';
import '../screens/purchases/purchases_page.dart';
import '../screens/settings/setting_page.dart';
import '../screens/stock/stock_page.dart';

final List<NavigationItem> navigationItems = [
  NavigationItem(
    title: 'الرئيسية',
    route:  HomePage(),
    icon: Icons.home,
  ),
  NavigationItem(
    title: 'المشتريات والفواتير',
    route: PurchasesPage(),
    icon: Icons.shopping_cart,
  ),
  NavigationItem(
    title: 'المخازن',
    icon: Icons.store,
    subItems: [
      NavigationItem(
        title: 'مخزن المواد الخام',
        route: StockScreens(),
        icon: Icons.inventory,
      ),
      NavigationItem(
        title: 'مخزن المعرض',
        route: SettingsScreens(),
        icon: Icons.list_alt,
      ),
    ],
  ),
  NavigationItem(
    title: 'الانتاج',
    route: ProductScreens(),
    icon: Icons.build,
  ),
  NavigationItem(
    title: 'المبيعات',
    route: SettingsScreens(),
    icon: Icons.point_of_sale,
  ),
  NavigationItem(
    title: 'الاعدادات',
    route: SettingsScreens(),
    icon: Icons.settings,
  ),
];
