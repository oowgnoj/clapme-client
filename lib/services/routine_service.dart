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

// 루틴 등록

Future<Object> postRoutine(body) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString('accessToken');

  var headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': accessToken
  };

  final response = await http.post(
    server + '/routine',
    headers: headers,
    body: jsonEncode(body),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

// 유저의 모든 루틴 열람
Future<List<Routine>> fetchUserRoutine() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString('accessToken');

  final response = await http
      .get('$server/routine', headers: {"Authorization": accessToken});

  List<Routine> routines = (json.decode(response.body) as List)
      .map((i) => new Routine.fromJson(i))
      .toList();

  return routines;
}

// 루틴 추천 리스트 열람
Future<Object> getRecommendList() async {
  final response = await http.get(server + '/routine-recommend-list');
  if (response.statusCode == 200) {
    var list = json.decode(response.body) as List;
    var res = list.map((el) => RoutineRecommend.fromJson(el)).toList();
    return res;
  }
}
