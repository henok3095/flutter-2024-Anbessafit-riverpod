// test/unit/weight_loss_form_notifier_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:anbessafit/services/weight_loss_service.dart';
import 'package:anbessafit/state/weight_loss_form_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MockWeightLossService extends Mock implements WeightLossService {}

void main() {
  late MockWeightLossService mockWeightLossService;
  late ProviderContainer container;

  setUp(() {
    mockWeightLossService = MockWeightLossService();
    container = ProviderContainer(overrides: [
      weightLossServiceProvider.overrideWithValue(mockWeightLossService),
    ]);
  });

  tearDown(() {
    container.dispose();
  });

  test('initial state is empty', () {
    final notifier = container.read(weightLossFormNotifierProvider.notifier);
    expect(
      notifier.state,
      WeightLossFormState(
        startingDate: null,
        dueDate: null,
        weightLossGoal: '',
        calorieBurnGoal: '',
        weightLost: '',
        calorieBurnt: '',
      ),
    );
  });

  test('setStartingDate updates the state', () {
    final notifier = container.read(weightLossFormNotifierProvider.notifier);
    final date = DateTime.now();
    notifier.setStartingDate(date);
    expect(notifier.state.startingDate, date);
  });

  // Add more tests for other state changes...
}
