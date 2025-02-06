import 'package:flutter/material.dart';

class NavigationItem {
  final String title;
  final Widget? route;
  final List<NavigationItem>? subItems;
  final IconData icon;

  NavigationItem({
    required this.title,
    this.route,
    this.subItems,
    required this.icon,
  });

  bool get hasSubItems => subItems != null && subItems!.isNotEmpty;
}

