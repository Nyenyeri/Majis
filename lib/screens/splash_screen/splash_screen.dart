import 'package:flutter/material.dart';
import 'package:rondera/constants/constants.dart';
import 'package:rondera/screens/home_page/home_page.dart';
import 'package:rondera/widgets/main_icon.dart';
import 'package:rondera/widgets/texts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static const String routeName = "SplashScreen";

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushNamedAndRemoveUntil(context, HomePage.routeName, (route) => false);
    }, );
    return const Scaffold(
      backgroundColor: scaffoldColor,
      body: SafeArea(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  MainIcon(
                      imagePath: "assets/rondera.png",
                      width: 80,
                      color: whiteColor),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  BoldText(text: "Rondera", size: 20, color: whiteColor),
                ],
              ),

            ),
            Padding(
              padding: EdgeInsets.only(top: 250),
              child: SimpleText(text: "Make researches on your prefered topic ", size: 13, color: whiteColor),
            )
          ],
        ),
      ),
    );
  }
}
