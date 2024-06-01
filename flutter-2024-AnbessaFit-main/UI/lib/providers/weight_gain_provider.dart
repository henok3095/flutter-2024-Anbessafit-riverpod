import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/weight_gain_model.dart';

class WeightGainNotifier extends StateNotifier<WeightGainModel> {
  WeightGainNotifier() : super(WeightGainModel());

  void updateStartingDate(DateTime date) {
    state = state.copyWith(startingDate: date);
  }

  void updateDueDate(DateTime date) {
    state = state.copyWith(dueDate: date);
  }

  void updateWeightGainGoal(double goal) {
    state = state.copyWith(weightGainGoal: goal, weightGainGoalError: null);
  }

  void setWeightGainGoalError(String error) {
    state = state.copyWith(weightGainGoalError: error);
  }

  void updateCalorieGoal(double goal) {
    state = state.copyWith(calorieGoal: goal, calorieGoalError: null);
  }

  void setCalorieGoalError(String error) {
    state = state.copyWith(calorieGoalError: error);
  }

  void updateWeightGain(double weight) {
    state = state.copyWith(weightGain: weight, weightGainError: null);
  }

  void setWeightGainError(String error) {
    state = state.copyWith(weightGainError: error);
  }

  void updateBurntCalorie(double calorie) {
    state = state.copyWith(calorie: calorie, calorieError: null);
  }

  void setCalorieError(String error) {
    state = state.copyWith(calorieError: error);
  }
}

final weightGainProvider =
    StateNotifierProvider<WeightGainNotifier, WeightGainModel>((ref) {
  return WeightGainNotifier();
});
