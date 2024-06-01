import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anbessafit/auth/data_provider/signin_data_provider.dart';
import 'package:anbessafit/auth/model/auth_model.dart';
import 'package:anbessafit/auth/model/signin_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider =
    FutureProvider<SharedPreferences>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs;
});

final authDataProvider = Provider<AuthDataProvider>((ref) {
  return AuthDataProvider(ref.watch(dioProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dataProvider = ref.watch(authDataProvider);
  final sharedPreferences = ref.watch(sharedPreferencesProvider).maybeWhen(
        data: (prefs) => prefs,
        orElse: () => throw Exception('SharedPreferences not initialized'),
      );
  return AuthRepository(dataProvider, sharedPreferences);
});

class AuthRepository {
  final AuthDataProvider dataProvider;
  final SharedPreferences sharedPreferences;

  AuthRepository(this.dataProvider, this.sharedPreferences);

  Future<AuthLoginData> login(String email, String password, Role role) async {
    try {
      final data = await dataProvider.login(email, password, role);
      final token = data['token'];
      final userId = data['userId'];

      await sharedPreferences.setString('token', token);
      await sharedPreferences.setInt('userId', userId);

      return AuthLoginData(
        token: token,
        id: userId,
      );
    } catch (error) {
      rethrow;
    }
  }
}
