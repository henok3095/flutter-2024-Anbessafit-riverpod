import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anbessafit/auth/data_provider/signup_data_provider.dart';
import 'package:anbessafit/auth/model/signup_model.dart';
import 'package:http/http.dart' as http;

final httpClientProvider = Provider<http.Client>((ref) {
  return http.Client();
});

final authRegDataProvider = Provider<AuthRegDataProvider>((ref) {
  final client = ref.watch(httpClientProvider);
  return AuthRegDataProvider(client);
});

final authRegRepositoryProvider = Provider<AuthRegRepository>((ref) {
  final dataProvider = ref.watch(authRegDataProvider);
  return AuthRegRepository(dataProvider: dataProvider);
});

class AuthRegRepository {
  final AuthRegDataProvider _dataProvider;

  AuthRegRepository({required AuthRegDataProvider dataProvider})
      : _dataProvider = dataProvider;

  Future<SignupData> register(SignupData registrationData) async {
    try {
      final registeredDataJson =
          await _dataProvider.registerUser(registrationData);
      final registeredData = SignupData.fromJson(registeredDataJson);
      return registeredData;
    } catch (error) {
      throw Exception('Registration failed: $error');
    }
  }
}
