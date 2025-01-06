import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Stock.dart';
import '../api_config.dart';

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

  static Stream<List<Stock>> getStockStream() async* {
    while (true) {
      try {
        final response = await http.get(Uri.parse(ApiConfig.stockAll));

        if (response.statusCode == 200) {
          List jsonResponse = json.decode(response.body);
          yield jsonResponse.map((data) => Stock.fromJson(data)).toList();
        } else {
          throw Exception('Failed to load stock items');
        }
      } catch (e) {
        throw Exception('Error fetching stock items: $e');
      }

      await Future.delayed(const Duration(seconds: 2));
    }
  }

  static Future<void> deleteStock(int id) async {
    final response = await http.delete(
      Uri.parse('${ApiConfig.StockById}$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete stock item');
    }
  }

  static Future<Stock> addStock(Stock stockData) async {
    final response = await http.post(Uri.parse(ApiConfig.stock),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(stockData.toJson()));

    if (response.statusCode == 201) {
      return Stock.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add stock item');
    }
  }

  static Future<Stock> updateStock(int id, Stock stockData) async {
    final response = await http.put(
      Uri.parse('${ApiConfig.StockById}$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(stockData.toJson()),
    );

    if (response.statusCode == 200) {
      return Stock.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update stock item');
    }
  }
}
