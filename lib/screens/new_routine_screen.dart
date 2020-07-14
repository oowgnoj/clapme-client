import 'package:flutter/material.dart';

class NewRoutine extends StatefulWidget {
  @override
  _NewRoutineState createState() => new _NewRoutineState();
}

const StrongGrey = Color.fromRGBO(126, 131, 129, 1);
const LightGrey = Color.fromRGBO(242, 242, 242, 1);

class _NewRoutineState extends State<NewRoutine> {
  Widget title = Container(
      child: Text(
    'New Routine',
    style:
        TextStyle(fontSize: 30, color: StrongGrey, fontWeight: FontWeight.bold),
  ));

  Widget routineInput = SizedBox(
      width: 237.0,
      height: 54.0,
      child: const TextField(
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
  Widget submitButton = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: LightGrey,
      ),
      width: 73.0,
      height: 54.0,
      child: Center(child: Text('submit', textAlign: TextAlign.center)));

  Widget timeButton = Container(
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
          children: <Widget>[Text('Time'), Text('0:00 am >')],
        ),
      ));

  Widget descriptionField = Container(
      height: 120.0,
      child: const TextField(
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 60, 25, 20),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          title,
          new Row(
            children: <Widget>[
              routineInput,
              SizedBox(width: 10, height: 30),
              ideasButton
            ],
          ),
          _daysList(),
          Container(
              child: Text(
            'Time best works for you',
            style: TextStyle(
                fontSize: 24, color: StrongGrey, fontWeight: FontWeight.bold),
          )),
          timeButton,
          Container(
              child: Text(
            'Routine color',
            style: TextStyle(
                fontSize: 24, color: StrongGrey, fontWeight: FontWeight.bold),
          )),
          _colorList(),
          descriptionField,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[cancelButton, submitButton],
          )
        ],
      ),
    );
  }
}

Widget _daysList() {
  List<String> _dayslist = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
  return new Container(
      child: Row(
          children: _dayslist
              .map<Widget>((day) => Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        print('hello');
                      },
                      child: new Text(day,
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold)),
                      shape: new CircleBorder(),
                      elevation: 3.0,
                      fillColor: Colors.white,
                      padding: const EdgeInsets.all(9),
                    ),
                  ))
              .toList()));
}

Widget _colorList() {
  List<int> _colorList = [
    0xff0468BF,
    0xff049DBF,
    0xff3B592D,
    0xffD99E6A,
    0xff8C4332,
    0xffD7D7D9,
    0xff184059,
    0xff5D8AA6,
    0xffD99255,
    0xffF2EAC2,
    0xffF28F79,
    0xffD96F32
  ];
  return new Container(
      child: Column(
    children: <Widget>[
      Row(
          children: _colorList
              .sublist(0, 6)
              .map<Widget>((color) => Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        print('hello');
                      },
                      shape: new CircleBorder(),
                      elevation: 3.0,
                      fillColor: Color(color),
                      padding: const EdgeInsets.all(9),
                    ),
                  ))
              .toList()),
      Row(
          children: _colorList
              .sublist(6, 12)
              .map<Widget>((color) => Expanded(
                    child: RawMaterialButton(
                      onPressed: () {
                        print('hello');
                      },
                      shape: new CircleBorder(),
                      elevation: 3.0,
                      fillColor: Color(color),
                      padding: const EdgeInsets.all(9),
                    ),
                  ))
              .toList()),
    ],
  ));
}
