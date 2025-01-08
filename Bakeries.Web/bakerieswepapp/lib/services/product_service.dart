import 'dart:convert';

import 'package:http/http.dart' as http;

import '../api_config.dart';
import '../models/product.dart';


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


  static Future<Product> getProductById(int id) async {
  try {
    // إرسال الطلب إلى الـ API
    final response = await http.get(Uri.parse('${ApiConfig.ProductById}$id'));

    // تحقق إذا كانت الاستجابة ناجحة
    if (response.statusCode == 200) {
      // فك التشفير وتحويل البيانات إلى كائن Product
      final data = json.decode(response.body);
      
      if (data is Map<String, dynamic>) {
        return Product.fromJson(data); // إرجاع الكائن المطلوب
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      // إذا لم تكن حالة الاستجابة 200
      throw Exception('Failed to load product. Status code: ${response.statusCode}');
    }
  } catch (e) {
    // معالجة أي خطأ يحدث أثناء الطلب
    throw Exception('Error fetching product: $e');
  }
}

}
