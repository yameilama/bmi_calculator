import 'package:flutter/material.dart';
import 'bmi_gauge.dart';
import 'custom_input_field.dart';

class ImperialSystemForm extends StatefulWidget {
  const ImperialSystemForm({Key? key}) : super(key: key);

  @override
  State<ImperialSystemForm> createState() => _ImperialSystemFormState();
}

class _ImperialSystemFormState extends State<ImperialSystemForm> {
  final TextEditingController feetController = TextEditingController();
  final TextEditingController inchesController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  String validationMessage = '';
  bool showResult = false;
  String resultText = '';
  double bmiValue = 0.0;
  String bmiCategory = '';

  @override
  void dispose() {
    weightController.dispose();
    feetController.dispose();
    inchesController.dispose();
    super.dispose();
  }

  void resetFieldsFromImperial() {
    setState(() {
      showResult = false;
      validationMessage = '';
      resultText = '';
      weightController.clear();
      feetController.clear();
      inchesController.clear();
      bmiCategory = '';
      bmiValue = 0.0;
    });
  }

  void calculateImperialBMI() {
    final double weightLb = double.tryParse(weightController.text) ?? 0.0;
    final double feet = double.tryParse(feetController.text) ?? 0.0;
    final double inches = double.tryParse(inchesController.text) ?? 0.0;

    if (weightLb <= 0 || feet <= 0 || inches <= 0) {
      setState(() {
        validationMessage =
            'Please enter valid weight, feet, and inches values.';
        showResult = false;
        resultText = '';
      });
      return;
    }

    final double heightInches = (feet * 12.0) + inches;
    final double bmi = (weightLb / (heightInches * heightInches)) * 703.0;

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
              label: 'Feet',
              controller: feetController,
            ),
            CustomInputField(
              label: 'Inches',
              controller: inchesController,
            ),
            CustomInputField(
              label: 'Weight (pounds)',
              controller: weightController,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                minimumSize: const Size(350, 40),
              ),
              onPressed: calculateImperialBMI,
              child: const Text(
                'Calculate',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: resetFieldsFromImperial,
              child: const Text(
                'Reset',
                style: TextStyle(fontSize: 20),
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
                  fontSize: 16,
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
