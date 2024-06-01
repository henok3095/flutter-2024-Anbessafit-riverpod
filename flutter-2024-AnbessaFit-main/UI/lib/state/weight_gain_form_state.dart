// lib/state/weight_gain_form_state.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/weight_gain_service.dart'; // Import the service

class WeightGainFormState {
  final DateTime? startingDate;
  final DateTime? dueDate;
  final String weightGainGoal;
  final String calorieIntakeGoal;
  final String weightGained;
  final String caloriesConsumed;

  WeightGainFormState({
    this.startingDate,
    this.dueDate,
    required this.weightGainGoal,
    required this.calorieIntakeGoal,
    required this.weightGained,
    required this.caloriesConsumed,
  });

  WeightGainFormState copyWith({
    DateTime? startingDate,
    DateTime? dueDate,
    String? weightGainGoal,
    String? calorieIntakeGoal,
    String? weightGained,
    String? caloriesConsumed,
  }) {
    return WeightGainFormState(
      startingDate: startingDate ?? this.startingDate,
      dueDate: dueDate ?? this.dueDate,
      weightGainGoal: weightGainGoal ?? this.weightGainGoal,
      calorieIntakeGoal: calorieIntakeGoal ?? this.calorieIntakeGoal,
      weightGained: weightGained ?? this.weightGained,
      caloriesConsumed: caloriesConsumed ?? this.caloriesConsumed,
    );
  }
}

class WeightGainFormNotifier extends StateNotifier<WeightGainFormState> {
  final WeightGainService weightGainService;

  WeightGainFormNotifier(this.weightGainService)
      : super(WeightGainFormState(
          startingDate: null,
          dueDate: null,
          weightGainGoal: '',
          calorieIntakeGoal: '',
          weightGained: '',
          caloriesConsumed: '',
        ));

  void setStartingDate(DateTime date) {
    state = state.copyWith(startingDate: date);
  }

  void setDueDate(DateTime date) {
    state = state.copyWith(dueDate: date);
  }

  void setWeightGainGoal(String goal) {
    state = state.copyWith(weightGainGoal: goal);
  }

  void setCalorieIntakeGoal(String goal) {
    state = state.copyWith(calorieIntakeGoal: goal);
  }

  void setWeightGained(String gained) {
    state = state.copyWith(weightGained: gained);
  }

  void setCaloriesConsumed(String consumed) {
    state = state.copyWith(caloriesConsumed: consumed);
  }

  Future<void> submit() async {
    await weightGainService.submitWeightGainPlan(
      startingDate: state.startingDate!,
      dueDate: state.dueDate!,
      weightGainGoal: state.weightGainGoal,
      calorieIntakeGoal: state.calorieIntakeGoal,
      weightGained: state.weightGained,
      caloriesConsumed: state.caloriesConsumed,
    );
  }
}

final weightGainFormNotifierProvider =
    StateNotifierProvider<WeightGainFormNotifier, WeightGainFormState>((ref) {
  final weightGainService = ref.watch(weightGainServiceProvider);
  return WeightGainFormNotifier(weightGainService);
});
