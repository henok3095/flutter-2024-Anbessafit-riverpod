import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anbessafit/presentation/screens/home.dart';
import 'package:anbessafit/presentation/screens/signup_screen.dart';
import 'package:anbessafit/presentation/widgets/custom_scaffold.dart';
import 'package:anbessafit/providers/auth_providers.dart';
import 'package:anbessafit/models/user.dart';

enum UserType { trainee, trainer }

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formSignInKey = GlobalKey<FormState>();
  bool rememberPassword = true;
  UserType? _userType;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    ref.listen<AsyncValue<User?>>(
      authProvider,
      (previous, next) {
        if (next is AsyncData<User?> && next.value != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else if (next is AsyncError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Unsuccessful login: ${next.error}')),
          );
        }
      },
    );

    return CustomScaffold(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 10,
            ),
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
                  key: _formSignInKey,
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
                        controller: _emailController,
                        style: TextStyle(
                          color: Colors.white,
                        ),
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
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        controller: _passwordController,
                        style: TextStyle(
                          color: Colors.white,
                        ),
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
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black12,
                            ),
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
                            groupValue: _userType,
                            onChanged: (UserType? value) {
                              setState(() {
                                _userType = value;
                              });
                            },
                          ),
                          const Text(
                            'Trainee',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Radio<UserType>(
                            value: UserType.trainer,
                            groupValue: _userType,
                            onChanged: (UserType? value) {
                              setState(() {
                                _userType = value;
                              });
                            },
                          ),
                          const Text(
                            'Trainer',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formSignInKey.currentState!.validate() &&
                                rememberPassword &&
                                _userType != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Processing Data'),
                                ),
                              );
                              String email = _emailController.text.trim();
                              String password = _passwordController.text.trim();
                              await authNotifier.login(email, password);
                            } else if (!rememberPassword) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Please agree to the processing of personal information.'),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please choose user role.'),
                                ),
                              );
                            }
                          },
                          child: authState is AsyncLoading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : const Text('Sign In'),
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
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpScreen()),
                              );
                            },
                            child: Text(
                              ' Sign Up',
                              style: TextStyle(
                                color: Colors.orange,
                              ),
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: SignInScreen(),
    );
  }
}

// Dummy HomeScreen widget for demonstration
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Welcome to the Home Screen!'),
      ),
    );
  }
}
