import 'package:clapme_client/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/main-background.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        new Container(
            height: 300,
            child: Center(
                child: Image(image: AssetImage("assets/clapme-icon.png")))),
        new Center(
          child: ButtonTheme(
            minWidth: 200,
            child: new RaisedButton(
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Onboarding(),
                  ),
                );
              },
              child: Text('clapme 시작하기'),
            ),
          ),
        )
      ],
    ));
  }
}
