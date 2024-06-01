import 'package:flutter/material.dart';
import 'package:anbessafit/nutrition/model/weight.dart';

class WeightGainScreen extends StatefulWidget {
  const WeightGainScreen({Key? key}) : super(key: key);

  @override
  _WeightGainScreenState createState() => _WeightGainScreenState();
}

class _WeightGainScreenState extends State<WeightGainScreen> {
  WeightGainPlan? _currentPlan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Weight Gain Plan',
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: Text(
                  'Weight Gain Advice:',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              // Include your weight gain advice texts here...
              const SizedBox(height: 20),
              Image.asset(
                'assets/weight_gain.jpg',
                height: 200,
                fit: BoxFit.contain,
              ),
              const Text(
                'Calorie Calculator',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // Include your calorie calculator widget here...
              const SizedBox(height: 20),
              const Text(
                'Current Weight Gain Plan',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange),
              ),
              // Display current weight gain plan information here...
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implement a method to refresh or edit the plan
                },
                child: const Text('Edit Plan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
