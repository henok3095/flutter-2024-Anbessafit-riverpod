import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anbessafit/auth/data_provider/signup_data_provider.dart';
import 'package:anbessafit/auth/repository/signup_repo.dart';
import 'package:anbessafit/auth/presentation/signup.dart';

final authRegDataProvider = Provider<AuthRegDataProvider>((ref) {
  return AuthRegDataProvider();
});

final authRegRepositoryProvider = Provider<AuthRegRepository>((ref) {
  final dataProvider = ref.watch(authRegDataProvider);
  return AuthRegRepository(dataProvider: dataProvider);
});

void main() {
  runApp(ProviderScope(child: MySignup()));
}

class MySignup extends StatelessWidget {
  const MySignup({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _) {
        final authRegRepository = watch(authRegRepositoryProvider);

        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: ProviderScope(
            overrides: [
              authRegRepositoryProvider.overrideWithValue(authRegRepository),
            ],
            child: SignUpScreen(),
          ),
        );
      },
    );
  }
}
