import 'package:flutter/material.dart';
import 'package:rondera/routes.dart';
import 'package:rondera/screens/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Rondera",
      initialRoute: SplashScreen.routeName,
      routes: routes,

    );
  }
}