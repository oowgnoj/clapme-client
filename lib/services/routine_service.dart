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
    var temp = new Routine();
    temp.id = 1;
    temp.userId = 2;
    temp.goalId = 3;
    temp.title = '샘플 루틴';
    temp.mon = true;
    temp.tue = false;
    temp.wed = false;
    temp.thu = false;
    temp.fri = false;
    temp.sat = false;
    temp.sun = false;
    temp.timeAt = 200;
    return [temp];
  }
}