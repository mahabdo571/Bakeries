import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '/models/purchase.dart';

class PurchasesRepository {
  Future<List<Purchase>> getPurchases() async {
    await Future.delayed(Duration(seconds: 1));
    final jsonString = await rootBundle.loadString('assets/json/purchases.json');
    final jsonData = json.decode(jsonString) as List;
    return jsonData.map((json) => Purchase.fromJson(json)).toList();
  }

  Future<void> addPurchase(Purchase purchase) async {
    await Future.delayed(Duration(seconds: 1));
    // In a real app, you would add the purchase to the database
    print('Adding purchase: ${purchase.toJson()}');
  }
}

