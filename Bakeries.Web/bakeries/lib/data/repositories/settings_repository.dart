import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '/models/settings.dart';

class SettingsRepository {
  Future<Settings> getSettings() async {
    // Simulate API call with a delay
    await Future.delayed(Duration(seconds: 1));

    // Load and parse the JSON file
    final jsonString = await rootBundle.loadString('assets/json/settings.json');
    final jsonData = json.decode(jsonString);

    // Convert JSON to Settings
    return Settings.fromJson(jsonData);
  }

  Future<void> updateSettings(Settings settings) async {
    // Simulate API call with a delay
    await Future.delayed(Duration(seconds: 1));

    // In a real app, you would update the settings in the database
    print('Updating settings: ${settings.toJson()}');
  }
}

