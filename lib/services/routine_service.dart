import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:clapme_client/models/routine_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

var server = 'http://15.164.96.238:5000';
var accessToken =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwidXNlcm5hbWUiOiJ0ZXN0MDQwNCIsImVtYWlsIjoidGVzdDA0MDRAZ21haWwuY29tIiwicHJvZmlsZSI6bnVsbCwicHJvZmlsZV9waWMiOm51bGx9.bglBCdDIwQ5nsSu6c2W7aO6hRHaBvoEISONpYn5oaDE";

Future<List<Routine>> fetchDayRoutine(dayOfWeek) async {
  print('$server/routine/?day_of_week=$dayOfWeek');

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString('accessToken');

  final response = await http.get('$server/routine/?day_of_week=$dayOfWeek',
      headers: {"Authorization": accessToken});

  if (response.statusCode == 200) {
    return (json.decode(response.body) as List)
        .expand((data) =>
            [if (data['$dayOfWeek']) new Routine.fromJson(data)].toList())
        .toList();
  } else {
    print(response.headers);
    var temp = Routine(
        id: 1,
        goalId: 3,
        mon: true,
        tue: false,
        wed: false,
        thu: false,
        fri: false,
        sat: false,
        sun: false,
        timeAt: 200,
        createdAt: '0000-00-00 00:00');
    return [temp];
  }
}
