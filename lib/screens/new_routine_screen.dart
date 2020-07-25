import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:clapme_client/components/daypicker_component.dart';
import 'package:clapme_client/models/routine_model.dart';
import 'package:clapme_client/services/routine_service.dart';
import 'package:clapme_client/services/idea_service.dart';

const StrongGrey = Color.fromRGBO(126, 131, 129, 1);
const MediumGrey = Color.fromRGBO(109, 109, 109, 1);
const LightGrey = Color.fromRGBO(242, 242, 242, 1);

class NewRoutine extends StatefulWidget {
  @override
  _NewRoutineState createState() => new _NewRoutineState();
}

class _NewRoutineState extends State<NewRoutine> {
  Future<RoutineIdea> randomIdea = fetchRandomIdea();
  Routine routineState;
  String title, description;
  String colorCode;
  bool alarm;
  DateTime alarmTime = DateTime.now();
  Map<String, bool> days = {
    'mon': false,
    'tue': false,
    'wed': false,
    'thu': false,
    'fri': false,
    'sat': false,
    'sun': false
  };

  Widget titleText = Container(
      child: Text(
    'New Routine',
    style:
        TextStyle(fontSize: 30, color: StrongGrey, fontWeight: FontWeight.bold),
  ));

  Widget routineInput(handleTitle) {
    return SizedBox(
        width: 237.0,
        height: 54.0,
        child: TextField(
            onChanged: (txt) {
              handleTitle(txt);
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                ),
                labelText: 'New Routine',
                filled: true,
                fillColor: LightGrey)));
  }

  Widget ideasButton = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: LightGrey,
      ),
      width: 73.0,
      height: 54.0,
      child: Center(
        child: Text(
          '💡 ideas',
          textAlign: TextAlign.center,
        ),
      ));

  Widget cancelButton = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: LightGrey,
      ),
      width: 73.0,
      height: 54.0,
      child: Center(child: Text('cancel', textAlign: TextAlign.center)));

  Widget submitButton() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: LightGrey,
        ),
        width: 73.0,
        height: 54.0,
        child: Center(child: Text('submit', textAlign: TextAlign.center)));
  }

  Widget timeButton(alarmTime) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: LightGrey,
        ),
        width: 350,
        height: 54.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Time'),
              Text(
                '> ' +
                    alarmTime.hour.toString() +
                    ': ' +
                    alarmTime.minute.toString(),
              )
            ],
          ),
        ));
  }

  Widget descriptionField() {
    return Container(
        height: 120.0,
        child: TextField(
            onChanged: (text) {
              handleDescription(text);
            },
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                ),
                labelText: 'Description',
                filled: true,
                fillColor: LightGrey)));
  }

  handleTitle(text) {
    setState(() {
      title = text;
    });
  }

  handleDays(day) {
    setState(() {
      days[day] = !days[day];
    });
  }

  handleAlarmTime(target) {
    setState(() {
      alarmTime = target;
    });
  }

  handleDescription(text) {
    setState(() {
      description = text;
    });
  }

  handleColor(color) {
    setState(() {
      colorCode = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 60, 25, 20),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          titleText,
          new Row(
            children: <Widget>[
              routineInput(handleTitle),
              SizedBox(width: 10, height: 30),
              GestureDetector(
                  onTap: () {
                    routineIdeaSheet(context, this.randomIdea);
                  },
                  child: ideasButton)
            ],
          ),
          _daysList(days, handleDays),
          Container(
              child: Text(
            'Time best works for you',
            style: TextStyle(
                fontSize: 24, color: StrongGrey, fontWeight: FontWeight.bold),
          )),
          GestureDetector(
              onTap: () {
                timePickerSheet(context, handleAlarmTime);
              },
              child: timeButton(this.alarmTime)),
          Container(
              child: Text(
            'Routine color',
            style: TextStyle(
                fontSize: 24, color: StrongGrey, fontWeight: FontWeight.bold),
          )),
          _colorList(handleColor),
          descriptionField(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              cancelButton,
              GestureDetector(
                  onTap: () async {
                    var body = new Routine(
                        title: this.title,
                        color: this.colorCode,
                        mon: this.days['mon'],
                        tue: this.days['tue'],
                        wed: this.days['wed'],
                        thu: this.days['thu'],
                        fri: this.days['fri'],
                        sat: this.days['sat'],
                        sun: this.days['sun'],
                        description: this.description);
                    var answer = await postRoutine(body);
                  },
                  child: submitButton()),
            ],
          )
        ],
      ),
    );
  }
}

Widget _daysList(days, handleDays) {
  List<String> _dayslist = days.keys.toList();
  return new Container(
      child: Row(
          children: _dayslist
              .map<Widget>((day) => Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        handleDays(day.toLowerCase());
                      },
                      child: new Text(day.toUpperCase(),
                          style: TextStyle(
                              color: days[day] ? Colors.black : Colors.grey,
                              fontSize: 11,
                              fontWeight: FontWeight.bold)),
                      shape: new CircleBorder(),
                      elevation: 3.0,
                      fillColor: Colors.white,
                      padding: const EdgeInsets.all(9),
                    ),
                  ))
              .toList()));
}

Widget _colorList(handleColor) {
  return new FutureBuilder<List<RoutineColor>>(
      future: fetchRoutineColor(), // async work
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        } else {
          return new Container(
              child: Column(children: <Widget>[
            Row(
                children: snapshot.data
                    .sublist(0, 6)
                    .map<Widget>((color) => Expanded(
                          child: RawMaterialButton(
                            onPressed: () {
                              handleColor(color.main);
                            },
                            shape: new CircleBorder(),
                            elevation: 3.0,
                            fillColor: Color(int.parse(color.main)),
                            padding: const EdgeInsets.all(9),
                          ),
                        ))
                    .toList()),
            Row(
                children: snapshot.data
                    .sublist(6, 12)
                    .map<Widget>((color) => Expanded(
                          child: RawMaterialButton(
                            onPressed: () {
                              handleColor(color.main);
                            },
                            shape: new CircleBorder(),
                            elevation: 3.0,
                            fillColor: Color(int.parse(color.main)),
                            padding: const EdgeInsets.all(9),
                          ),
                        ))
                    .toList()),
          ]));
        }
      });
}

void timePickerSheet(context, handleAlarmTime) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext bc) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: CupertinoDatePicker(
                backgroundColor: Color.fromRGBO(249, 249, 249, 1),
                mode: CupertinoDatePickerMode.time,
                use24hFormat: false,
                onDateTimeChanged: (DateTime changedTime) {
                  handleAlarmTime(changedTime);
                }));
      });
}

void routineIdeaSheet(context, randomIdea) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext bc) {
        return FutureBuilder<RoutineIdea>(
            future: randomIdea,
            builder: (context, AsyncSnapshot<RoutineIdea> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return Container(
                child: new Wrap(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: LightGrey,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 20),
                          Text(
                            '💡 ideas',
                            style: TextStyle(
                                fontSize: 30,
                                color: StrongGrey,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      snapshot.data.title,
                                      style: TextStyle(
                                          fontSize: 21, color: StrongGrey),
                                    ),
                                    Image.network(
                                      snapshot.data.picUrl,
                                    ),
                                    Text(
                                      snapshot.data.contents,
                                      style: TextStyle(
                                          fontSize: 12, color: StrongGrey),
                                    ),
                                  ]))
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      });
}
