import 'package:flutter/material.dart';

class MyGestureDetector extends StatelessWidget {
  Function()? onTap;
  String text;
  MyGestureDetector({super.key, required this.onTap, required this.text});
  static const introColor = Color.fromRGBO(89, 177, 137, 1);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: introColor, width: 3),
            borderRadius: BorderRadius.circular(8),
          ),
          width: 200,
          height: 50,
          child: Center(
              child: Text(
            text,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: introColor),
          ))),
    );
  }
}
