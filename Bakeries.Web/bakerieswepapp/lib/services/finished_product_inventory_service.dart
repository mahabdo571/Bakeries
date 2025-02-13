  import 'package:bakerieswepapp/api_config.dart';
import 'package:bakerieswepapp/models/finished_product_inventory.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
class FinishedProductInventoryService {
  static Stream<List<FinishedProductInventory>> getFinishedProductInventoryStream() async* {
    while (true) {
      try {
        final response = await http.get(Uri.parse(ApiConfig.FinishedProductInventoryAll));

        if (response.statusCode == 200) {
          List jsonResponse = json.decode(response.body);
          yield jsonResponse.map((data) => FinishedProductInventory.fromJson(data)).toList();
        } else {
          throw Exception('Failed to load stock items');
        }
      } catch (e) {
        throw Exception('Error fetching stock items: $e');
      }

      await Future.delayed(const Duration(seconds: 5));
    }
  }


    static Future<List<FinishedProductInventory>> getFinishedProductInventoryItems() async {
    try {
      final response = await http.get(Uri.parse(ApiConfig.FinishedProductInventoryAll));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((data) => FinishedProductInventory.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load stock items');
      }
    } catch (e) {
      throw Exception('Error fetching stock items: $e');
    }
  }



  }