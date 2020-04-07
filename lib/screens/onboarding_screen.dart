import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:clapme_client/components/daypicker_component.dart';
import 'package:clapme_client/models/model.dart';
import 'package:clapme_client/utils/api.dart';
import 'package:clapme_client/models/model.dart';

const mainGrey = Color(0xffF2F2F2);
final List<String> stepTitle = <String>[
  '목표 달성에 \n힘이 되어 드릴게요',
  '시간은 언제가\n 좋을까요',
  '반복하고싶은 요일'
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
  String routineTitle;
  Duration alarmTime;

  setGoalName(target) {
    setState(() {
      routineTitle = target;
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
    print(routineTitle);
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
                    color: Colors.grey[500],
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(height: 650, child: RoutineList(setGoalName)),
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
                    onPressed: () async {
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

class RoutineList extends StatefulWidget {
  RoutineList(this.handleState);
  final Function handleState;

  @override
  _RoutineListState createState() => _RoutineListState();
}

class _RoutineListState extends State<RoutineList> {
  int selected;
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getRecommendList(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Container(
                child: Column(
              children: <Widget>[
                Container(
                  height: 500,
                  child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        List<Routine> list = snapshot.data;
                        return GestureDetector(
                          onTap: () {
                            widget.handleState(list[index].title);
                            setState(() {
                              selected = index;
                            });
                          },
                          child: Container(
                              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              padding: EdgeInsets.all(20),
                              color: selected == index
                                  ? Colors.grey[300]
                                  : Color.fromRGBO(241, 241, 241, 50),
                              child: Text(
                                '${list[index].title}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              )),
                        );
                      }),
                ),
                new GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = 100;
                    });
                    _displayDialog(context, widget.handleState);
                  },
                  child: Container(
                    child: Text('사용자 입력',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    padding: EdgeInsets.all(20),
                    color: Color.fromRGBO(241, 241, 241, 10000),
                    height: 70,
                    width: 350,
                  ),
                ),
              ],
            ));
          }
        });
  }
}

_displayDialog(BuildContext context, Function handleState) async {
  final myController = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('user custom routine'),
          content: TextField(
            controller: myController,
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text('SAVE'),
              onPressed: () {
                handleState(myController.text);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}
