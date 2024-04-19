import 'package:flutter/material.dart';
import 'package:rondera/screens/covid_search/covid_search.dart';
import 'package:rondera/screens/dns/dns_search.dart';
import 'package:rondera/screens/home_page/home_page.dart';
import 'package:rondera/screens/phone_check/phone_check.dart';
import 'package:rondera/screens/splash_screen/splash_screen.dart';

Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName:(context) => const SplashScreen(), 
  HomePage.routeName:(context) => const  HomePage(),
  CovidSearch.routeName:(context) => const CovidSearch(),
  PhoneCheck.routeName: (context) => const PhoneCheck(),
  DnsSearch.routeName:(context) => const DnsSearch(),
  
};