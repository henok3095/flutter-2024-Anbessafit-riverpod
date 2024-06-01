import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anbessafit/models/user.dart';
import 'package:anbessafit/repositories/auth_repository.dart';
import 'package:anbessafit/models/login_dto.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences package

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(baseUrl: 'http://localhost:3000');
});

final userProvider = FutureProvider<User>((ref) async {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.fetchUser();
});

final authProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<User?>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthNotifier(authRepository);
});

class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  final AuthRepository authRepository;

  AuthNotifier(this.authRepository) : super(AsyncValue.data(null));

  Future<void> login(String email, String password) async {
    state = AsyncValue.loading();
    try {
      final loginDto = LoginDto(
          email: email,
          password: password,
          role: 'user'); // Assuming 'role' is required
      await authRepository.login(loginDto);
      final user = await authRepository.fetchUser();
      state = AsyncValue.data(user);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> register(Map<String, dynamic> createUserDto) async {
    state = AsyncValue.loading();
    try {
      await authRepository.register(createUserDto);
      state = AsyncValue.data(null);

      // Display successful message
      print('Registration successful');
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);

      // Display unsuccessful message
      print('Registration unsuccessful');
    }
  }

  Future<void> logout() async {
    state = AsyncValue.data(null);
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
  }
}
