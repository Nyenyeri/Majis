import 'package:flutter/material.dart';
import 'package:rondera/constants/constants.dart';

class SearchTopic extends StatelessWidget {
  const SearchTopic({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: blackColor,
            fontSize: 14,
            letterSpacing: 1,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
