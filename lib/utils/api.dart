import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:requests/requests.dart';
import 'package:clapme_client/models/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

String localServer = 'http://0.0.0.0:5000';
String stageServer = 'http://15.164.96.238:5000';

Future<Object> getRecommendList() async {
  final response = await Requests.get(localServer + '/routine-recommend-list');
  if (response.statusCode == 200) {
    var list = response.json() as List;
    var res = list.map((el) => Routine.fromJson(el)).toList();
    return res;
  } else {
    print(response.json());
  }
}

Future<Object> postRoutine(body) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString('accessToken');

  var headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': accessToken
  };

  final response = await Requests.post(
    localServer + '/routine/',
    headers: headers,
    body: body,
  );
  if (response.statusCode == 200) {
    print(response.json());
    return true;
  } else {
    print(response.json());
    return false;
  }
}
