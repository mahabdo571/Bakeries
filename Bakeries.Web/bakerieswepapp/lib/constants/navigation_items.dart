import '../Screens/production/production_page.dart';
import '../screens/settings/setting_page.dart';
import 'package:flutter/material.dart';

import '../models/navigation_item.dart';
import '../screens/Product/product_page.dart';
import '../screens/home/home_page.dart';
import '../screens/purchases/purchases_page.dart';
import '../screens/stock/stock_page.dart';

final List<NavigationItem> navigationItems = [
  NavigationItem(
    title: 'الرئيسية',
    route: const HomePage(),
  ),
  NavigationItem(
    title: 'المشتريات والفواتير',
    route: PurchasesPage(),
  ),
  NavigationItem(
    title: 'المخازن',
    route: StockScreens(),
  ),
  NavigationItem(
    title: 'الانتاج',
    route: ProductScreens(), // Replace with actual Products page
  ),
  NavigationItem(
    title: 'المبيعات',
    route: ProductScreens(), // Replace with actual Production page
  ),
  NavigationItem(
    title: 'الاعدادات',
    route: SettingsScreens(),
    // Replace with actual Production page
  ),
];
