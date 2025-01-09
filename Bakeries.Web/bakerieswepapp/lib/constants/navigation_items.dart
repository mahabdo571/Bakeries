import 'package:bakerieswepapp/Screens/production/production_page.dart';

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
    title: 'المشتريات',
    route: PurchasesPage(),
  ),
  NavigationItem(
    title: 'المخزن',
    route: StockScreens(),
  ),
  NavigationItem(
    title: 'المنتجات',
    route: ProductScreens(), // Replace with actual Products page
  ),
  NavigationItem(
    title: 'عمليات الانتاج',
    route: ProductionScreen(), // Replace with actual Production page
  ),
];
