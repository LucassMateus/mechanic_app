import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.label,
    this.radius = 16,
    this.formKey,
    this.onChanged,
    this.controller,
    this.validator,
    this.inputFormatters,
    this.keyboardType,
    super.key,
  });

  final String label;
  final double radius;
  final Key? formKey;
  final void Function(String?)? onChanged;
  final TextEditingController? controller;
  final String? Function([String?])? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextFormField(
        key: formKey,
        onChanged: onChanged,
        validator: validator,
        controller: controller,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 15),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(radius)),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
