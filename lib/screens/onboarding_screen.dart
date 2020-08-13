import 'package:flutter/material.dart';
import 'package:clapme_client/components/daypicker_component.dart';

import 'package:clapme_client/models/routine_model.dart';
import 'package:clapme_client/services/routine_service.dart';
import 'package:clapme_client/utils/common_func.dart';
import 'package:clapme_client/theme/color_theme.dart';

final List<String> stepTitle = <String>[
  '목표 달성에 \n힘이 되어 드릴게요',
  '시간은 언제가\n 좋을까요',
  '반복하고싶은 요일',
  '일정 등록'
];
final List<String> dayList = <String>[
  'mon',
  'tue',
  'wed',
  'thu',
  'fri',
  'sat',
  'sun'
];

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentPage = 0;
  String routineTitle = 'custom';
  DateTime alarmTime = DateTime.now();

  List pageInputValidator = [false, false, false, false];

  Map<String, dynamic> alarmDays = {
    'mon': false,
    'tue': false,
    'wed': false,
    'thu': false,
    'fri': false,
    'sat': false,
    'sun': false
  };

  setGoalName(target) {
    setState(() {
      pageInputValidator[0] = true;
      routineTitle = target;
    });
  }

  setAlarmTime(target) {
    setState(() {
      pageInputValidator[1] = true;
      alarmTime = target;
    });
  }

  setAlarmDays(target) {
    setState(() {
      pageInputValidator[2] = true;
    });
    switch (target) {
      case 'weekdays':
        setState(() {
          alarmDays['mon'] = true;
          alarmDays['tue'] = true;
          alarmDays['wed'] = true;
          alarmDays['thu'] = true;
          alarmDays['fri'] = true;
          alarmDays['sat'] = false;
          alarmDays['sun'] = false;
        });
        break;
      case 'weekends':
        setState(() {
          alarmDays['mon'] = false;
          alarmDays['tue'] = false;
          alarmDays['wed'] = false;
          alarmDays['thu'] = false;
          alarmDays['fri'] = false;
          alarmDays['sat'] = true;
          alarmDays['sun'] = true;
        });
        break;
      case 'reset':
        setState(() {
          alarmDays['mon'] = false;
          alarmDays['tue'] = false;
          alarmDays['wed'] = false;
          alarmDays['thu'] = false;
          alarmDays['fri'] = false;
          alarmDays['sat'] = false;
          alarmDays['sun'] = false;
        });
        break;
      default:
        setState(() {
          alarmDays[target] = !alarmDays[target];
        });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    Map<String, String> body = {
      'title': routineTitle,
      'time_at': alarmTime.hour.toString() + alarmTime.minute.toString(),
      'mon': alarmDays['mon'].toString(),
      'tue': alarmDays['tue'].toString(),
      'wed': alarmDays['wed'].toString(),
      'thu': alarmDays['thu'].toString(),
      'fri': alarmDays['fri'].toString(),
      'sat': alarmDays['sat'].toString(),
      'sun': alarmDays['sun'].toString()
    };

    var ButtonPrevious = SizedBox(
      width: MediaQuery.of(context).size.width * 0.40,
      height: 40,
      child: RawMaterialButton(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
        fillColor: StrongGreen,
        onPressed: () {
          if (currentPage == 0) {
            Navigator.of(context).pop();
          } else {
            setState(() {
              currentPage = currentPage - 1;
            });
          }
        },
        child: Text(
          '뒤로가기',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
    );
    var ButtonNext = SizedBox(
      width: MediaQuery.of(context).size.width * 0.40,
      height: 40,
      child: RawMaterialButton(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
        fillColor: StrongGreen,
        // onPressed: () async {
        //   // routine post page
        //   if (currentPage == 3) {
        //     bool isPostSuccess = await postRoutine(body);
        //     if (isPostSuccess) {
        //       Navigator.of(context).pushNamed('/routinelist');
        //     } else {
        //       Alert(
        //               context: context,
        //               type: AlertType.none,
        //               style: alertFailedStyle,
        //               title: "등록 실패 🤔",
        //               desc: "다시 시도해주세요")
        //           .show();
        //     }
        //   } else {
        //     if (pageInputValidator[currentPage]) {
        //       setState(() {
        //         currentPage = currentPage + 1;
        //       });
        //     } else {
        //       Alert(
        //               context: context,
        //               type: AlertType.none,
        //               style: alertFailedStyle,
        //               title: "입력해주세요 ⭐️")
        //           .show();
        //     }
        //   }
        // },
        child: Text(
          '다음으로',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
    );
    return new Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Text(
              stepTitle[currentPage],
              style: TextStyle(
                  color: MediumGrey, fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: currentPage == 0
                  ? RoutineList(setGoalName, routineTitle)
                  : currentPage == 1 // 시간 설정
                      ? TimePicker(setAlarmTime: setAlarmTime)
                      : currentPage == 2 // 요일 설정
                          ? _DaysList(setAlarmDays, alarmDays)
                          : ConfirmPage(routineTitle, alarmTime, alarmDays)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[ButtonPrevious, ButtonNext],
          ),
        ],
      ),
    );
  }
}

class RoutineList extends StatefulWidget {
  RoutineList(this.handleState, this.routineTitle);
  final Function handleState;
  final String routineTitle;

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
            return SingleChildScrollView(
              child: new Container(
                  child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          List<RoutineRecommend> list = snapshot.data;
                          return GestureDetector(
                            onTap: () {
                              // widget.handleState(list[index].title);
                              setState(() {
                                selected = index;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              padding: EdgeInsets.fromLTRB(0, 20, 20, 20),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: selected == index
                                              ? StrongGreen
                                              : LightGrey))),
                              // child: Text(
                              // '${list[index].title}',
                              //   style: TextStyle(
                              //       fontWeight: FontWeight.bold,
                              //       fontSize: 20),
                              // )
                            ),
                          );
                        }),
                  ),
                  new GestureDetector(
                    onTap: () {
                      _displayDialog(context, widget.handleState);
                      setState(() {
                        selected = 100;
                      });
                    },
                    child: Container(
                      child: Text(
                          selected == 100 ? widget.routineTitle : 'custom',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      padding: EdgeInsets.fromLTRB(8, 20, 20, 20),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: LightGrey))),
                      height: 70,
                      width: 350,
                    ),
                  ),
                ],
              )),
            );
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

