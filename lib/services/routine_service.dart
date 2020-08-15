import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:clapme_client/models/routine_model.dart';
import 'package:clapme_client/services/alarm_service.dart';
import 'package:clapme_client/utils/common_func.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:clapme_client/utils/api_helper.dart';

var server = 'http://15.164.96.238:5000';

// 루틴 등록
Future<Object> postRoutine(Routine body) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString('accessToken');
  var headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': accessToken
  };
  var jsonBody = json.encode(body.toJson());
  print(jsonBody);
  final response = await http.post(
    server + '/routine',
    headers: headers,
    body: jsonBody,
  );
  if (response.statusCode == 200) {
    // 알람 등록
    var result = json.decode(response.body);
    int id = result['id'];
    Routine routine = Routine.fromJson(result);

    AlarmService alarmService = AlarmService();
    alarmService.setWeeklyAlarms(id, routine);

    return true;
  } else {
    return false;
  }
}

Future<List<RoutineColor>> fetchRoutineColor() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString('accessToken');

  var headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': accessToken
  };
  var response = await http.get('$server/routine-materials', headers: headers);
  var routineMaterial = RoutineMaterial.fromJson(json.decode(response.body));
  return routineMaterial.routineColor;
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
  final response = await http.get(server + '/routine-materials');
  if (response.statusCode == 200) {
    var list = json.decode(response.body) as List;
    var res = list.map((el) => RoutineRecommend.fromJson(el)).toList();
    return res;
  }
}

class RoutineService {
  ApiHelper _api = ApiHelper();

  Future<List<Routine>> getRoutines() async {

    final response = await this._api.get('routines');

    if (response.statusCode == 200) {
      var result = json.decode(response.body);

      List<Routine> routines = [];
      result.forEach((r) => routines.add(Routine.fromJson(r)));

      return routines;
    } else {
      String message = 'Network Error, Please try again.';

      if (response.statusCode == 401)
        message = 'Your session has timed out. Please login again.';

      throw Exception(message);
    }
  }
}

// Future<List<Routine>> fetchDayRoutine(dayOfWeek) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String accessToken = prefs.getString('accessToken');

//   final response = await http.get('$server/routine?day_of_week=$dayOfWeek',
//       headers: {"Authorization": accessToken});

//   if (response.statusCode == 200) {
//     List<Routine> routines = (json.decode(response.body) as List)
//         .map((i) => new Routine.fromJson(i))
//         .toList();

//     await setWeeklyPush(routines);

//     return routines;
//   } else {
//     var temp = Routine(
//         id: 1,
//         goalId: 3,
//         title: '안녕?',
//         mon: true,
//         tue: false,
//         wed: false,
//         thu: false,
//         fri: false,
//         sat: false,
//         sun: false,
//         timeAt: 200);
//     // createdAt: '0000-00-00 00:00');
//     return [temp];
//   }
// }
