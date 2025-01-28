import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '/models/user.dart';

class UsersRepository {
  Future<List<User>> getUsers() async {
    // Simulate API call with a delay
    await Future.delayed(Duration(seconds: 1));

    // Load and parse the JSON file
    final jsonString = await rootBundle.loadString('assets/json/users.json');
    final jsonData = json.decode(jsonString) as List;

    // Convert JSON to List<User>
    return jsonData.map((json) => User.fromJson(json)).toList();
  }

  Future<void> addUser(User user) async {
    // Simulate API call with a delay
    await Future.delayed(Duration(seconds: 1));

    // In a real app, you would add the user to the database
    print('Adding user: ${user.toJson()}');
  }

  Future<void> updateUser(User user) async {
    // Simulate API call with a delay
    await Future.delayed(Duration(seconds: 1));

    // In a real app, you would update the user in the database
    print('Updating user: ${user.toJson()}');
  }

  Future<void> deleteUser(String userId) async {
    // Simulate API call with a delay
    await Future.delayed(Duration(seconds: 1));

    // In a real app, you would delete the user from the database
    print('Deleting user with ID: $userId');
  }
}

