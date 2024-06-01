import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/weight_gain_provider.dart';
import '../widgets/date_input_widgets.dart';
import '../widgets/number_input_widget.dart';

class CreatePlanWeightGain extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weightGainData = ref.watch(weightGainProvider);

    Future<void> _selectStartingDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: weightGainData.startingDate ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (picked != null && picked != weightGainData.startingDate) {
        ref.read(weightGainProvider.notifier).updateStartingDate(picked);
      }
    }

    Future<void> _selectDueDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: weightGainData.dueDate ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (picked != null && picked != weightGainData.dueDate) {
        ref.read(weightGainProvider.notifier).updateDueDate(picked);
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Create Plan',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text('Starting Date:'),
                    subtitle: Text(weightGainData.startingDate?.toString() ??
                        'Select a date'),
                    onTap: () => _selectStartingDate(context),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    title: Text('Due Date:'),
                    subtitle: Text(
                        weightGainData.dueDate?.toString() ?? 'Select a date'),
                    onTap: () => _selectDueDate(context),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Weight gaining goal in kg:',
                      errorText: weightGainData.weightGainGoalError,
                    ),
                    onChanged: (value) {
                      final double? weightGoal = double.tryParse(value);
                      if (weightGoal != null) {
                        ref
                            .read(weightGainProvider.notifier)
                            .updateWeightGainGoal(weightGoal);
                      } else {
                        ref
                            .read(weightGainProvider.notifier)
                            .setWeightGainGoalError('Invalid number');
                      }
                    },
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Burnt Calorie Goal:',
                      errorText: weightGainData.calorieGoalError,
                    ),
                    onChanged: (value) {
                      final double? calorieGoal = double.tryParse(value);
                      if (calorieGoal != null) {
                        ref
                            .read(weightGainProvider.notifier)
                            .updateCalorieGoal(calorieGoal);
                      } else {
                        ref
                            .read(weightGainProvider.notifier)
                            .setCalorieGoalError('Invalid number');
                      }
                    },
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Weight Gain:',
                      errorText: weightGainData.weightGainError,
                    ),
                    onChanged: (value) {
                      final double? weightGain = double.tryParse(value);
                      if (weightGain != null) {
                        ref
                            .read(weightGainProvider.notifier)
                            .updateWeightGain(weightGain);
                      } else {
                        ref
                            .read(weightGainProvider.notifier)
                            .setWeightGainError('Invalid number');
                      }
                    },
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Calorie Burnt:',
                      errorText: weightGainData.calorieError,
                    ),
                    onChanged: (value) {
                      final double? calorie = double.tryParse(value);
                      if (calorie != null) {
                        ref
                            .read(weightGainProvider.notifier)
                            .updateBurntCalorie(calorie);
                      } else {
                        ref
                            .read(weightGainProvider.notifier)
                            .setCalorieError('Invalid number');
                      }
                    },
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Implement create plan functionality
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        child: Text(
                          'Create Plan',
                          style: TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
