import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../api_config.dart';
import '../models/Purchase.dart';

class PurchasesService {
  static Stream<List<Purchase>> getPurchasesStream() async* {
    while (true) {
      try {
        final response = await http.get(Uri.parse(ApiConfig.purchasesAll));

        if (response.statusCode == 200) {
          List jsonResponse = json.decode(response.body);
          yield jsonResponse.map((data) => Purchase.fromJson(data)).toList();
        } else {
          throw Exception('Failed to load purchases');
        }
      } catch (e) {
        throw Exception('Error fetching purchases: $e');
      }

      await Future.delayed(const Duration(seconds: 5));
    }
  }

  static Future<void> deletePurchase(int id) async {
    final response = await http.delete(
      Uri.parse('${ApiConfig.purchasesById}$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete purchase');
    }
  }

  static Future<Purchase> addPurchase(Purchase purchaseData) async {
    final response = await http.post(Uri.parse(ApiConfig.purchases),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(purchaseData.toJson()));

    if (response.statusCode == 201) {
      return Purchase.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add purchase');
    }
  }

  static Future<Purchase> updatePurchase(int id, Purchase purchaseData) async {
    final response = await http.put(
      Uri.parse('${ApiConfig.purchasesById}$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(purchaseData.toJson()),
    );

    if (response.statusCode == 200) {
      return Purchase.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update purchase');
    }
  }
}
