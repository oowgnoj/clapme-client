import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clapme_client/theme/color_theme.dart';

import 'dart:ui' as ui;

class MyPage extends StatefulWidget {
  MyPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyPageState createState() => new _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return FutureBuilder(
        future: getInfo(),
        builder: (context, snapshot) {
          return new Stack(
            children: <Widget>[
              new Container(
                color: Clapme_green,
              ),
              new Image.network(
                snapshot.data['pic'],
                fit: BoxFit.fill,
              ),
              new BackdropFilter(
                  filter: new ui.ImageFilter.blur(
                    sigmaX: 6.0,
                    sigmaY: 6.0,
                  ),
                  child: new Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.9),
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                  )),
              new Scaffold(
                  backgroundColor: Clapme_green,
                  body: new Center(
                    child: new Column(
                      children: <Widget>[
                        new SizedBox(
                          height: _height / 12,
                        ),
                        new Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              new FlatButton(
                                padding: EdgeInsets.only(
                                    left: _width / 1.5, right: 0),
                                onPressed: () async {
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  preferences.clear();
                                  Navigator.of(context).pushNamed('/');
                                },
                                child: new Icon(Icons.settings,
                                    color: Colors.white60, size: 23),
                              ),
                              new FlatButton(
                                padding: EdgeInsets.only(left: 0),
                                onPressed: () async {
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  preferences.clear();
                                  Navigator.of(context).pushNamed('/');
                                },
                                child: new Icon(Icons.exit_to_app,
                                    color: Colors.white60, size: 23),
                              ),
                            ]),
                        new CircleAvatar(
                          radius: _width < _height ? _width / 4 : _height / 4,
                          backgroundImage: NetworkImage(
                            snapshot.data['pic'],
                          ),
                        ),
                        new SizedBox(
                          height: _height / 50.0,
                        ),
                        new SizedBox(
                          height: _height / 50.0,
                        ),
                        new Text(
                          snapshot.data['username'],
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: _width / 15,
                              color: Colors.white),
                        ),
                        new Padding(
                          padding: new EdgeInsets.only(
                              top: _height / 30,
                              left: _width / 8,
                              right: _width / 8),
                          child: new Text(
                            snapshot.data['profile'],
                            style: new TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: _width / 25,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        new Divider(
                          height: _height / 30,
                          color: Colors.white,
                        ),
                        new Row(
                          children: <Widget>[
                            rowCell(10, 'ROUTINES'),
                            rowCell(3, 'GOALS'),
                            rowCell(626, 'CLAP'),
                          ],
                        ),
                        new Divider(height: _height / 30, color: Colors.white),
                        new SizedBox(height: _height / 10),
                      ],
                    ),
                  ))
            ],
          );
        });
  }

  Widget rowCell(int count, String type) => new Expanded(
          child: new Column(
        children: <Widget>[
          new Text(
            '$count',
            style: new TextStyle(color: Colors.white),
          ),
          new Text(type,
              style: new TextStyle(
                  color: Colors.white, fontWeight: FontWeight.normal))
        ],
      ));
}

Future getInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String username = prefs.getString('username') == null
      ? 'hershey'
      : prefs.getString('username');
  String profile = prefs.getString('profile') == null
      ? 'ga na da ra ma ba sa'
      : prefs.getString('profile');
  String profilePic = prefs.getString('profilePic') == null
      ? 'https://mir-s3-cdn-cf.behance.net/project_modules/fs/d1c64938267389.575aefd5063e6.png'
      : prefs.getString('profilePic');

  Map<String, String> result = {
    'username': username,
    'profile': profile,
    'pic': profilePic
  };

  return result;
}
