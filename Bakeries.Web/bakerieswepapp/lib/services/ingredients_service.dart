import 'package:bakerieswepapp/api_config.dart';
import 'package:bakerieswepapp/models/product_ingredient.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class IngredientsService {

  static Stream<List<ProductIngredient>> getProductIngredientStream(int productId) async* {
    while (true) {
      try {
        final response = await http.get(Uri.parse('${ApiConfig.GetAllProductIngredientByProductId}$productId'));

        if (response.statusCode == 200) {
          List jsonResponse = json.decode(response.body);
         
          yield jsonResponse.map((data) => ProductIngredient.fromJson(data)).toList();
        } else {
          throw Exception('Failed to load stock items');
        }
      } catch (e) {
        throw Exception('Error fetching stock items: $e');
      }

      await Future.delayed(const Duration(seconds: 2));
    }
  }

}