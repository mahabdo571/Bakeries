import 'dart:convert';

import 'package:http/http.dart' as http;

import '/models/product.dart';

class InventoryDataSource {
  final String baseUrl = 'http://localhost:5000/api';

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/Stock/All'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Stock'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add product');
    }
  }

  Future<void> updateProduct(Product product) async {
    final response = await http.put(
      Uri.parse('$baseUrl/Stock/${product.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update product');
    }
  }

  Future<void> deleteProduct(int productId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/Stock/$productId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete product');
    }
  }
}
