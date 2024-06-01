import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anbessafit/auth/model/signup_model.dart';
import 'package:http/http.dart' as http;

// Step 1: Create a Provider for http.Client
final httpClientProvider = Provider<http.Client>((ref) {
  return http.Client();
});

// Step 2: Create a Provider for AuthRegDataProvider
final authRegDataProvider = Provider<AuthRegDataProvider>((ref) {
  final client = ref.watch(httpClientProvider);
  return AuthRegDataProvider(client);
});

class AuthRegDataProvider {
  final http.Client client;

  AuthRegDataProvider(this.client);

  Future<Map<String, dynamic>> registerUser(SignupData user) async {
    try {
      final response = await client.post(
        Uri.parse('http://192.168.56.1:3000/auth/register'),
        body: json.encode(user.toJson()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Registration failed with status: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
