import 'package:flutter/material.dart';

import '../../components/app_bar/app_bar_for_all_page.dart';

class SettingsScreens extends StatelessWidget {
  const SettingsScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarForAllPage(pageName: 'الاعدادات'),
      body: const Text("TODO"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.brown,
        child: const Icon(Icons.add),
      ),
    );
  }
}
