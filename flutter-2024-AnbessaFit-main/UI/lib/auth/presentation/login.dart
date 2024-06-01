import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anbessafit/auth/data_provider/signin_data_provider.dart';
import 'package:anbessafit/auth/repository/signin_repo.dart';
import 'package:anbessafit/auth/model/signin_model.dart';
import 'package:anbessafit/auth/presentation/signup.dart';
import 'package:anbessafit/presentation/screens/home.dart';
import 'package:anbessafit/presentation/widgets/custom_scaffold.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum UserType { trainee, trainer }

void main() {
  runApp(MyApp());
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = Dio(); // You may need to configure Dio instance here
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return AuthRepository(
      AuthDataProvider(dio), sharedPreferences as SharedPreferences);
});

final signInDataNotifierProvider =
    StateNotifierProvider<SignInDataNotifier, SignInData>((ref) {
  return SignInDataNotifier();
});

class SignInData {}

final sharedPreferencesProvider =
    FutureProvider<AsyncValue<SharedPreferences>>((ref) async {
  return AsyncValue.data(await SharedPreferences.getInstance());
});

class SignInDataNotifier extends StateNotifier<SignInData> {
  SignInDataNotifier() : super(SignInData());

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  void setUserType(UserType userType) {
    state = state.copyWith(userType: userType);
  }

  Future<void> signIn(BuildContext context) async {
    final signInData = context.read(signInDataNotifierProvider.state);

    try {
      final authRepository = context.read(authRepositoryProvider);
      final authLoginData = await authRepository.login(
        signInData.email,
        signInData.password,
        signInData.userType == UserType.trainee ? Role.Trainee : Role.Trainer,
      );

      // Navigate to home screen after successful login
      Navigator.pushReplacementNamed(context, '/Home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: $e'),
        ),
      );
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'My App',
        home: SignInScreen(),
        routes: {
          '/Home': (context) => HomePageHome(),
        },
      ),
    );
  }
}

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AsyncValue<SharedPreferences>>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final sharedPreferences = snapshot.data!.data!;

          return ProviderScope(
            overrides: [
              sharedPreferencesProvider.overrideWithValue(sharedPreferences),
            ],
            child: const SignInForm(),
          );
        } else {
          return Text('No data');
        }
      },
    );
  }
}

class SignInForm extends ConsumerWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final signInDataNotifier = watch(signInDataNotifierProvider.notifier);
    final signInData = watch(signInDataNotifierProvider.State);

    return CustomScaffold(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(height: 10),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w900,
                          ),
                          children: [
                            TextSpan(
                              text: 'Anbessa ',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: 'Fit',
                              style: TextStyle(
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        controller:
                            TextEditingController(text: signInData.email),
                        onChanged: signInDataNotifier.setEmail,
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: 'Enter Email',
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        controller:
                            TextEditingController(text: signInData.password),
                        onChanged: signInDataNotifier.setPassword,
                        style: TextStyle(color: Colors.white),
                        obscureText: true,
                        obscuringCharacter: '*',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: 'Enter Password',
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(height: 25.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio<UserType>(
                            value: UserType.trainee,
                            groupValue: signInData.userType,
                            onChanged: signInDataNotifier.setUserType,
                          ),
                          const Text(
                            'Trainee',
                            style: TextStyle(color: Colors.white),
                          ),
                          Radio<UserType>(
                            value: UserType.trainer,
                            groupValue: signInData.userType,
                            onChanged: signInDataNotifier.setUserType,
                          ),
                          const Text(
                            'Trainer',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 25.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => signInDataNotifier.signIn(context),
                          child: const Text('Sign In'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                          ),
                        ),
                      ),
                      SizedBox(height: 25.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpScreen(),
                                ),
                              );
                            },
                            child: Text(
                              ' Sign Up',
                              style: TextStyle(color: Colors.orange),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
