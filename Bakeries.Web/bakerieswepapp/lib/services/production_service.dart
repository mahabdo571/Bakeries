import 'dart:convert';

import 'package:http/http.dart' as http;

import '../api_config.dart';
import '../models/production.dart';

class ProductionService {
  static Stream<List<Production>> getProductionStream(int productId) async* {
    while (true) {
      try {
        final response = await http.get(Uri.parse(
            '${ApiConfig.ProductionProcessWithAssociatedProduct}/$productId'));

        if (response.statusCode == 200) {
          List jsonResponse = json.decode(response.body);
          yield jsonResponse.map((data) => Production.fromJson(data)).toList();
        } else {
          throw Exception('Failed to load stock items');
        }
      } catch (e) {
        throw Exception('Error fetching stock items: $e');
      }

      await Future.delayed(const Duration(seconds: 5));
    }
  }

  static Future<void> deleteProduction(int id) async {
    final response = await http.delete(
      Uri.parse('${ApiConfig.ProductionById}$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete stock item');
    }
  }

  static Future<Production> addProduction(Production productionData) async {
    final response = await http.post(Uri.parse(ApiConfig.Production),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(productionData.toJson()));

    if (response.statusCode == 201) {
      return Production.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add Production');
    }
  }

  static Future<Production> updateProduction(
      int id, Production productionData) async {
    final response = await http.put(
      Uri.parse('${ApiConfig.ProductionById}$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(productionData.toJson()),
    );

    if (response.statusCode == 200) {
      return Production.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update purchase');
    }
  }

  static Future<Production> getProductionById(int id) async {
    try {
      // إرسال الطلب إلى الـ API
      final response =
          await http.get(Uri.parse('${ApiConfig.ProductionById}$id'));

      // تحقق إذا كانت الاستجابة ناجحة
      if (response.statusCode == 200) {
        // فك التشفير وتحويل البيانات إلى كائن Product
        final data = json.decode(response.body);

        if (data is Map<String, dynamic>) {
          return Production.fromJson(data); // إرجاع الكائن المطلوب
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        // إذا لم تكن حالة الاستجابة 200
        throw Exception(
            'Failed to load product. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // معالجة أي خطأ يحدث أثناء الطلب
      throw Exception('Error fetching product: $e');
    }
  }
}
