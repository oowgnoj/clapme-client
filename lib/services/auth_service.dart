import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clapme_client/models/user_model.dart';

var server = 'http://15.164.96.238:5000';

Future<bool> fetchLogin(email, password) async {
  var body = jsonEncode({'email': email, 'password': password});

  final response = await http.post('$server/login',
      body: body, headers: {'Content-Type': "application/json"});

  if (response.statusCode == 200) {
    var decoded = Login.fromJson(json.decode(response.body));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', decoded.accessToken);
    await prefs.setString('username', decoded.username);
    return true;
  } else {
    return false;
  }
}

Future<bool> fetchSignup(email, password, username) async {
  var body =
      jsonEncode({'email': email, 'password': password, 'username': username});

  final response = await http.post('$server/signup',
      body: body, headers: {'Content-Type': "application/json"});
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
