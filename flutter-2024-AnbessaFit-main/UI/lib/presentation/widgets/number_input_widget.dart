import 'package:flutter/material.dart';

class NumberInputRow extends StatelessWidget {
  final String labelText;
  final String initialValue;
  final ValueChanged<String>? onChanged;

  NumberInputRow({
    required this.labelText,
    required this.initialValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(labelText),
        SizedBox(
          width: 100,
          child: TextFormField(
            initialValue: initialValue,
            keyboardType: TextInputType.number,
            onChanged: onChanged,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
