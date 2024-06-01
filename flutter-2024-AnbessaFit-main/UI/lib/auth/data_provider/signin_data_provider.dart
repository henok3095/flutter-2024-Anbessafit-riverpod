import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anbessafit/auth/model/signin_model.dart';
import 'package:dio/dio.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final authDataProvider = Provider<AuthDataProvider>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthDataProvider(dio);
});

class AuthDataProvider {
  final Dio dio;

  AuthDataProvider(this.dio);

  Future<Map<String, dynamic>> login(
      String email, String password, Role role) async {
    try {
      final response = await dio.post(
        'http://localhost:3000/auth/login',
        data: {
          'email': email,
          'password': password,
          'role': role.toString().split('.').last,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        final token = data['access_token'];
        final userId = data['userId'];

        if (userId != null && userId is int) {
          return {
            'token': token,
            'userId': userId,
          };
        } else {
          throw Exception('User ID is invalid or missing');
        }
      } else {
        final errorMessage = response.data['message'];
        throw Exception('Login failed: $errorMessage');
      }
    } catch (error) {
      rethrow;
    }
  }
}
