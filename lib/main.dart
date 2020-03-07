import 'package:flutter/material.dart';
import 'package:clapme_client/screens/home_screen.dart';

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: HomeScreen(),
  ));
}

final routes = {'/': (BuildContext context) => HomeScreen};
