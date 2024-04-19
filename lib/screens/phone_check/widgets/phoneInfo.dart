import 'package:flutter/material.dart';
import 'package:rondera/constants/constants.dart';
import 'package:rondera/widgets/texts.dart';

class PhoneInfo extends StatelessWidget {
  const PhoneInfo(
      {super.key,
      required this.textAPI,
      required this.textPhone,
      required this.color, required this.width, required this.height});
  final String textAPI;
  final String textPhone;
  final Color color;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.only(left: defaultPadding * 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SimpleText(text: textAPI, size: 16, color: whiteColor),
          SizedBox(height: defaultPadding,),
          BoldText(text: textPhone, size: 16, color: whiteColor),
        ],
      ),
    );
  }
}
