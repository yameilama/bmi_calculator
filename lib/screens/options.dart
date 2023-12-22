import 'package:flutter/material.dart';
import 'package:bmi_calculator/widgets/imperial.dart';
import 'package:bmi_calculator/widgets/metric.dart';

class Options extends StatefulWidget {
  const Options({Key? key}) : super(key: key);

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  String selectedSystem = 'Metric System';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        selectedSystem = 'Metric System';
                      });
                    },
                    child: Text(
                      'Metric System',
                      style: selectedSystem == 'Metric System'
                          ? const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            )
                          : const TextStyle(
                              color: Colors.black,
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        selectedSystem = 'Imperial System';
                      });
                    },
                    child: Text(
                      'Imperial System',
                      style: selectedSystem == 'Imperial System'
                          ? const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            )
                          : const TextStyle(
                              color: Colors.black,
                            ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 22,
              ),
              selectedSystem == 'Metric System'
                  ? const MetricSystemForm()
                  : const ImperialSystemForm(),
            ],
          ),
        ],
      ),
    );
  }
}
