// lib/services/weight_gain_service.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeightGainService {
  Future<void> submitWeightGainPlan({
    required DateTime startingDate,
    required DateTime dueDate,
    required String weightGainGoal,
    required String calorieIntakeGoal,
    required String weightGained,
    required String caloriesConsumed,
  }) async {
    // Simulate a network call
    await Future.delayed(Duration(seconds: 1));
    // Normally, here you would send the data to your backend.
  }
}

final weightGainServiceProvider = Provider((ref) => WeightGainService());
