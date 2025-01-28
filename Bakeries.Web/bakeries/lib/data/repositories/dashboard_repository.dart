import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class DashboardData {
  final String latestInventoryUpdate;
  final String latestPurchase;
  final int productCount;
  final String latestProduction;

  DashboardData({
    required this.latestInventoryUpdate,
    required this.latestPurchase,
    required this.productCount,
    required this.latestProduction,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      latestInventoryUpdate: json['latestInventoryUpdate'],
      latestPurchase: json['latestPurchase'],
      productCount: json['productCount'],
      latestProduction: json['latestProduction'],
    );
  }
}

class DashboardRepository {
  Future<DashboardData> getDashboardData() async {
    // Simulate API call with a delay
    await Future.delayed(Duration(seconds: 1));

    // Load and parse the JSON file
    final jsonString = await rootBundle.loadString('assets/json/dashboard.json');
    final jsonData = json.decode(jsonString);

    // Convert JSON to DashboardData
    return DashboardData.fromJson(jsonData);
  }
}

