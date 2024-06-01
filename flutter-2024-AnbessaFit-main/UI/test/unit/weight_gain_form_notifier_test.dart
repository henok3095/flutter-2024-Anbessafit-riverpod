import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:anbessafit/services/weight_gain_service.dart';
import 'package:anbessafit/state/weight_gain_form_state.dart';

class MockWeightGainService extends Mock implements WeightGainService {}

void main() {
  late MockWeightGainService mockWeightGainService;
  late ProviderContainer container;

  setUp(() {
    mockWeightGainService = MockWeightGainService();
    container = ProviderContainer(overrides: [
      weightGainServiceProvider.overrideWithValue(mockWeightGainService),
    ]);
  });

  tearDown(() {
    container.dispose();
  });

  test('initial state is correct', () {
    final state = container.read(weightGainFormNotifierProvider);
    expect(state.startingDate, isNull);
    expect(state.dueDate, isNull);
    expect(state.weightGainGoal, '');
    expect(state.calorieIntakeGoal, '');
    expect(state.weightGained, '');
    expect(state.caloriesConsumed, '');
  });

  test('setStartingDate updates the state', () {
    final notifier = container.read(weightGainFormNotifierProvider.notifier);
    final date = DateTime.now();
    notifier.setStartingDate(date);
    expect(notifier.state.startingDate, date);
  });

  test('setDueDate updates the state', () {
    final notifier = container.read(weightGainFormNotifierProvider.notifier);
    final date = DateTime.now().add(Duration(days: 1));
    notifier.setDueDate(date);
    expect(notifier.state.dueDate, date);
  });

  test('setWeightGainGoal updates the state', () {
    final notifier = container.read(weightGainFormNotifierProvider.notifier);
    const goal = '10 kg';
    notifier.setWeightGainGoal(goal);
    expect(notifier.state.weightGainGoal, goal);
  });

  test(
      'submit calls WeightGainService.submitWeightGainPlan with correct values',
      () async {
    final notifier = container.read(weightGainFormNotifierProvider.notifier);

    final startingDate = DateTime.now();
    final dueDate = DateTime.now().add(Duration(days: 30));
    const weightGainGoal = '5 kg';
    const calorieIntakeGoal = '2500 kcal';
    const weightGained = '2 kg';
    const caloriesConsumed = '2000 kcal';

    notifier.setStartingDate(startingDate);
    notifier.setDueDate(dueDate);
    notifier.setWeightGainGoal(weightGainGoal);
    notifier.setCalorieIntakeGoal(calorieIntakeGoal);
    notifier.setWeightGained(weightGained);
    notifier.setCaloriesConsumed(caloriesConsumed);

    await notifier.submit();

    verify(() => mockWeightGainService.submitWeightGainPlan(
          startingDate: startingDate,
          dueDate: dueDate,
          weightGainGoal: weightGainGoal,
          calorieIntakeGoal: calorieIntakeGoal,
          weightGained: weightGained,
          caloriesConsumed: caloriesConsumed,
        )).called(1);
  });
}
