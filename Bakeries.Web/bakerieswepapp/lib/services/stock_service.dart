import 'dart:convert';
import 'package:bakerieswepapp/models/Stock.dart';
import 'package:http/http.dart' as http;
import 'package:bakerieswepapp/api_config.dart';

class StockService {
  static Future<List<Stock>> getStockItems() async {
    try {
      final response = await http.get(Uri.parse(ApiConfig.stockAll));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((data) => Stock.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load stock items');
      }
    } catch (e) {
      throw Exception('Error fetching stock items: $e');
    }
  }
}
