// lib/models/login_dto.dart
class LoginDto {
  final String email;
  final String password;
  final String role;

  LoginDto({required this.email, required this.password, required this.role});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'role': role,
    };
  }
}
