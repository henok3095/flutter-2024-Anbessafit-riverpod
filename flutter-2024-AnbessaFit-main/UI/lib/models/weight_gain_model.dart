class WeightGainModel {
  final DateTime? startingDate;
  final DateTime? dueDate;
  final double? weightGainGoal;
  final double? calorieGoal;
  final double? weightGain;
  final double? calorie;

  final String? weightGainGoalError;
  final String? calorieGoalError;
  final String? weightGainError;
  final String? calorieError;

  WeightGainModel({
    this.startingDate,
    this.dueDate,
    this.weightGainGoal,
    this.calorieGoal,
    this.weightGain,
    this.calorie,
    this.weightGainGoalError,
    this.calorieGoalError,
    this.weightGainError,
    this.calorieError,
  });

  WeightGainModel copyWith({
    DateTime? startingDate,
    DateTime? dueDate,
    double? weightGainGoal,
    double? calorieGoal,
    double? weightGain,
    double? calorie,
    String? weightGainGoalError,
    String? calorieGoalError,
    String? weightGainError,
    String? calorieError,
  }) {
    return WeightGainModel(
      startingDate: startingDate ?? this.startingDate,
      dueDate: dueDate ?? this.dueDate,
      weightGainGoal: weightGainGoal ?? this.weightGainGoal,
      calorieGoal: calorieGoal ?? this.calorieGoal,
      weightGain: weightGain ?? this.weightGain,
      calorie: calorie ?? this.calorie,
      weightGainGoalError: weightGainGoalError,
      calorieGoalError: calorieGoalError,
      weightGainError: weightGainError,
      calorieError: calorieError,
    );
  }
}
