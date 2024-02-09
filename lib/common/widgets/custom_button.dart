import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, required this.text, required this.ontap, this.color});
  final String text;
  final Color? color;
  final void Function() ontap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(color: color == null ? Colors.white : Colors.black),
      ),
      onPressed: ontap,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        primary: color,
      ),
    );
  }
}
