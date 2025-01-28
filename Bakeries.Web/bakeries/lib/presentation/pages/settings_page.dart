import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/bloc/settings/settings_bloc.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    context.read<SettingsBloc>().add(LoadSettings());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الإعدادات'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SettingsLoaded) {
            return ListView(
              padding: EdgeInsets.all(16),
              children: [
                Card(
                  child: ListTile(
                    title: Text('اسم الموقع'),
                    subtitle: Text(state.settings.siteName),
                    trailing: Icon(Icons.edit),
                    onTap: () {
                      // Open edit site name dialog
                    },
                  ),
                ),
                SizedBox(height: 8),
                Card(
                  child: ListTile(
                    title: Text('اللغة'),
                    subtitle: Text(state.settings.language),
                    trailing: Icon(Icons.language),
                    onTap: () {
                      // Open language selection dialog
                    },
                  ),
                ),
                SizedBox(height: 8),
                Card(
                  child: ListTile(
                    title: Text('طرق الدفع'),
                    subtitle: Text(state.settings.paymentMethods.join(', ')),
                    trailing: Icon(Icons.payment),
                    onTap: () {
                      // Open payment methods dialog
                    },
                  ),
                ),
                SizedBox(height: 8),
                Card(
                  child: ListTile(
                    title: Text('اللون الرئيسي'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Color(int.parse(state.settings.primaryColor)),
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.color_lens),
                      ],
                    ),
                    onTap: () {
                      // Open color picker dialog
                    },
                  ),
                ),
              ],
            );
          } else if (state is SettingsError) {
            return Center(child: Text('حدث خطأ: ${state.message}'));
          }
          return Container();
        },
      ),
    );
  }
}

