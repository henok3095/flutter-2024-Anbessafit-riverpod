import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeightLossRepository {
  final String baseUrl;

  WeightLossRepository({required this.baseUrl});

  Future<void> createWeightLossPlan({
    required DateTime startingDate,
    required DateTime dueDate,
    required String weightGoal,
    required String calorieGoal,
    required String weightLost,
    required String calorieBurnt,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create-weight-loss-plan'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'startingDate': startingDate.toIso8601String(),
        'dueDate': dueDate.toIso8601String(),
        'weightGoal': weightGoal,
        'calorieGoal': calorieGoal,
        'weightLost': weightLost,
        'calorieBurnt': calorieBurnt,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create weight loss plan');
    }
  }
}