class _DaysList extends StatefulWidget {
  _DaysList(this.setAlarmDays, this.alarmDays);
  final Function setAlarmDays;
  final Map<String, dynamic> alarmDays;

  @override
  __DaysListState createState() => __DaysListState();
}

class __DaysListState extends State<_DaysList> {
  List<String> _dayslist = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'];
  List<String> _shortcutList = ['weekdays', 'weekends', 'reset'];

  Map<String, dynamic> colorMap = {'on': LightGrey, 'off': Colors.white};

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            child: Row(
                children: _dayslist
                    .map<Widget>((day) => Expanded(
                          child: RawMaterialButton(
                            onPressed: () {
                              widget.setAlarmDays(day);
                            },
                            child:
                                new Text(day, style: TextStyle(fontSize: 11)),
                            shape: new CircleBorder(),
                            elevation: 3.0,
                            fillColor: widget.alarmDays[day] == true
                                ? LightGrey
                                : Colors.white,
                            padding: const EdgeInsets.all(15),
                          ),
                        ))
                    .toList())),

        // 평일, 주말 등 단축키
        Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _shortcutList
                    .map<Widget>((shortcut) => Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: ButtonTheme(
                            minWidth: 200,
                            child: RawMaterialButton(
                              onPressed: () {
                                widget.setAlarmDays(shortcut);
                              },
                              child: new Text(shortcut,
                                  style: TextStyle(fontSize: 12)),
                              shape: new RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              fillColor: LightGrey,
                            ),
                          ),
                        ))
                    .toList())),
      ],
    );
  }
}

class ConfirmPage extends StatelessWidget {
  ConfirmPage(this.routineTitle, this.alarmTime, this.alarmDays);
  final routineTitle;
  final alarmTime;
  final alarmDays;

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      color: Color(0xFFD3D3D3),
      fontWeight: FontWeight.bold,
      fontSize: 30,
      decoration: TextDecoration.underline,
    );
    return (new Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
          child: new Container(
              padding: EdgeInsets.fromLTRB(0, 30, 30, 30),
              child: Container(
                child: new Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          convertDayBooltoStr(alarmDays),
                          style: textStyle,
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        Text(
                          alarmTime.hour.toString() +
                              ":" +
                              alarmTime.minute.toString(),
                          style: textStyle,
                        ),
                        Text(
                          ' 에',
                          style: TextStyle(color: Colors.black, fontSize: 30),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        Text(routineTitle, style: textStyle),
                        Text(
                          ' 를/을 ',
                          style: TextStyle(color: Colors.black, fontSize: 30),
                        )
                      ],
                    ),
                    SizedBox(height: 50),
                    Row(
                      children: <Widget>[
                        Text(
                          '실천할거에요!',
                          style: TextStyle(color: Colors.black, fontSize: 30),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        )
      ],
    ));
  }
}
