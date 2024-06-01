import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeightGainData {
  DateTime? startingDate;
  DateTime? dueDate;
  double weightGainGoal;
  double calorieGoal;
  double weightGain;
  double burntCalorie;

  WeightGainData({
    this.startingDate,
    this.dueDate,
    this.weightGainGoal = 0,
    this.calorieGoal = 0,
    this.weightGain = 0,
    this.burntCalorie = 0,
  });
}

class WeightGainNotifier extends StateNotifier<WeightGainData> {
  WeightGainNotifier() : super(WeightGainData());

  void updateStartingDate(DateTime date) {
    state = WeightGainData(
      startingDate: date,
      dueDate: state.dueDate,
      weightGainGoal: state.weightGainGoal,
      calorieGoal: state.calorieGoal,
      weightGain: state.weightGain,
      burntCalorie: state.burntCalorie,
    );
  }

  void updateDueDate(DateTime date) {
    state = WeightGainData(
      startingDate: state.startingDate,
      dueDate: date,
      weightGainGoal: state.weightGainGoal,
      calorieGoal: state.calorieGoal,
      weightGain: state.weightGain,
      burntCalorie: state.burntCalorie,
    );
  }

  void updateWeightGainGoal(double goal) {
    state = WeightGainData(
      startingDate: state.startingDate,
      dueDate: state.dueDate,
      weightGainGoal: goal,
      calorieGoal: state.calorieGoal,
      weightGain: state.weightGain,
      burntCalorie: state.burntCalorie,
    );
  }

  void updateCalorieGoal(double goal) {
    state = WeightGainData(
      startingDate: state.startingDate,
      dueDate: state.dueDate,
      weightGainGoal: state.weightGainGoal,
      calorieGoal: goal,
      weightGain: state.weightGain,
      burntCalorie: state.burntCalorie,
    );
  }

  void updateWeightGain(double gain) {
    state = WeightGainData(
      startingDate: state.startingDate,
      dueDate: state.dueDate,
      weightGainGoal: state.weightGainGoal,
      calorieGoal: state.calorieGoal,
      weightGain: gain,
      burntCalorie: state.burntCalorie,
    );
  }

  void updateBurntCalorie(double burnt) {
    state = WeightGainData(
      startingDate: state.startingDate,
      dueDate: state.dueDate,
      weightGainGoal: state.weightGainGoal,
      calorieGoal: state.calorieGoal,
      weightGain: state.weightGain,
      burntCalorie: burnt,
    );
  }
}

final weightGainProvider =
    StateNotifierProvider<WeightGainNotifier, WeightGainData>(
  (ref) => WeightGainNotifier(),
);
