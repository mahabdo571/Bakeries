import 'package:flutter/material.dart';

class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;

  const ResponsiveGrid({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount;
        if (constraints.maxWidth < 600) {
          crossAxisCount = 1; // Mobile
        } else if (constraints.maxWidth < 1200) {
          crossAxisCount = 2; // Tablet
        } else {
          crossAxisCount = 4; // Desktop
        }

        return GridView.count(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 1.3,
          children: children,
        );
      },
    );
  }
}