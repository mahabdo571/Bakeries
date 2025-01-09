import '../api_config.dart';
import '../models/product_ingredient.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class IngredientsService {
  static Stream<List<ProductIngredient>> getProductIngredientStream(
      int productId) async* {
    while (true) {
      try {
        final response = await http.get(Uri.parse(
            '${ApiConfig.GetAllProductIngredientByProductId}$productId'));

        if (response.statusCode == 200) {
          List jsonResponse = jsonDecode(response.body);

          yield jsonResponse
              .map((data) => ProductIngredient.fromJson(data))
              .toList();
        } else {
          throw Exception('Failed to load stock items');
        }
      } catch (e) {
        throw Exception('Error fetching stock items: $e');
      }

      await Future.delayed(const Duration(seconds: 2));
    }
  }

  static Future<ProductIngredient> addProductIngredient(
      ProductIngredient productIngredient) async {
    try {
      final response = await http.post(Uri.parse(ApiConfig.ProductIngredient),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(productIngredient.toJson()));

      if (response.statusCode == 201 || response.statusCode == 200) {
        return ProductIngredient.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 400) {
        throw Exception(jsonDecode(response.body)['messagge']);
      } else {
        throw Exception("خطأ غير معروف");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<ProductIngredient> updateProductIngredient(
      int id, ProductIngredient productIngredient) async {
    try {
      final response = await http.put(
          Uri.parse('${ApiConfig.ProductIngredientById}$id'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(productIngredient.toJson()));

      if (response.statusCode == 200) {
        return ProductIngredient.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(jsonDecode(response.body)['messagge']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> deleteProductIngredient(int id) async {
    final response = await http.delete(
      Uri.parse('${ApiConfig.ProductIngredientById}$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete purchase');
    }
  }
}
