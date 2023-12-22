import 'package:flutter/material.dart';
import 'bmi_gauge.dart';
import 'custom_input_field.dart';

class MetricSystemForm extends StatefulWidget {
  const MetricSystemForm({Key? key}) : super(key: key);

  @override
  State<MetricSystemForm> createState() => _MetricSystemFormState();
}

class _MetricSystemFormState extends State<MetricSystemForm> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  String validationMessage = '';
  bool showResult = false;
  String resultText = '';
  double bmiValue = 0.0;
  String bmiCategory = '';

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  void resetFieldsFromMetric() {
    setState(() {
      showResult = false;
      validationMessage = '';
      resultText = '';
      heightController.clear();
      weightController.clear();
      bmiCategory = '';
      bmiValue = 0.0;
    });
  }

  void calculateMetricBMI() {
    final double height = double.tryParse(heightController.text) ?? 0.0;
    final double weight = double.tryParse(weightController.text) ?? 0.0;

    if (weight <= 0 || height <= 0) {
      setState(() {
        validationMessage = 'Please enter valid weight, and height values.';
        showResult = false;
        resultText = '';
      });
      return;
    }

    final double heightInMeters = height / 100;
    final double bmi = weight / (heightInMeters * heightInMeters);

    String category = '';

    if (bmi < 18.5) {
      category = 'Underweight';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      category = 'Normal';
    } else if (bmi >= 24.9 && bmi < 29.9) {
      category = 'Overweight';
    } else {
      category = 'Obese';
    }

    setState(() {
      bmiValue = bmi;
      bmiCategory = category;
      resultText = 'Your BMI is: ${bmi.toStringAsFixed(2)} ($category)';
      showResult = true;
      validationMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Form(
        child: Column(
          children: [
            CustomInputField(
              label: 'Height (cm)',
              controller: heightController,
            ),
            CustomInputField(
              label: 'Weight (kg)',
              controller: weightController,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                minimumSize: const Size(350, 40),
              ),
              onPressed: calculateMetricBMI,
              child: const Text('Calculate',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: resetFieldsFromMetric,
              child: const Text(
                'Reset',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if (validationMessage.isNotEmpty)
              Text(
                validationMessage,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
            BMIGauge(
              bmiValue: bmiValue,
              bmiCategory: bmiCategory,
            ),
          ],
        ),
      ),
    );
  }
}
