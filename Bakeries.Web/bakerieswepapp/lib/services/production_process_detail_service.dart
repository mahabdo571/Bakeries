import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_config.dart';
import '../models/production_process_detail.dart';

class ProductionProcsessDetailService {
 

   static Future<List<ProductionProcessDetail>> getProductionProcessDetailByPruductionId(int id) async {
    try {
      final response =
          await http.get(Uri.parse( '${ApiConfig.ProductionProcessDetailByPruductionId}/$id'));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((data) => ProductionProcessDetail.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load Detail items');
      }
    } catch (e) {
      throw Exception('Error fetching Detail items: $e');
    }
  }
}
