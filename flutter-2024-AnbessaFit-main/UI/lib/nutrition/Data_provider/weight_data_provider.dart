import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:anbessafit/nutrition/model/weight.dart';

final weightDataProviderProvider =
    Provider.autoDispose((ref) => WeightDataProvider(ref.read));

class WeightDataProvider {
  final Reader _reader;

  WeightDataProvider(this._reader);

  Future<Map<String, String>> _authenticatedHeaders() async {
    final sharedPreferences = await _reader(sharedPreferencesProvider);
    final token = sharedPreferences.getString('token');

    if (token == null) {
      throw Exception('Missing token in local storage.');
    }

    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', // Assuming JSON content type
    };
  }

  Future<void> createWeight(double weight) async {
    try {
      final dio = Dio();
      final headers = await _authenticatedHeaders();
      final response = await dio.post('http://localhost:3000/weightgain',
          data: {'weight': weight}, options: Options(headers: headers));

      if (response.statusCode != 201) {
        throw Exception('Failed to create weight');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteWeight(int weightId) async {
    try {
      final dio = Dio();
      final headers = await _authenticatedHeaders();
      final response = await dio.delete(
          'http://localhost:3000/weightgain/$weightId',
          options: Options(headers: headers));

      if (response.statusCode != 200) {
        throw Exception('Failed to delete weight');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateWeight(int weightId, double weight) async {
    try {
      final dio = Dio();
      final headers = await _authenticatedHeaders();
      final response = await dio.patch(
          'http://localhost:3000/weightgain/$weightId',
          data: {'weight': weight},
          options: Options(headers: headers));

      if (response.statusCode != 200) {
        throw Exception('Failed to update weight');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<List<WeightGainPlan>> getWeightById(int weightId) async {
    try {
      final dio = Dio();
      final headers = await _authenticatedHeaders();
      final response = await dio.get(
        'http://localhost:3000/weightgain/$weightId',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data
            .map((weightJson) => WeightGainPlan.fromJson(weightJson))
            .toList();
      } else {
        throw Exception('Failed to get weight by ID');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<List<WeightGainPlan>> getWeights() async {
    try {
      final dio = Dio();
      final headers = await _authenticatedHeaders();
      final response = await dio.get('http://localhost:3000/',
          options: Options(headers: headers));

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data; // Directly use response.data
        return data.map((json) => WeightGainPlan.fromJson(json)).toList();
      } else {
        throw Exception('Failed to get weights');
      }
    } catch (error) {
      print('Error: $error');
      rethrow;
    }
  }
}
