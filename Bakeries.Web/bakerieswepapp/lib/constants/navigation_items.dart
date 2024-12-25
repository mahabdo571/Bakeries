import 'package:flutter/material.dart';
import 'package:bakerieswepapp/models/navigation_item.dart';
import 'package:bakerieswepapp/screens/home/home_page.dart';
import 'package:bakerieswepapp/screens/PurchasesPage.dart';
import 'package:bakerieswepapp/screens/stockScreens.dart';

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
    route: StockScreens(), // Replace with actual Products page
  ),
  NavigationItem(
    title: 'عمليات الانتاج',
    route: StockScreens(), // Replace with actual Production page
  ),
];
