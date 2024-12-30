import 'dart:convert';

import 'package:bakerieswepapp/api_config.dart';
import 'package:bakerieswepapp/models/product.dart';
import 'package:http/http.dart' as http;
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


}