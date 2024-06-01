import 'package:http/http.dart' as http;
import 'dart:convert';

class AddPlanRepository {
  final String baseUrl;

  AddPlanRepository({required this.baseUrl});

  Future<void> addPlan({
    required String task,
    required DateTime date,
    required int reps,
    required int sets,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add-plan'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'task': task,
        'date': date.toIso8601String(),
        'reps': reps,
        'sets': sets,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add plan');
    }
  }
}
