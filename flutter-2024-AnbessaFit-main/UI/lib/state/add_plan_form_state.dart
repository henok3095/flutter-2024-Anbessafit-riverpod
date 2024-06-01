import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:your_project_name/repositories/add_plan_repository.dart';

class AddPlanFormState {
  // Define state variables here
  DateTime? selectedDate;
  String task = '';
  int reps = 0;
  int sets = 0;
  bool isLoading = false;
  String? errorMessage;

  AddPlanFormState({
    this.selectedDate,
    this.task = '',
    this.reps = 0,
    this.sets = 0,
    this.isLoading = false,
    this.errorMessage,
  });
}

class AddPlanFormNotifier extends StateNotifier<AddPlanFormState> {
  final AddPlanRepository repository;

  AddPlanFormNotifier({required this.repository}) : super(AddPlanFormState());

  void setTask(String task) {
    state = state.copyWith(task: task);
  }

  void setReps(int reps) {
    state = state.copyWith(reps: reps);
  }

  void setSets(int sets) {
    state = state.copyWith(sets: sets);
  }

  Future<void> addPlan() async {
    if (state.selectedDate == null) {
      state = state.copyWith(errorMessage: 'Please select a date');
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await repository.addPlan(
        task: state.task,
        date: state.selectedDate!,
        reps: state.reps,
        sets: state.sets,
      );
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  void setSelectedDate(DateTime? date) {
    state = state.copyWith(selectedDate: date);
  }
}

final addPlanFormProvider =
    StateNotifierProvider<AddPlanFormNotifier, AddPlanFormState>((ref) {
  final repository = AddPlanRepository(baseUrl: 'https://your-backend-url.com');
  return AddPlanFormNotifier(repository: repository);
});
