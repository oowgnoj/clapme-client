import 'package:clapme_client/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('root page'),
        ),
        body: Center(
          child: RaisedButton(
            child: Text('go to onboarding page'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Onboarding()),
              );
            },
          ),
        ));
  }
}
