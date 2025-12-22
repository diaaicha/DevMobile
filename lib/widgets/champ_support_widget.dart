import 'package:flutter/material.dart';

class ChampSupportWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final IconData icon;
  final int maxLines;
  final String? Function(String?)? validator;

  const ChampSupportWidget({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
    required this.icon,
    this.maxLines = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: maxLines > 1 ? 16 : 0,
        ),
      ),
      maxLines: maxLines,
      minLines: 1,
      validator: validator,
      style: const TextStyle(fontSize: 16),
    );
  }
}