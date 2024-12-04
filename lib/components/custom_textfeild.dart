import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final String hintText;
  final void Function(String?)? onSaves;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.label,
    required this.obscureText,
    required this.hintText,
    required this.onSaves,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        label: Text(label),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple),
        ),
        fillColor: Colors.grey.shade100,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade500),
      ),
      obscureText: obscureText,
      onSaved: onSaves,
      validator: validator,
    );
  }
}
