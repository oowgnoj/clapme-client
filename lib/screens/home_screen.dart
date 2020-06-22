import 'package:clapme_client/main.dart';
import 'package:clapme_client/screens/onboarding_screen.dart';
import 'package:clapme_client/screens/login_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return new Stack(
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
            margin: const EdgeInsets.only(top: 40.0),
            child: Center(
                child: Image(image: AssetImage("assets/clapme-icon.png")))),
        Padding(
          padding: const EdgeInsets.only(top: 350.0),
          child: new Center(
              child: Column(
            children: <Widget>[
              ButtonTheme(
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
              ButtonTheme(
                minWidth: 200,
                child: new RaisedButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                    );
                  },
                  child: Text('로그인'),
                ),
              ),
            ],
          )),
        ),
      ],
    );
  }
}
