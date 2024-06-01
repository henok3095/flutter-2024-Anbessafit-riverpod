// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anbessafit/presentation/screens/addplan.dart';
import 'package:anbessafit/presentation/screens/create_plan_page_weight_gain.dart';
import 'package:anbessafit/presentation/screens/create_plan_page_weight_loss.dart';
import 'package:anbessafit/presentation/screens/excercise.dart';
import 'package:anbessafit/presentation/screens/height_selection_screen.dart';
import 'package:anbessafit/presentation/screens/home.dart';
import 'package:anbessafit/presentation/screens/role_selection_screen.dart';
import 'package:anbessafit/presentation/screens/gender_selection_screen.dart';
import 'package:anbessafit/presentation/screens/home_screen.dart';
import 'package:anbessafit/presentation/screens/weight_selection_screen.dart';
import 'package:anbessafit/presentation/screens/welocome_screen.dart';
import 'package:anbessafit/presentation/screens/signin_screen.dart';
import 'package:anbessafit/presentation/screens/signup_screen.dart';
import 'package:anbessafit/presentation/screens/forget_password.dart';
import 'package:anbessafit/presentation/screens/weight_gain_screen.dart';
import 'package:anbessafit/presentation/screens/weight_loss_screen.dart';
import 'package:anbessafit/presentation/screens/nutrition.dart';
import 'package:anbessafit/presentation/screens/workoutplan.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => HomePageLoading(),
        '/WelcomeScreen': (context) => WelcomeScreen(),
        '/SignUpScreen': (context) => SignUpScreen(),
        '/SignInScreen': (context) => SignInScreen(),
        '/ForgetPasswordScreen': (context) => ForgetPasswordScreen(),
        '/RoleSelection': (context) => RoleSelection(),
        '/GenderSelectionScreen': (context) => GenderSelectionScreen(),
        '/WeightSelectionScreen': (context) => WeightSelectionScreen(),
        '/HeightSelectionScreen': (context) => HeightSelectionScreen(),
        '/Home': (context) => HomePageHome(),
        '/WeightLossScreen': (context) => WeightLossScreen(),
        '/WeightGainScreen': (context) => WeightGainScreen(),
        '/NutritionPage': (context) => NutritionPage(),
        '/WeightGainPage': (context) => WeightGainScreen(),
        '/WeightLossPage': (context) => WeightLossScreen(),
        '/Workoutplan': (context) => Workoutplan(),
        '/Addplan': (context) => Addplan(),
        '/ExercisePage': (context) => ExercisePage(),
        '/CreatePlanWeightGain': (context) => CreatePlanWeightGain(),
        '/CreatePlanWeightLoss': (context) => CreatePlanWeightLoss(),
      },
    );
  }
}
