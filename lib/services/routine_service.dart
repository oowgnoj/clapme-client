import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:clapme_client/models/routine_model.dart';
import 'package:clapme_client/services/alarm_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

var server = 'http://15.164.96.238:5000';

Future<List<Routine>> fetchDayRoutine(dayOfWeek) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString('accessToken');

  final response = await http.get('$server/routine?day_of_week=$dayOfWeek',
      headers: {"Authorization": accessToken});

  if (response.statusCode == 200) {
    List<Routine> routines = (json.decode(response.body) as List)
        .map((i) => new Routine.fromJson(i))
        .toList();

    await setWeeklyPush(routines);

    return routines;
  } else {
    var temp = Routine(
        id: 1,
        goalId: 3,
        title: '안녕?',
        mon: true,
        tue: false,
        wed: false,
        thu: false,
        fri: false,
        sat: false,
        sun: false,
        timeAt: 200);
    // createdAt: '0000-00-00 00:00');
    return [temp];
  }
}
