import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:clapme_client/components/greyList_component.dart';
import 'package:clapme_client/components/daypicker_component.dart';

const mainGrey = Color(0xffF2F2F2);

final List<String> recommendList = <String>[
  '독서',
  '운동',
  '명상',
  '산책',
  '요가',
  '영양제'
];

class Onboarding extends StatefulWidget {
  int stepIndex;
  Duration alarmTime;

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int stepIndex = 0;
  Duration alarmTime;

  int setAlarmTime = 3;
  @override
  List<Map<String, dynamic>> contents = [
    {
      'title': '목표 달성에 \n힘이 되어 드릴게요',
      'content': RecommendList(list: recommendList, mainColor: mainGrey)
    },
    {'title': '시간은 언제가 좋을까요', 'content': TimePicker()}
  ];
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Onboarding',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: new Scaffold(
        appBar: AppBar(
          title: Text('Onboarding'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                contents[stepIndex]['title'],
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(height: 500, child: contents[stepIndex]['content']),
            SizedBox(
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    stepIndex = stepIndex - 1;
                  });
                },
                child: Text('-'),
              ),
            ),
            SizedBox(
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    stepIndex = stepIndex + 1;
                  });
                },
                child: Text('+'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
