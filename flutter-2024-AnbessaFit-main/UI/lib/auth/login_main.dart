import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anbessafit/auth/data_provider/signin_data_provider.dart';
import 'package:anbessafit/auth/repository/signin_repo.dart';
import 'package:anbessafit/auth/presentation/login.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

final sharedPreferencesProvider =
    FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

final authDataProvider = Provider<AuthDataProvider>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthDataProvider(dio);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dataProvider = ref.watch(authDataProvider);
  final sharedPreferences = ref.watch(sharedPreferencesProvider).maybeWhen(
        data: (prefs) => prefs,
        orElse: () => throw Exception('SharedPreferences not initialized'),
      );
  return AuthRepository(dataProvider, sharedPreferences);
});

void main() {
  runApp(ProviderScope(child: MyLogin()));
}

class MyLogin extends StatelessWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Consumer(
        builder: (context, watch, _) {
          final sharedPreferencesAsyncValue = watch(sharedPreferencesProvider);

          return sharedPreferencesAsyncValue.when(
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) => Text('Error: $error'),
            data: (sharedPreferences) {
              return SignInScreen();
            },
          );
        },
      ),
    );
  }
}
