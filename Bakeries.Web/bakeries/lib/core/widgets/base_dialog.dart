import 'package:flutter/material.dart';
import '/core/styles/app_styles.dart';

class BaseDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final List<Widget> actions;

  const BaseDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyles.defaultRadius),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(AppStyles.defaultPadding),
            child: Row(
              children: [
                Text(title, style: Theme.of(context).textTheme.headlineSmall),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Flexible(child: content),
          const Divider(height: 1),
          ButtonBar(children: actions),
        ],
      ),
    );
  }
}
