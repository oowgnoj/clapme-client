import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:clapme_client/models/routine_model.dart';

var server = 'http://clapme.server.com';
var date = DateTime.now();
var dayOfWeek = DateFormat('EEEE').format(date); // Tuesday

Future<List> fetchDayRoutine() async {
  final response = await http.get('$server/routine/$dayOfWeek');

  if (response.statusCode == 200) {
    return (json.decode(response.body) as List)
        .map((data) => new Routine.fromJson(data)).toList();
  } else {
    var temp = Routine(
        id: 1,
        userId: 2,
        goalId: 3,
        title: '샘플 루틴 from response error',
        mon: true,
        tue: false,
        wed: false,
        thu: false,
        fri: false,
        sat: false,
        sun: false,
        timeAt: 200,
        createdAt: DateTime.now()
    );
    return [temp];
  }
}