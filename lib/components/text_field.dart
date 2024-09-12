import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  static const introColor = Color.fromRGBO(89, 177, 137, 1);

  const MyTextField({super.key, required this.text, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(
          text,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: introColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: introColor, width: 3),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: introColor, width: 3),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: introColor, width: 3),
        ),
      ),
      cursorColor: introColor,
      style: const TextStyle(
        fontSize: 20,
        color: introColor,
      ),
    );
  }
}
