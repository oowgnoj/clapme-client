import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:clapme_client/models/goal_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// var server = 'http://15.164.96.238:5000';
var server = 'http://0.0.0.0:5000';

Future<Goal> fetchGoalDetail(id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final response = await http.get('$server/goal/$id');

  Goal goal = Goal.fromJson(json.decode(response.body));

  return goal;
}

// 유저의 모든 목표 열람
Future<List<Goal>> fetchUserGoalList(status) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString('accessToken');
  final response = await http.get('$server/user-goal?type=$status',
      headers: {"Authorization": accessToken});

  List<Goal> userGoalList = (json.decode(response.body) as List)
      .map((i) => new Goal.fromJson(i))
      .toList();

  return userGoalList;
}
