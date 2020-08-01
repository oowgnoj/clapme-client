import 'package:flutter/material.dart';

class MainScrren extends StatefulWidget {
  @override
  _MainScrren createState() => new _MainScrren();
}

class _MainScrren extends State<MainScrren> {
  String name = 'jongwoo';

  Widget _header() {
    return Container(
        child: Row(
      children: <Widget>[Text('Clapme'), Icon(Icons.vertical_align_bottom)],
    ));
  }

  Widget _welcomeMsg() {
    return Container(child: Text(name + ' 오늘의 성취를 공유해주세요'));
  }

  Widget _goal_slide() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 200.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
              width: 160.0,
              color: Colors.red,
            ),
            Container(
              width: 160.0,
              color: Colors.blue,
            ),
            Container(
              width: 160.0,
              color: Colors.green,
            ),
            Container(
              width: 160.0,
              color: Colors.yellow,
            ),
            Container(
              width: 160.0,
              color: Colors.orange,
            ),
          ],
        ));
  }

  Widget _success_slide() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 200.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
              width: 160.0,
              color: Colors.red,
            ),
            Container(
              width: 160.0,
              color: Colors.blue,
            ),
            Container(
              width: 160.0,
              color: Colors.green,
            ),
            Container(
              width: 160.0,
              color: Colors.yellow,
            ),
            Container(
              width: 160.0,
              color: Colors.orange,
            ),
          ],
        ));
  }

  @override
  build(BuildContext context) {
    return new Scaffold(
        body: Column(
      children: <Widget>[
        SizedBox(height: 20),
        _header(),
        SizedBox(height: 20),
        _welcomeMsg(),
        SizedBox(height: 20),
        _goal_slide(),
        SizedBox(height: 20),
        _success_slide()
      ],
    ));
  }
}
