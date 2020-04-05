import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:clapme_client/components/recommendList.dart';
import 'package:clapme_client/components/daypicker_component.dart';

const mainGrey = Color(0xffF2F2F2);
final List<String> stepTitle = <String>[
  '목표 달성에 \n힘이 되어 드릴게요',
  '시간은 언제가\n 좋을까요',
  '반복하고싶은 요일'
];

final List<String> recommendList = <String>[
  '독서',
  '운동',
  '명상',
  '산책',
  '요가',
  '영양제'
];

final List<String> dayList = <String>['월', '화', '수', '목', '금', '토', '일'];

class Onboarding extends StatefulWidget {
  int stepIndex;
  Duration alarmTime;

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentPage = 0;
  Duration alarmTime;
  String goalName;
  Widget content;

  setGoalName(target) {
    setState(() {
      goalName = target;
    });
  }

  setAlarmTime(target) {
    setState(() {
      alarmTime = target;
    });
  }

  @override
  void initState() {
    super.initState();
  }

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
                stepTitle[currentPage],
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(height: 500, child: content),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.40,
                  child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        currentPage = currentPage - 1;
                      });
                    },
                    child: Text('뒤로가기'),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.40,
                  child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        currentPage = currentPage + 1;
                      });
                    },
                    child: Text('다음으로'),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
