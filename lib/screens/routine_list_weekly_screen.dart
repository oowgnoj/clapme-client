import 'package:flutter/material.dart';
import 'package:clapme_client/models/schedule_model.dart';
import 'package:clapme_client/models/routine_model.dart';
import 'package:clapme_client/services/routine_service.dart';
import 'package:flutter/foundation.dart';

class RoutineListWeekly extends StatefulWidget {
  final Schedule schedule;
  RoutineListWeekly({Key key, @required this.schedule}) : super(key: key);

  @override
  _RoutineListWeeklyState createState() => _RoutineListWeeklyState();
}

class _RoutineListWeeklyState extends State<RoutineListWeekly> {
  Future<List<Routine>> userRoutines;

  @override
  initState() {
    super.initState();
    userRoutines = fetchUserRoutine();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
          title: const Text(
            'weekly routine',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: FutureBuilder(
            future: userRoutines,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(20.0),
                    child: _createTable(snapshot.data));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}

Widget _createDay(day) {
  return Container(
      width: 30,
      child: Text(
        day,
        style: TextStyle(fontWeight: FontWeight.bold),
      ));
}

Widget _createCheckMark(day) {
  return Container(
      width: 30, child: day ? Icon(Icons.done) : Icon(Icons.remove));
}

// Table 생성 함수, snapshot 데이터 받아 테이블 생성
Widget _createTable(routines) {
  List<TableRow> rows = [];
  // 테이블 header 추가
  rows.add(TableRow(children: [
    Row(children: [
      Container(width: 110, child: Text('title')),
      _createDay('월'),
      _createDay('화'),
      _createDay('수'),
      _createDay('목'),
      _createDay('금'),
      _createDay('토'),
      _createDay('일'),
    ])
  ]));
  routines.forEach((routine) => {
        rows.add(TableRow(children: [
          Row(children: [
            Container(width: 100, child: Text(routine.title)),
            _createCheckMark(routine.mon),
            _createCheckMark(routine.tue),
            _createCheckMark(routine.wed),
            _createCheckMark(routine.thu),
            _createCheckMark(routine.fri),
            _createCheckMark(routine.sat),
            _createCheckMark(routine.sun),
          ])
        ]))
      });

  return Table(children: rows);
}
