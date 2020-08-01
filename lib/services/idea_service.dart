import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:clapme_client/models/routine_model.dart';

var server = 'http://15.164.96.238:5000';

Future<RoutineIdea> fetchRandomIdea() async {
  final accessToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwidXNlcm5hbWUiOiJteW5zbWFlaXMiLCJlbWFpbCI6ImhlbGxvQGdtYWlsLmNvbSIsInByb2ZpbGUiOm51bGwsInBpY191cmwiOm51bGx9.O2dKwUdOjVrQBnkUNJIupUoo5wrv6tiTYzjtRN6LwHA';
  var headers = <String, String>{'Authorization': accessToken};
  var response = await http.get('$server/idea?type=random', headers: headers);
  var randomIdea = RoutineIdea.fromJson(json.decode(response.body));
  return randomIdea;
}
