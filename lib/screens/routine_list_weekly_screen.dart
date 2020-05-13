import 'dart:collection';
import 'package:flutter/scheduler.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

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
        body: FutureBuilder(
            future: userRoutines,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(20.0),
                  child: Table(
                    border: TableBorder.all(color: Colors.black),
                    children: [
                      TableRow(children: [
                        Text('Cell 1'),
                        Text('Cell 2'),
                        Text('Cell 3'),
                      ]),
                      TableRow(children: [
                        Text('Cell 4'),
                        Text('Cell 5'),
                        Text('Cell 6'),
                      ])
                    ],
                  ),
                );
              } else {
                return Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(20.0),
                  child: Table(
                    border: TableBorder.all(color: Colors.black),
                    children: [
                      TableRow(children: [
                        Text('no 1'),
                        Text('no 2'),
                        Text('no 3'),
                      ]),
                      TableRow(children: [
                        Text('no 4'),
                        Text('no 5'),
                        Text('no 6'),
                      ])
                    ],
                  ),
                );
              }
            }));
  }
}
