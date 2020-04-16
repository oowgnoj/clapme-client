import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:requests/requests.dart';
import 'package:clapme_client/models/model.dart';

String localServer = 'http://0.0.0.0:5000';
String stageServer = 'http://192.168.35.248:5000';

Future<Object> getRecommendList() async {
  const headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  final response = await Requests.get(localServer + '/routine-recommend-list');
  if (response.statusCode == 200) {
    var list = response.json() as List;
    var res = list.map((el) => Routine.fromJson(el)).toList();
    print(res);
    return res;
  } else {
    print(response.json());
  }
}
