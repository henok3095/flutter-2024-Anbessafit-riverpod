import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../providers/weight_gain_provider.dart';

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

    Future<void> _createPlan() async {
      final url = Uri.parse('http://your-backend-url/weightgain');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'startingdate': weightGainData.startingDate?.toIso8601String(),
          'duedate': weightGainData.dueDate?.toIso8601String(),
          'weightGoal': weightGainData.weightGainGoal,
          'calorieGoal': weightGainData.calorieGoal,
          'calorie': weightGainData.calorie,
          'weight': weightGainData.weightGain,
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Plan created successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create plan')),
        );
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
                        labelText: 'Weight gaining goal in kg:'),
                    onChanged: (value) {
                      ref
                          .read(weightGainProvider.notifier)
                          .updateWeightGainGoal(double.parse(value));
                    },
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration:
                        InputDecoration(labelText: 'Burnt Calorie Goal:'),
                    onChanged: (value) {
                      ref
                          .read(weightGainProvider.notifier)
                          .updateCalorieGoal(double.parse(value));
                    },
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(labelText: 'Weight Gain:'),
                    onChanged: (value) {
                      ref
                          .read(weightGainProvider.notifier)
                          .updateWeightGain(double.parse(value));
                    },
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(labelText: 'Calorie Burnt:'),
                    onChanged: (value) {
                      ref
                          .read(weightGainProvider.notifier)
                          .updateBurntCalorie(double.parse(value));
                    },
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _createPlan,
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
