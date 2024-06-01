import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/weight_gain_dto.dart';

class WeightGainRepository {
  final String baseUrl;

  WeightGainRepository(this.baseUrl);

  Future<void> createWeightGainPlan(WeightGainDto dto) async {
    final response = await http.post(
      Uri.parse('$baseUrl/weightgain'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: dto.toJson(),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create weight gain plan');
    }
  }
}
