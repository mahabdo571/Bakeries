import 'package:flutter/material.dart';

class NavigationItem {
  final String title;
  final Widget? route;
  final List<NavigationItem>? subItems;

  NavigationItem({
    required this.title,
    this.route,
    this.subItems,
  });

  bool get hasSubItems => subItems != null && subItems!.isNotEmpty;
}
