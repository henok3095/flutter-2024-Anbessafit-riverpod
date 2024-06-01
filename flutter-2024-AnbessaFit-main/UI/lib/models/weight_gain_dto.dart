import 'dart:convert';

class WeightGainDto {
  final String startingdate;
  final String duedate;
  final int weightGoal;
  final int calorieGoal;
  final int calorie;
  final int weight;

  WeightGainDto({
    required this.startingdate,
    required this.duedate,
    required this.weightGoal,
    required this.calorieGoal,
    required this.calorie,
    required this.weight,
  });

  Map<String, dynamic> toMap() {
    return {
      'startingdate': startingdate,
      'duedate': duedate,
      'weightGoal': weightGoal,
      'calorieGoal': calorieGoal,
      'calorie': calorie,
      'weight': weight,
    };
  }

  String toJson() => json.encode(toMap());
}
