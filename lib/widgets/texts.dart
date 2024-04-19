import 'package:flutter/material.dart';

class BoldText extends StatelessWidget {
  const BoldText(
      {super.key, required this.text, required this.size, required this.color});
  final String text;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class SimpleText extends StatelessWidget {
  const SimpleText({super.key, required this.text, required this.size, required this.color});
  final String text;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: color,
      ),
    );
  }
}
