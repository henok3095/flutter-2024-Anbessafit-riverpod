// lib/state/weight_loss_form_state.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anbessafit/services/weight_loss_service.dart';

final weightLossServiceProvider = Provider<WeightLossService>((ref) {
  return WeightLossService();
});

final weightLossFormNotifierProvider =
    StateNotifierProvider<WeightLossFormNotifier, WeightLossFormState>((ref) {
  final service = ref.watch(weightLossServiceProvider);
  return WeightLossFormNotifier(service);
});

class WeightLossFormState {
  final DateTime? startingDate;
  final DateTime? dueDate;
  final String weightLossGoal;
  final String calorieBurnGoal;
  final String weightLost;
  final String calorieBurnt;

  WeightLossFormState({
    this.startingDate,
    this.dueDate,
    this.weightLossGoal = '',
    this.calorieBurnGoal = '',
    this.weightLost = '',
    this.calorieBurnt = '',
  });
}

class WeightLossFormNotifier extends StateNotifier<WeightLossFormState> {
  final WeightLossService _service;

  WeightLossFormNotifier(this._service) : super(WeightLossFormState());

  void setStartingDate(DateTime date) {
    state = WeightLossFormState(
      startingDate: date,
      dueDate: state.dueDate,
      weightLossGoal: state.weightLossGoal,
      calorieBurnGoal: state.calorieBurnGoal,
      weightLost: state.weightLost,
      calorieBurnt: state.calorieBurnt,
    );
  }

  void setDueDate(DateTime date) {
    state = WeightLossFormState(
      startingDate: state.startingDate,
      dueDate: date,
      weightLossGoal: state.weightLossGoal,
      calorieBurnGoal: state.calorieBurnGoal,
      weightLost: state.weightLost,
      calorieBurnt: state.calorieBurnt,
    );
  }

  void setWeightLossGoal(String goal) {
    state = WeightLossFormState(
      startingDate: state.startingDate,
      dueDate: state.dueDate,
      weightLossGoal: goal,
      calorieBurnGoal: state.calorieBurnGoal,
      weightLost: state.weightLost,
      calorieBurnt: state.calorieBurnt,
    );
  }

  void setCalorieBurnGoal(String goal) {
    state = WeightLossFormState(
      startingDate: state.startingDate,
      dueDate: state.dueDate,
      weightLossGoal: state.weightLossGoal,
      calorieBurnGoal: goal,
      weightLost: state.weightLost,
      calorieBurnt: state.calorieBurnt,
    );
  }

  void setWeightLost(String weight) {
    state = WeightLossFormState(
      startingDate: state.startingDate,
      dueDate: state.dueDate,
      weightLossGoal: state.weightLossGoal,
      calorieBurnGoal: state.calorieBurnGoal,
      weightLost: weight,
      calorieBurnt: state.calorieBurnt,
    );
  }

  void setCalorieBurnt(String calorie) {
    state = WeightLossFormState(
      startingDate: state.startingDate,
      dueDate: state.dueDate,
      weightLossGoal: state.weightLossGoal,
      calorieBurnGoal: state.calorieBurnGoal,
      weightLost: state.weightLost,
      calorieBurnt: calorie,
    );
  }

  Future<void> fetchInitialData() async {
    final weightLossGoal = await _service.getWeightLossGoal();
    final calorieBurnGoal = await _service.getCalorieBurnGoal();
    state = WeightLossFormState(
      startingDate: state.startingDate,
      dueDate: state.dueDate,
      weightLossGoal: weightLossGoal.toString(),
      calorieBurnGoal: calorieBurnGoal.toString(),
      weightLost: state.weightLost,
      calorieBurnt: state.calorieBurnt,
    );
  }

  Future<void> savePlan() async {
    final plan = {
      'startingDate': state.startingDate?.toIso8601String(),
      'dueDate': state.dueDate?.toIso8601String(),
      'weightLossGoal': state.weightLossGoal,
      'calorieBurnGoal': state.calorieBurnGoal,
      'weightLost': state.weightLost,
      'calorieBurnt': state.calorieBurnt,
    };
    await _service.saveWeightLossPlan(plan);
  }
}
