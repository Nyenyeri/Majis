import 'package:flutter/material.dart';

class MainIcon extends StatelessWidget {
  const MainIcon({super.key, required this.imagePath, required this.width, required this.color});
  final String imagePath;
  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Image(image: AssetImage(imagePath), width: width, color: color,);
  }
}