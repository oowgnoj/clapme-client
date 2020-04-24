import 'package:flutter/material.dart';
import 'package:clapme_client/screens/home_screen.dart';
import 'package:clapme_client/screens/login_screen.dart';
import 'package:clapme_client/screens/signup_screen.dart';
import 'package:clapme_client/screens/onboarding_screen.dart';

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: HomeScreen(),
    routes: <String, WidgetBuilder>{
      '/signup': (BuildContext context) => new Signup(),
      '/login': (BuildContext context) => new Login(),
      '/onboarding': (BuildContext context) => new Onboarding(),
    },
  ));
}

final routes = {'/': (BuildContext context) => HomeScreen};
