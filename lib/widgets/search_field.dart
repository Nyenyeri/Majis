import 'package:flutter/material.dart';
import 'package:rondera/constants/constants.dart';

class SearcField extends StatelessWidget {
  const SearcField({super.key, required this.text, required this.countryController, this.onPressed});
  final String text;
  final void Function()? onPressed;
  final TextEditingController countryController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      decoration: BoxDecoration(
        border: Border.all(color: whiteColor, width: 2, ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: text,
          hintStyle: const TextStyle(
            color: whiteColor,
            fontSize: 13,
          ),
          //alignLabelWithHint: true,
          contentPadding: const EdgeInsets.all(10),
          suffixIcon: IconButton(onPressed: onPressed, icon: const Icon(Icons.search, size: 20, color: whiteColor,)),
          border: InputBorder.none,
        ),
        controller: countryController,
        cursorColor: whiteColor,
        style: TextStyle(color: whiteColor),
      ),
    );
  }
}
