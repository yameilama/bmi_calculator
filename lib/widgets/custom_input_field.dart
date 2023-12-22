import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const CustomInputField({
    Key? key,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          cursorColor: Colors.black,
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelText: label,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
