import 'dart:convert';

import 'package:http/http.dart' as http;

import '/models/purchase.dart';

class PurchasesRepository {
  final String baseUrl = 'http://localhost:5000/api/Purchases';

  Future<List<Purchase>> getPurchases() async {
    final response = await http.get(Uri.parse('$baseUrl/All'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Purchase.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load purchases');
    }
  }

  Future<void> addPurchase(Purchase purchase) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(purchase.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add purchase');
    }
  }

  Future<void> updatePurchase(Purchase purchase) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${purchase.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(purchase.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update purchase');
    }
  }

  Future<void> deletePurchase(int purchaseId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$purchaseId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete purchase');
    }
  }
}
