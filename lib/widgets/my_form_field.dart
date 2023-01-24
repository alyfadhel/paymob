import 'package:flutter/material.dart';

class MyFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final FormFieldValidator<String>validator;
  final bool isPassword;
  final double radius;
  final IconData prefix;
  final String label;
  final bool isUpperCase;
  const MyFormField({
    Key? key,
    required this.controller,
    required this.type,
    required this.validator,
    this.isPassword = false,
    this.radius = 0.0,
    required this.prefix,
    required this.label,
    this.isUpperCase = true,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      validator: validator,
      obscureText: isPassword,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        prefixIcon: Icon(prefix),
        label: isUpperCase ? Text(label.toUpperCase()) : Text(label),
      ),
    );
  }
}
