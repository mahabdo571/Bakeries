import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bakerieswepapp/api_config.dart';
import 'package:bakerieswepapp/models/product.dart';


class ProductService {
  static Stream<List<Product>> getStockStream() async* {
    while (true) {
      try {
        final response = await http.get(Uri.parse(ApiConfig.ProductAll));

        if (response.statusCode == 200) {
          List jsonResponse = json.decode(response.body);
          yield jsonResponse.map((data) => Product.fromJson(data)).toList();
        } else {
          throw Exception('Failed to load stock items');
        }
      } catch (e) {
        throw Exception('Error fetching stock items: $e');
      }

      await Future.delayed(const Duration(seconds: 2));
    }
  }

  static Future<void> deleteProduct(int id) async {
    final response = await http.delete(
      Uri.parse('${ApiConfig.ProductById}$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete stock item');
    }
  }

  static Future<Product> addProduct(Product productData) async {
    final response = await http.post(Uri.parse(ApiConfig.Products),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(productData.toJson()));

    if (response.statusCode == 201) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add purchase');
    }
  }

  static Future<Product> updateProduct(int id, Product productData) async {
    final response = await http.put(
      Uri.parse('${ApiConfig.ProductById}$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(productData.toJson()),
    );

    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update purchase');
    }
  }
}
