import 'package:flutter/material.dart';
import 'package:mydigital_id/app/theme/theme.dart';

class TextFField extends StatelessWidget {
  TextFField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.labelText,
      required this.icon,
      this.hide = false,
      this.keyboardType = TextInputType.name});

  final TextEditingController controller;
  final String labelText;
  final String hintText;
  IconData icon;
  bool hide;
  TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: hide,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        iconColor: primaryColor,
        fillColor: primaryColor,
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              50), // Adjust the value to make it more or less round
        ),
        errorStyle: const TextStyle(color: Colors.red),
        hintText: hintText,
      ),
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please $hintText';
        }
        return null;
      },
    );
  }
}
