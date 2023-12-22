import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class BMIGauge extends StatelessWidget {
  final double bmiValue;
  final String bmiCategory;

  const BMIGauge({
    Key? key,
    required this.bmiValue,
    required this.bmiCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 42,
          ranges: <GaugeRange>[
            GaugeRange(
              startValue: 0,
              endValue: 18.5,
              color: Colors.purple,
            ),
            GaugeRange(
              startValue: 18.5,
              endValue: 24.9,
              color: Colors.green,
            ),
            GaugeRange(
              startValue: 25,
              endValue: 29.9,
              color: Colors.orange,
            ),
            GaugeRange(
              startValue: 30,
              endValue: 42,
              color: Colors.red,
            ),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(value: bmiValue),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Text(
                bmiValue.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              angle: 90,
              positionFactor: 0.5,
            ),
            GaugeAnnotation(
              widget: Text(
                bmiCategory,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: bmiCategory == 'Obese' ||
                          bmiCategory == 'Overweight' ||
                          bmiCategory == 'Underweight'
                      ? Colors.red
                      : Colors.green,
                ),
              ),
              angle: 90,
              positionFactor: 0.7,
            ),
          ],
        ),
      ],
    );
  }
}
