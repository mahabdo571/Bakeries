import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '/models/production.dart';

class ProductionRepository {
  Future<List<Production>> getProductions() async {
    await Future.delayed(Duration(seconds: 1));
    final jsonString = await rootBundle.loadString('assets/json/production.json');
    final jsonData = json.decode(jsonString) as List;
    return jsonData.map((json) => Production.fromJson(json)).toList();
  }

  Future<void> addProduction(Production production) async {
    await Future.delayed(Duration(seconds: 1));
    // In a real app, you would add the production to the database
    print('Adding production: ${production.toJson()}');
  }
}

