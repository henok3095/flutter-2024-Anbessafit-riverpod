// lib/repositories/auth_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:anbessafit/models/user.dart';
import 'package:anbessafit/models/login_dto.dart';

class AuthRepository {
  final String baseUrl;

  AuthRepository({required this.baseUrl});

  Future<String?> login(LoginDto loginDto) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(loginDto.toJson()),
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final token = body['access_token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);
      return token;
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> register(Map<String, dynamic> createUserDto) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(createUserDto),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to register');
    }
  }

  Future<User> fetchUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    final response = await http.get(
      Uri.parse('$baseUrl/protected/route'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }
}
