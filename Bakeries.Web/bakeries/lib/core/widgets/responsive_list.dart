import 'package:flutter/material.dart';
import '/core/styles/app_styles.dart';
import '/utils/responsive_sizes.dart';

class ResponsiveList<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(T) itemBuilder;
  final int desktopCrossAxisCount;

  const ResponsiveList({
    Key? key,
    required this.items,
    required this.itemBuilder,
    this.desktopCrossAxisCount = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizes.isDesktop(context)
        ? GridView.builder(
            padding: EdgeInsets.all(AppStyles.defaultPadding),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: desktopCrossAxisCount,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: AppStyles.defaultPadding,
              mainAxisSpacing: AppStyles.defaultPadding,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) => itemBuilder(items[index]),
          )
        : ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) => itemBuilder(items[index]),
          );
  }
}
